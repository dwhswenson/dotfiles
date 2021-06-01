# In .xxrun files in any directory, add any environment configuration
# specific to that directory and subdirectories.
#
# In XXDIR, add any session-wide environment configs (and sometimes a cd to
# the appropriate directory).
#
# Enable by sourcing this file. Add automatic support on cd by aliasing cd
# to xxcd. Disable within a session by setting XXENABLED to something other
# than 1.

if [ -z "$XXDIR" ]; then
    export XXDIR=${HOME}/.xxconfigs
fi

if [ -z "$XXENABLED" ]; then
    export XXENABLED=1
fi

function xx {
    if [ $# -eq 0 ]; then
        local xxrun=$(xxfind)
        if [ -f "$xxrun" ]; then
            source $xxrun
        fi
    else
        source ${XXDIR}/$1
    fi
}

function xxfind {
python3 <<EOM
from pathlib import Path
cwd = Path.cwd()
result = None
while result is None:
    trial = cwd / '.xxrun'
    if trial.exists():
        result = trial
    if cwd == cwd.parent:
        result = ""
    cwd = cwd.parent
print(result)
EOM
}

function xxcd {
    # when you cd to a directory
    builtin cd $@
    if [ "$XXENABLED" = "1" ]; then
        xx
    fi
}

# when you open a new terminal
if [ "$XXENABLED" = "1" ]; then
    xx
fi
