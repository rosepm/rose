#!/bin/bash

DIRS=(*/)

echo ">> Creating test images"
echo ">>---------------------------------------"

for d in "${DIRS[@]}"
do
  img="${d%/}"
  echo "- Creating image '${img}'"
  cd $d
  docker build -t="${img}" .
  cd .. 
  echo "+ ---------------------------------DONE: ${img}"
  echo "..."
done
