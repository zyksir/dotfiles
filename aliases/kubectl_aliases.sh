if command -v your_cli_tool > /dev/null 2>&1; then
   source <(kubectl completion bash)
   complete -F __start_kubectl k
fi

# baseten
alias k="kubectl"
alias kd="kubectl describe"
alias kdd="kubectl describe deployment"
alias kdp="kubectl describe pod"
alias kdelp="kubectl delete pod"
alias kds="kubectl describe service"
alias kdks="kubectl describe ksvc"
alias kdr="kubectl describe revision"
alias kdsc="kubectl describe secret"
alias kdsa="kubectl describe serviceaccount"
alias kdn="kubectl describe node"

alias kl="kubectl logs"

alias kg="kubectl get"
alias kgp="kubectl get pods --sort-by=.metadata.creationTimestamp"
alias kgpt="kubectl get pods --sort-by=\".status.startTime\""
alias kgpoy="kubectl get pods -o yaml"
alias kgpoj="kubectl get pods -o json"
alias kgpn="kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName"
alias kgd="kubectl get deployments --sort-by=.metadata.creationTimestamp"
alias kgs="kubectl get services --sort-by=.metadata.creationTimestamp"
alias kgks="kubectl get ksvc --sort-by=.metadata.creationTimestamp"
alias kgr="kubectl get revisions --sort-by=.metadata.creationTimestamp"
alias kgrt="kubectl get routes --sort-by=.metadata.creationTimestamp"
alias kgsc="kubectl get secrets --sort-by=.metadata.creationTimestamp"
alias kgsa="kubectl get serviceaccounts --sort-by=.metadata.creationTimestamp"
alias kgn="kubectl get nodes --sort-by=.metadata.creationTimestamp"
alias kgns="kubectl get namespaces --sort-by=.metadata.creationTimestamp"
alias kgc="kubectl get configmaps --sort-by=.metadata.creationTimestamp"
alias kgj="kubectl get jobs --sort-by=.metadata.creationTimestamp"
alias kgtr="kubectl get taskruns --sort-by=.metadata.creationTimestamp"
alias kctx="kubectl config current-context"
alias kcp="kubectl cp"
alias ktp="kubectl top pods"
alias wktp="watch kubectl top pods"
alias ktn="kubectl top nodes"
alias kekpa="k edit kpa"
alias kgdr="k get deployments --sort-by='spec.replicas'"
alias k='kubectl'
alias kgv='kubectl get vs --sort-by=.metadata.creationTimestamp'
alias kgg='kubectl get gw'
alias kgpb='kubectl get pods -n baseten --sort-by=.metadata.creationTimestamp'
alias keks="kubectl edit ksvc"
alias kecm='kubectl edit configmap'
alias kgcmoy='kubectl get configmap -o yaml'
alias kgsoy='kubectl get service -o yaml'
alias kgsoj='kubectl get service -o json'
alias ked="kubectl edit deployment"

alias kedyn="kubectl -n baseten edit cm baseten-django-dynamic-settings"

alias ksctx='kubectx'

function kgpw {
   watch kubectl get pods --sort-by=.metadata.creationTimestamp $@
}

function ksns {
  local CTX=$(kubectl config current-context)
  local NEWNS=$(kubectl get ns --no-headers | awk '{ print $1 }' | fzf)
  kubectl config set-context $CTX --namespace=$NEWNS
  echo "new namespace: $NEWNS"
}

function ksnsm {
  # For k switch namespace manual
  local CTX=$(kubectl config current-context)
  kubectl config set-context $CTX --namespace=$1
  echo "new namespace: $1"
}


function knsb {
  local CTX=$(kubectl config current-context)
  local NEWNS='baseten'
  kubectl config set-context $CTX --namespace=$NEWNS
  echo "new namespace: $NEWNS"
}

function kit {
  kubectl exec -it $@ user-container -- /bin/bash
}

function kitdraft {
  kubectl exec -it $(kgp | grep py-draft | awk '{print $1}') user-container -- /bin/bash
}

