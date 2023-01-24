# Questions and answers about {{ vpc-name }}

#### What is {{ vpc-short-name }}? {#what-is-vpc}

{{ vpc-short-name }} ({{ vpc-full-name }}) is a way to connect and organize cloud resources using virtual networks.

#### Which network technologies are available to {{ yandex-cloud }} users? {#available-network-techs}

{{ vpc-short-name }} enables you to assign VMs private and public IP addresses and create cloud networks and subnets.

#### How do I create a cloud network? {#create-cloud-network}

When you create a folder through the management console, the service will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet? {#create-subnet}

Subnets in the default folder will be created automatically. You can create additional subnets using the [management console or CLI](../operations/subnet-create.md).

#### Which resources can be assigned IP addresses? {#assing-ip-resources}

You can assign addresses to [virtual machines](../../compute/concepts/vm.md) and hosts in database clusters.

#### How are IP addresses assigned to cloud resources? {#assign-ip}

You can have public IPs assigned to cloud resources automatically or select IPs from the list of [reserved static addresses](../operations/set-static-ip.md). You can assign internal addresses automatically or manually when creating a VM.

#### How do I make a public IP address static? {#make-ip-static}

You can make a public IP address [static](../operations/set-static-ip.md) using the {{ vpc-short-name }} **IP addresses** tab in the [management console]({{ link-console-main }}).

#### What limitations apply when creating subnets? {#create-subnet-limits}

Subnets can only use private IPv4 addresses from the ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918).

#### Why is my connection for {{ yandex-cloud }} services slow? {#low-connection}

{{ yandex-cloud }} doesn't impose any limits on connection speed. Please provide the following information to help troubleshoot potential problems:
* The direction of the connection that is producing the issue: local to the cloud network, cloud network to the internet, or the internet to the cloud network.
* Type of traffic producing the issue: incoming or outgoing.
* Source and target settings: virtual machine IDs, IPs, FQDNs.
* Output for the `mtr <target_IP_or_domain>` command.
* Speed results from [Yandex.Internetometer](https://yandex.com/internet/), including Technical Information.

Prepare this information and send it to [technical support]({{ link-console-support }}).

#### What do I do if email traffic is blocked? {#if-traffic-blocked}

{{ yandex-cloud }} only [blocks](../concepts/limits.md#vpc-egress-traffic-filter) traffic sent from pubic IPs on port 25. Traffic sent to Yandex email servers is the exception. 

To prevent email traffic from being blocked, reconfigure your email sever to use ports 465 and 587. To do this, use these ports as an email gateway and [delegate your domain](https://yandex.com/support/business/delegate-domain.html) to Yandex servers with [Yandex Mail for Domains](https://habr.com/company/plesk/blog/304204/).


If you need port 25, assign your virtual machine a new IP:

1. [Request]({{ link-console-support }}) a new IP with port 25 open. When making the request, tell support:
   * The ID of the folder where you need the IP address.
   * The availability zone.
   * The PTR record domain, if required.

1. Unbind the current IP from the virtual machine. To do this, run the following [CLI](../../cli/) command:

   ```bash
   yc compute instance remove-one-to-one-nat \
     --id=<virtual_machine_ID> \
     --network-interface-index=0
   ```

1. [Bind](../../compute/operations/vm-control/vm-attach-public-ip.md) the new IP received from support.

We reserve the right to block an IP and/or suspend a VM if we receive complaints about spam originating from that IP address.



{% include [fz-152.md](../../_qa/fz-152.md) %}



{% include [logs](../../_qa/logs.md) %}
