#!/bin/bash -i

# Create and activate a conda environment
#
# This script creates a conda environment and then automatically activates
# it. I still can't believe this isn't an option in `conda create`.
#
# If there are certain packages you always want installed in a new
# environment (pytest, ipykernel) you can put those in a file called
# ~/.conda-env-defaults.txt.
#
# Usage: Create an alias that sources this script. Arguments are as you
# would use for `conda create`.

# use mamba if it is available
if command -v mamba &> /dev/null; then
    _CONDA=mamba
else
    _CONDA=conda
fi

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
        if [ -f ~/.conda-env-defaults.txt ]; then
            prefix=("--file" ~/.conda-env-defaults.txt)
        else
            prefix=
        fi
        $_CONDA create ${prefix[@]} $@ && conda activate $ENV_NAME
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
