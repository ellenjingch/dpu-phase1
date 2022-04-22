# dpu-phase1
 3 vm; 2 virtbr

Step1: create 3 vm
       istio-node; host-node; dpu-node
Step2: install k8s on istio-node(master node), host-node(worker node)
Step3: install flannel on enp1s0(virtio bridge1) with kube-flannel.yaml
Step4: on host-node
    Step4.1 install multus 
       $ git clone https://github.com/k8snetworkplumbingwg/multus-cni.git && cd multus-cni
       $ cat ./deployments/multus-daemonset-thick-plugin.yml | kubectl apply -f -
    Step4.2: $ sudo ifconfig enp6s0 promisc
       $ lsmod | grep macvlan （查看是否加载了）
       $ modprobe macvlan (手动加载macvlan驱动到内核)
    Step4.3: install macvlan on enp6s0(virtio bridge2) with kube-macvlan.yaml
    Step4.4: install demoappv11.yaml and demoappv12.yaml
Step5: on dpu-node
    Step5.1: deploy envoy container as d8f3e29e5af0
       $ sudo docker build -t ellendocker/envoy_debug:v1.6 --rm=true .
       $ sudo docker push ellendocker/envoy_debug:v1.6
    Step5.2: create 2 docker bridge to connect enp1s0 and enp6s0
       $ sudo docker network create --driver bridge --subnet 192.168.122.0/24 --ip-range=192.168.122.133/32 --gateway 192.168.122.74 mgtbr
       $ sudo docker network create --driver bridge --subnet 192.168.126.0/24 --ip-range=192.168.126.233/32 --gateway 192.168.126.133 databr
    Step5.2: connect container d8f3e29e5af0 to databr and mgtbr
       $ sudo docker network connect mgtbr d8f3e29e5af0
       $ sudo docker network connect databr d8f3e29e5af0
    
