#!/bin/bash -i

# Create and activate a conda environment
#
# This script creates a conda environment and then automatically activates
# it. I still can't believe this isn't an option in `conda create`.
#
# Usage: Create an alias that sources this script. Arguments are as you
# would use for `conda create`.

ENV_NAME=$($CONDA_PYTHON_EXE << EOM
from conda.cli.main import generate_parser
args = "create $@".split()
parser= generate_parser()
try:
    args = parser.parse_args(args)
except SystemExit:
    exit(85)  # arbitrary exit code I can catch
else:
    print(args.name)
EOM
)
result_code=$?

# TODO: `cca --whatever` doesn't preserve exit code or string
case $result_code in
    0)
        conda create $@ && conda activate $ENV_NAME
        ;;
    85)
        # either -h was called or should have been (bad input to parser)
        echo "$ENV_NAME"
        ;;
    *)
        echo $ENV_NAME
        exit $result_code
        ;;
esac
