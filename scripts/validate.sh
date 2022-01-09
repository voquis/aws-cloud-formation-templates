#!/bin/bash
set -euo pipefail

# Find all template files and run AWS validation
find templates \
  -name \*.yml \
  -exec aws cloudformation validate-template --template-body file://{} --output=text \;
