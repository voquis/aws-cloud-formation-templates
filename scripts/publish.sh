#!/bin/bash
set -euo pipefail

# Sync local templates directory with remote build bucketdirectory
aws s3 sync templates s3://voquis/aws/cloudformation/templates
