alias kb="kubectl"
alias kbs="kubectl --context=staging"
alias kbsl="kubectl --context=staging logs --tail=100 -f"
alias kbp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production"
alias kbpl="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production logs --tail=100 -f"
alias kbpp="kubectl --context=gke_agency-revolution_us-west1-b_production --namespace=production get po"

# copy integration file from production
function kbpic {
    kbp cp nfs-server-production-integration-storage-2496996443-54d7x:/exports/$1 ~/Downloads/$1
}
