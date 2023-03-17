#!/bin/bash
type jq >/dev/null 2>&1
if [[ $? -ne 0 ]]
then 
    printf "'jq' not found!\n"
    printf "Ubuntu Installation: sudo apt install jq\n"
    printf "    Redhat Installation: sudo yum install jq\n"
    exit 1
fi

PIPELINE_TEMPL=""
if [[ ! -f $1 ]]
then exit 1
else
  PIPELINE_TEMPL=$1
  shift
fi

# create new file
FILE_NAME="pipeline-$(date +%Y-%M-%d).json"
touch "$FILE_NAME"

VALID_ARGS=$(getopt -o b:o:phc --long branch:,owner:,configuration:,help,poll-for-source-changes -- "$@")
#VALID_ARGS=$(getopt -o abg:d: --long alpha,beta,gamma:,delta: -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi
BRANCH="main";
OWNER="John Doe";
CONFIGURATION=""
SHOULD_POLL=false;

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in

    --branch)
        BRANCH="$2"
        shift 2
        ;;

    --owner)
    OWNER="$2"
    shift 2
    ;;

    --help)
    printf "Please pass pipeline definition as first argument, and optionally argumetnts for branch,owner, poll for source changes"
    ;;

    --configuration)
    CONFIGURATION="$2"
    shift 2
    ;;
    
    --poll-for-source-changes)
    SHOULD_POLL=true
    shift;;

    --) shift; 
        break 
        ;;
  esac
done


cat "$PIPELINE_TEMPL" | jq --arg branch $BRANCH --arg owner $OWNER --arg shouldPoll $SHOULD_POLL '
.pipeline
| .version += 1 
| .stages[0].actions[0].configuration.Branch = $branch
| .stages[0].actions[0].configuration.Owner = $owner
| .stages[0].actions[0].configuration.PollForSourceChanges = $shouldPoll' > $FILE_NAME