#!/bin/bash

echo "Starting..."
START="$(date +%s)"

bash scripts/examples/giraffe.sh

END="$(date +%s)"
DURATION=$[ ${END} - ${START} ]
echo "Completed g.sh in ${DURATION} seconds."
