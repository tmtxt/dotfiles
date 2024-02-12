# 1st arg: port forward config to pass to ssh command in this format localPort:remoteIp:remotePort
# ex: 19091:10.11.0.23:3389
function skuPortForward {
    CLOUDSDK_PYTHON_SITEPACKAGES=1 \
        gcloud compute ssh jumpbox-cfe2ac4 \
        --zone australia-southeast1-b \
        --tunnel-through-iap \
        --project skutopia-production \
        -- -NL $1 -v
}

alias portforward_rdp_qa_prd="skuPortForward 19091:10.11.0.23:3389"
alias portforward_rdp_emu_prd="skuPortForward 19097:10.11.0.110:3389"
alias portforward_rdp_qa_stg="skuPortForward 19092:10.11.0.16:3389"
alias portforward_rdp_emu_stg='skuPortForward 19095:10.11.0.109:3389'
alias portforward_rdp_h1_console='skuPortForward "19093:autostore-service-pc.h1-alx-syd.wms.prd.skutopia.com.au:3389"'
alias portforward_rdp_h1_httptestclient='skuPortForward 19094:10.10.0.20:3389'

alias portforward_db_wms_stg='skuPortForward 20500:10.9.0.12:5432'
alias portforward_db_wms_prd='skuPortForward 20501:10.9.0.15:5432'

# interactive ssh, with grep command
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

# 1st arg: grep
function sshWms {
    local instanceName=$(gcloud compute instances list --project "skutopia-production" | grep "$1" | head -n 1 | awk '{print $1}')
    echo "Running command..."
    echo "gcloud compute ssh $instanceName --tunnel-through-iap --project \"skutopia-production\""
    CLOUDSDK_PYTHON_SITEPACKAGES=1 \
        gcloud compute ssh $instanceName \
        --tunnel-through-iap \
        --project "skutopia-production"
}

alias sshWmsPrd='sshWms "wms-prd"'
alias sshWmsStg='sshWms "wms-stg"'
alias sshWcsPrd='sshWms "wcs-prd"'
alias sshWcsStg='sshWms "wcs-stg"'
