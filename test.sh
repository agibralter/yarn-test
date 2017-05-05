#!/usr/bin/env bash

rm -rf node_modules
rm -rf yarn.lock
rm -rf vendor/npm_cache

npm rm -g yarn
npm install -g yarn@0.23.4

echo "initial install"
yarn cache clean
yarn

rm -rf node_modules

echo "offline install"
yarn cache clean
yarn --offline

