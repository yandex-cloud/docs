The [network acceleration](../../compute/concepts/software-accelerated-network.md) is achieved by transferring network load from the [VM](../../compute/concepts/vm.md) cores to the dedicated physical server resources. This way, there is no more competition between user and network processes for the hardware resources the VM is running on, as all network traffic is processed separately. This minimizes lags and packet losses when transmitting traffic, while the VM's computing resources are released to serve your applications.

The [cost](../../compute/pricing.md#software-accelerated-network) of additional hardware resources depends on the [platform](../../compute/concepts/vm-platforms.md) and the number of VM cores.

To enable a software-accelerated network, [update the settings](../../compute/operations/vm-control/vm-update-resources.md#enable-software-accelerated-network) of the existing VM or select the **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}** option [when creating a new VM](../../compute/operations/vm-create/create-linux-vm.md).

## Recommendations for using a software-accelerated network {#use-cases}

We recommend enabling a software-accelerated network to speed up request handling:
* On VMs with custom DB installations in case of high [disk](../../compute/concepts/disk.md) activity.
* In [{{ managed-k8s-full-name }}](../../managed-kubernetes/) [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [node groups](../../managed-kubernetes/concepts/index.md#node-group), when using intra-cluster L7 load balancers, such as [Ingress NGINX controllers](https://kubernetes.github.io/ingress-nginx/) or [Istio Ingress Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/).