function kpoddbgsetup {
  POD=$1
  kubectl cp $HOME/work/kdebug/setup.sh $POD:/root/setup.sh
  kubectl cp $HOME/work/kdebug/vimrc $POD:/root/.vimrc
  kubectl cp $HOME/work/kdebug/pbashrc $POD:/root/pbashrc
  kubectl exec $POD -- chmod +x /root/setup.sh
  kubectl exec $POD -- /root/setup.sh
}


function klog {
  kubectl logs $@ user-container
}

alias kmlog="kubectl logs -c model-container"

alias kcmd="kubectl run -i --rm --restart=Never dummy --image=dockerqa/curl:ubuntu-trusty --command -- sh -c"
alias istioctlpc="istioctl proxy-config"

function knsswitch {
  kubectl config set-context $(kubectl config current-context) --namespace=$@
}

alias kcurrentns="kubectl config view --minify --output 'jsonpath={..namespace}'; echo"


alias envoydash="istioctl dashboard envoy"

function kgnr {
  local CPU="CPU:status.allocatable.cpu"
  local MEMORY="MEMORY:status.allocatable.memory"
  local GPU="GPU:status.allocatable.nvidia\.com/gpu"
  local NAME="NAME:metadata.name"
  local NODEGROUP_NAME="NodeName:.metadata.labels.alpha\.eksctl\.io/nodegroup-name"
  kubectl get nodes -o custom-columns="$NAME,$CPU,$MEMORY,$GPU,$NODEGROUP_NAME"
}

alias kcurlpod="kubectl run -i --tty --rm debug --image=curlimages/curl --restart=Never -- sh"
alias kdebugpod="kubectl run nginx --image=nginx --restart=Never"
alias kdelpf="kubectl delete pod --force"

function klabels {
  kubectl get pods $@ -o json | jq '.metadata.labels'
}

function kanns {
  kubectl get pods $@ -o json | jq '.metadata.annotations'
}

function promcat {
  kubectl exec -it $@ -n logging-user -- cat /etc/promtail/promtail.yaml
}

function firstpy {
  kubectl get pods -n baseten -l app=pynode -o json | jq -r '.items[0].metadata.name'
}

function firstpylabels {
  kubectl get pods -n baseten -l app=pynode -o json | jq -r '.items[0].metadata.labels'
}

# tkn
alias ttls="tkn taskrun list -n baseten-tekton"
alias ttlsh="tkn taskrun list -n baseten-tekton | head"
alias ttlg="tkn taskrun logs -f -n baseten-tekton"
alias cdhh="cd helm/helmfile"

function helm_image_tag() {
  helm get values -n baseten baseten | grep -i tag | awk '{ print $2 }'
}

alias tf="terraform"

function kgpoyv {
if [ $# -ne 0 ]; then
  kubectl get pods -o yaml $1 | vim -
else
  local POD=$(kubectl get pods --no-headers | awk '{ print $1 }' | fzf)
  kubectl get pods -o yaml $POD | vim -
fi
}


function knodessh {
  kubectl debug node/$1 -it --image=ubuntu
}


function knodes_by_instance_type {
  kubectl get nodes -o json|jq -Cjr '.items[] | .metadata.name," ",.metadata.labels."beta.kubernetes.io/instance-type"," ",.metadata.labels."beta.kubernetes.io/arch", "\n"'|sort -k2
}

function kgp_gpu {
  kubectl get pods -o json | jq -Cjr '.items[] | .metadata.name, " ",.spec.nodeSelector."karpenter.k8s.aws/instance-gpu-name", "\n"'
}

function knode_pods {
  kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=$1
}
alias khey="k run -it --rm hey --image=williamyeh/hey --restart=Never --"

function kawscluster() {
  local cluster_name=${1}
  local region=${2}
  local arn=$(aws eks --region ${region} update-kubeconfig --name ${cluster_name} | awk '{ print $3 }')
  kubectl config use-context $arn
}


