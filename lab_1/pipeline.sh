#!/bin/bash

# create new file
touch "pipeline-$(date +%Y-%M-%d).json"

# remove metadata
# jq '.pipeline'