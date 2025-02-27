# Setting up network connectivity between cloud and remote resources with IPsec gateways


Network connectivity between your corporate data center and cloud resources must be properly protected. For this purpose, you can use secure connections.

One of the technologies used for that is an internet connection through IPsec gateways over the IPsec protocol. [IPsec](https://www.ietf.org/rfc/rfc2401.txt) is widely used on a variety of network devices, both physical and virtual.

Cloud site:

* Network named `cloud-net` with the following subnets: `subnet-a` (`172.16.1.0/24`), `subnet-b` (`172.16.2.0/24`), and `ipsec-subnet` (`172.16.0.0/24`).
* Main IPsec gateway named `cloud-gw` as a VM based on the open-source [strongSwan](https://github.com/strongswan/strongswan) solution. Connect this IPsec gateway to `ipsec-subnet`. The main goal of the gateway is to set up an IPsec connection to a remote gateway and provide network connectivity between test VMs.
* `cloud-net-sg` security group is used for the VM network interface of the main gateway and allows IPsec traffic between the gateways.
* `cloud-net-rt` route table with static routes ensures traffic towards `subnet-1` of the remote site through the main IPsec gateway.
* Ubuntu Linux-based test VMs, `vm-a` and `vm-b`, get connected to `subnet-a` and `subnet-b`, respectively. These VMs are used to check IP connectivity via an IPsec connection.

Remote site:

* `remote-net` network with `subnet-1` (`10.10.0.0/16`).
* Remote IPsec gateway named `remote-gw` as a VM based on the open-source [strongSwan](https://github.com/strongswan/strongswan) solution. Connect this IPsec gateway to `subnet-1`. The main goal of the gateway is to set up an IPsec connection to the main gateway and provide network connectivity between test VMs.
* `remote-net-sg` security group is used for the VM network interface of the remote gateway and allows IPsec traffic between the gateways.
* `remote-net-rt` route table with static routes ensures traffic towards `subnet-a` and `subnet-b` of the cloud site through the remote IPsec gateway.
* Ubuntu Linux-based test VM, `vm-1`, gets connected to `subnet-1`. This VM is used to check IP connectivity via an IPsec connection.

The IPsec connection is established between the public IP addresses of the main gateway (`x1.x1.x1.x1`) and those of the remote one (`x2.x2.x2.x2`).
