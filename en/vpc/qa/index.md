# Questions and answers about {{ vpc-name }}

#### What is {{ vpc-short-name }}? {#what-is-vpc}

{{ vpc-short-name }} ({{ vpc-full-name }}) is a way to connect and organize cloud resources using virtual networks.

#### Which network technologies are available to {{ yandex-cloud }} users? {#available-network-techs}

{{ vpc-short-name }} allows you to assign internal and external IP addresses to VMs and create cloud networks and subnets.

#### How do I create a cloud network? {#create-cloud-network}

When you create a folder through the management console, the service will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet? {#create-subnet}

Subnets in the default folder will be created automatically. You can create additional subnets using the [management console or CLI](../operations/subnet-create.md).

#### What resources can be assigned IP addresses? {#assing-ip-resources}

Addresses can be assigned to [VMs](../../compute/concepts/vm.md) and hosts in database clusters.

#### How are IP addresses assigned to cloud resources? {#assign-ip}

Public IP addresses are assigned to cloud resources automatically. You can assign internal addresses automatically or manually when creating a VM.

#### How do I make a public IP address static? {#make-ip-static}

You can [make a public IP address static](../operations/set-static-ip.md) using the **IP addresses** tab of the {{ vpc-short-name }} service in the [management console]({{ link-console-main }}).

### What if my email traffic is being blocked? {#if-traffic-blocked}

We [block](../concepts/limits.md#vpc-egress-traffic-filter) only the traffic that is sent from public IP addresses on port 25. {% if product == "yandex-cloud" %}The only exception is the traffic that is sent to the Yandex mail servers.{% endif %}

{% if product == "yandex-cloud" %}

To unblock the traffic, configure your mail server to use the 465 and 587 ports. Set these port as a mail relay and delegate your domain to the (https://yandex.com/support/business/delegate-domain.html) the Yandex servers using [Mail for a domain](https://habr.com/company/plesk/blog/304204/).

{% endif %}

If you need to use port 25, assign a public IP address to your VM:

1. [Request]({{ link-console-support }}) a new public IP address with an open port 25. Prepare the following information for the support:
   * ID of the folder in which the address will be used;
   * availability zone;
   * domain for the PTR record if needed.

1. Unassign the current public IP address from your VM. Run the following [CLI](../../cli/) command:

   ```bash
   yc compute instance remove-one-to-one-nat \
     --id=<ID of your VM> \
     --network-interface-index=0
   ```

1. [Assign](../../compute/operations/vm-control/vm-attach-public-ip.md) the new IP address, that technical support provided you with.

We still can block an IP address or stop a VM if we receive complaints on spam being sent from this address.


#### What limitations apply when creating subnets? {#create-subnet-limits}

Subnets can only use private addresses from IPv4 ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918).

{% if product == "yandex-cloud" %}

{% include [qa-fz-152.md](../../_includes/qa-fz-152.md) %}

{% endif %}

{% include [logs](../../_qa/logs.md) %}