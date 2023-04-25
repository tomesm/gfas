#!/bin/bash

set -e

output_only=0

destroy=0
invocation="$0 $@" # store name of script and all arguments passed to it

while [[ "$#" -gt 0 ]]; do    # while there are more than 0 arguments
    case $1 in
        -o|--output-only) output_only=1 ;;
        -d|--destroy) destroy=1 ;;
        *) echo "Unknown parameter passed: $1" ;;
    esac
    shift
done

if (( output_only + destroy > 1 ))
then
    echo "only one flag is allowed" >&2
    exit 1
fi

# set colours for print output
bl=$(tput setaf 4)
gr=$(tput setaf 2)
re=$(tput setaf 1)
bo=$(tput bold)
no=$(tput sgr0)

printf "${bl}${bo}Executing script:${no}${bl} ${invocation}${no}\n"

start=$(date "+%F %T")
start_s=$(date +%s)

if (( $output_only == 0 )); then
    printf "${bl}${bo}Checking Authentication...${no}\n"

    if ! gcloud auth print-identity-token &>/dev/null; then
        echo -e "${bl}${bo}Authenticating with gcloud...${no}"
        gcloud auth login
    else
        echo -e "${bl}${bo}Already authenticated with gcloud...${no}"
    fi

    start=$(date "+%F %T")
    start_s=$(date +%s)

    # format terraform code
    printf "${bl}${bo}Executing terraform fmt...${no}\n"
    terraform fmt -recursive

    if (( $destroy == 1 )); then
        # destroy terraform project
        printf "${bl}${bo}Executing terraform destroy...${no}\n"
        cd terraform && terraform destroy -auto-approve
    fi

    if (( $destroy == 0 )); then

        # init terraform project
        printf "${bl}${bo}Executing terraform init...${no}\n"
        cd terraform && terraform init

        # apply terraform project
        printf "${bl}${bo}Executing terraform apply...${no}\n"
        terraform apply -auto-approve

        gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --zone europe-central2-a

        # apply k8s manifests
        printf "${bl}${bo}Executing k8s manifests...${no}\n"
        cd .. && kubectl apply -f k8s/tile38
        kubectl apply -f k8s/monitoring
    fi
fi
