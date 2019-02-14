#!/bin/bash

set -e

echo $(aws ssm get-parameters-by-path  --path /app/${ENVIRONMENT}/ --region=${REGION}\
| jq -r '.Parameters| .[] |  .Name + "=\"" + .Value + "\""  '  \
| sed -e "s~/app/${ENVIRONMENT}/~~")
