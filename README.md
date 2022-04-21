# dpu-phase1
 3 vm; 2 virtbr

Step1: create 3 vm
       istio-node; host-node; dpu-node
Step2: install k8s on istio-node, host-node
Step3: install flannel on enp1s0(virtio bridge1) with kube-flannel.yaml
Step4: install multus
       $ git clone https://github.com/k8snetworkplumbingwg/multus-cni.git && cd multus-cni
       $ cat ./deployments/multus-daemonset-thick-plugin.yml | kubectl apply -f -
Step5: sudo ifconfig enp6s0 promisc
       install macvlan on enp6s0(virtio bridge2) with kube-macvlan.yaml
Step6: install demoappv11.yaml and demoappv12.yaml