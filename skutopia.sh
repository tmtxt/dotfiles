alias portforward_rdp_qa_prd='CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud compute ssh --zone "australia-southeast1-b" "jumpbox"  --tunnel-through-iap --project "skutopia-production" -- -NL 19091:"10.11.0.23":3389 -v'
alias portforward_rdp_qa_stg='CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud compute ssh --zone "australia-southeast1-b" "jumpbox"  --tunnel-through-iap --project "skutopia-production" -- -NL 19092:"10.11.0.16":3389 -v'
alias portforward_rdp_emu_stg='CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud compute ssh --zone "australia-southeast1-b" "jumpbox"  --tunnel-through-iap --project "skutopia-production" -- -NL 19095:"10.11.0.109":3389 -v'
alias portforward_rdp_h1_console='CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud compute ssh --zone australia-southeast1-b jumpbox  --tunnel-through-iap --project skutopia-production -- -NL 19093:autostore-service-pc.h1-alx-syd.wms.prd.skutopia.com.au:3389 -v'
alias portforward_rdp_h1_httptestclient='CLOUDSDK_PYTHON_SITEPACKAGES=1 gcloud compute ssh --zone australia-southeast1-b jumpbox  --tunnel-through-iap --project skutopia-production -- -NL 19094:10.10.0.20:3389 -v'

function gcloudssh {
    local command="gcloud compute instances list"

    local projects=("skutopia-production" "skutopia-web-dev-40d")
    local project=""
    PS3="Select project: "
    select project in "${projects[@]}"
    do
        break;
    done
    command="$command --project $project | tail -n +2"
    echo

    local grepVal=''
    echo -n "Grep (empty to skip): "
    read grepVal
    if [[ -n "$grepVal" ]]; then
        command="$command | grep $grepVal"
    fi
    echo

    echo "Getting instance list..."
    echo

    command="$command | awk '{print \$1}'"

    local instances=($(eval $command))
    local instance=''
    PS3='Select instance: '
    select instance in $instances
    do
        break;
    done
    echo

    echo "Running command"
    echo "gcloud compute ssh $instance --tunnel-through-iap --project \"$project\""
    gcloud compute ssh $instance --tunnel-through-iap --project "$project"
}
