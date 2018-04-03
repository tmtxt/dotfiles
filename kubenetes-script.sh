alias kb="kubectl"
alias kbs="kubectl --context=staging"
alias kbsl="kubectl --context=staging logs --tail=100 -f"
alias kbp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production"
alias kbpl="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production logs --tail=100 -f"
alias kbpp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production get po"

# copy integration file from production
function kbpic {
    pod_name=$(kbp get po | grep integration-storage | awk '{print $1}');
    kbp cp $pod_name:/exports/$1 ~/Downloads/$1
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

# exec -it bash
# $1 = pod name
function kbpex {
    kbp exec -it $1 bash
}
