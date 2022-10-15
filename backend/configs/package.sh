#!/bin/bash

mkdir zipped

cd dist

# get all folder list
dirs=$(ls -d */ | cut -f1 -d'/')

for var in ${dirs[@]}
do
  # zip command
  cmd="zip ../zipped/${var}.zip ${var}/*"
  
  # zip file
  eval ${cmd}
done