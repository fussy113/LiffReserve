#!/bin/sh

if [[ "$1" == "lint" ]]; then
  echo "#######################"
  echo "# Running Lint"
  yarn lint

elif [[ "$1" == "test" ]]; then
  echo "#######################"
  echo "# Running Test"
  yarn test
else
  echo "#######################"
  echo "# Running Dev"
  yarn dev
fi