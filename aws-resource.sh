#!/bin/bash

if [ $# -ne 2 ]
then 
    echo "please give 2 arguments"
    exit 1
fi

aws_region=#1
aws_resource=#2

if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi