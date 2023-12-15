# Setting up network connectivity between cloud and remote resources with IPsec gateways

Network connectivity between your corporate data center and cloud resources must be properly protected. To enable such protection, you can use secure connections.

One of the technologies used for that is an internet connection based on IPsec gateways over the IPsec protocol. [IPsec](https://www.ietf.org/rfc/rfc2401.txt) is widely used on a variety of network devices, both physical and virtual ones.

Cloud site:

* The `cloud-net` network with `subnet-a` (`172.16.1.0/24`), `subnet-b` (`172.16.2.0/24`), and `ipsec-subnet` (`172.16.0.0/24`).
* The `cloud-gw` main IPsec gateway in VM format based on the open-source [strongSwan](https://github.com/strongswan/strongswan) product. The IPsec gateway is connected to the `ipsec-subnet`. The main goal of the gateway is to set up an IPsec connection to a remote gateway and provide network connectivity between test VMs.
* The `cloud-net-sg` security group is applied on the VM network interface of the main gateway and allows IPsec traffic between the gateways.
* A route table named `cloud-net-rt` with static routes ensures traffic towards `subnet-1` of the remote site via the main IPsec gateway.
* The `vm-a` and `vm-b` test VMs based on Ubuntu Linux are connected to `subnet-a` and `subnet-b`, respectively. These VMs are used to check IP connectivity via an IPsec connection.

Remote site:

* The `remote-net` network with `subnet-1` (`10.10.0.0/16`).
* The `remote-gw` remote IPsec gateway in VM format based on the open-source [strongSwan](https://github.com/strongswan/strongswan) product. The IPsec gateway is connected to `subnet-1`. The main goal of the gateway is to set up an IPsec connection to the main gateway and provide network connectivity between test VMs.
* The `remote-net-sg` security group is applied on the VM network interface of the remote gateway and allows IPsec traffic between the gateways.
* A route table named `remote-net-rt` with static routes ensures traffic towards `subnet-a` and `subnet-b` of the cloud site via the remote IPsec gateway.
* The `vm-1` test VM based on Ubuntu Linux is connected to `subnet-1`. This VM is used to check IP connectivity via an IPsec connection.

The IPsec connection is established between the public IPs of the main (`x1.x1.x1.x1`) and remote (`x2.x2.x2.x2`) gateways.
