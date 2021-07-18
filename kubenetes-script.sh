alias kb="kubectl"

# uat
alias kbu="kubectl --context=gke_agency-revolution_asia-southeast1-a_uat --namespace=uat"
alias kbul="kubectl --context=gke_agency-revolution_asia-southeast1-a_uat --namespace=uat logs --tail=100 -f"
alias kbup="kubectl --context=gke_agency-revolution_asia-southeast1-a_uat --namespace=uat get po"

# stg
alias kbs="kubectl --context=gke_agency-revolution_asia-southeast1-a_staging --namespace=staging"
alias kbsl="kubectl --context=gke_agency-revolution_asia-southeast1-a_staging --namespace=staging logs --tail=100 -f"
alias kbsp="kubectl --context=gke_agency-revolution_asia-southeast1-a_staging --namespace=staging get po"

# prod
alias kbp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production"
alias kbpsys="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=kube-system"
alias kbpl="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production logs --tail=100 -f"
alias kbpp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production get po"

# copy integration file from production
function kbpic {
    pod_name=$(kbp get po | grep integration-storage | awk '{print $1}');
    kbp cp $pod_name:/exports/$1 ~/Downloads/ar-integrations/$1
}

# kubectl get name of entity
# $1 kubectl command output
function kubectl_get_name {
    arr=($(echo $1 | awk '{print $1}'))
    echo $1 | cat -n
    echo -n "Select the number: "
    read num
    local res=${arr[$num]}
    eval $2=\$res
}

function kbpc {
    if [[ -n "$2" ]]; then
        kbp_result=$(kbp get $1 | grep $2);
    else
        kbp_result=$(kbp get $1);
    fi
    kubectl_get_name $kbp_result "KBC_RESULT"
    echo -n $KBC_RESULT | pbcopy
    echo "Copied $KBC_RESULT to clipboard"
}

function kbsc {
    if [[ -n "$2" ]]; then
        kbs_result=$(kbs get $1 | grep $2);
    else
        kbs_result=$(kbs get $1);
    fi
    kubectl_get_name $kbs_result "KBC_RESULT"
    echo -n $KBC_RESULT | pbcopy
    echo "Copied $KBC_RESULT to clipboard"
}

# exec -it bash
# $1 = pod name
function kbpex {
    kbp exec -it $1 bash
}

# Usage
# list and copy resource_name, optionally with grep_text
# kbpc $resource_type $grep_text
#
# Ex:
# Copy 1 pod name, grep by account-mapper string
# kbpc po account-mapper
#
# Copy 1 rc name, grep by api-server string
# kbpc rc api-server
#
# Copy 1 svc name, no grep text
# kbpc svc
