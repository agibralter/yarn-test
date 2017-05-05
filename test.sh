#!/usr/bin/env bash

npm rm -g yarn 2>/dev/null
npm install -g yarn@0.23.4 2>/dev/null

rm -rf node_modules
rm -rf yarn.lock
rm -rf vendor/npm_cache

function test() {
    cp .yarnrc-$1 .yarnrc
    cp package-$2.json package.json

    # echo ""
    # echo "initial install"
    # yarn cache clean
    # yarn

    # rm -rf node_modules

    # echo ""
    # echo "offline install"
    # yarn cache clean
    # yarn --offline

    rm -rf package.json
    rm -rf .yarnrc
}

test "with-pruning" "simple"
test "without-pruning" "simple"

test "with-pruning" "git"
test "without-pruning" "git"

test "with-pruning" "with-npm-scope"
test "without-pruning" "with-npm-scope"
