---
title: FAQ about {{ vpc-full-name }}
description: This page covers FAQ about {{ vpc-name }}.
---

# FAQ about {{ vpc-name }}

#### What is {{ vpc-short-name }}? {#what-is-vpc}

{{ vpc-short-name }} ({{ vpc-full-name }}) is a way to connect and arrange cloud resources using virtual networks.

#### What network technologies are available to {{ yandex-cloud }} users? {#available-network-techs}

{{ vpc-short-name }} enables you to assign VMs private and public IP addresses and create cloud networks and subnets.

#### How do I create a cloud network? {#create-cloud-network}

When you create a folder using the management console, {{ vpc-short-name }} will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet? {#create-subnet}

Subnets in the default folder will be created automatically. You can create additional subnets using the [management console or CLI](../operations/subnet-create.md).

#### Which resources can I assign an IP address? {#assing-ip-resources}

You can assign addresses to [virtual machines](../../compute/concepts/vm.md) and hosts in database clusters.

#### How are IP addresses assigned to cloud resources? {#assign-ip}

You can have public IP addresses assigned to cloud resources automatically or select them from the list of [reserved static addresses](../operations/set-static-ip.md). You can assign internal addresses automatically or manually when creating a VM.

#### How do I make a public IP address static? {#make-ip-static}

You can convert a public IP address to [static](../operations/set-static-ip.md) using the {{ vpc-short-name }} **{{ ui-key.yacloud.vpc.switch_addresses }}** tab in the [management console]({{ link-console-main }}).

#### What limitations apply when creating subnets? {#create-subnet-limits}

Subnets can only use private IPv4 addresses from the ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918).

#### Why is my connection for {{ yandex-cloud }} services slow? {#low-connection}

{{ yandex-cloud }} does not impose any limits on the connection speed. Please provide the following information to start troubleshooting:
* Direction of the malfunctioning connection: within the cloud network, cloud network to the internet, or the internet to the cloud network.
* Type of traffic producing the issue: incoming or outgoing.
* Source and target parameters: VM IDs, IP addresses,FQDNs.
* Output for the `mtr <target_IP_or_domain>` command.
* Speed results from [Yandex.Internetometer](https://yandex.com/internet/), including technical information.

Get this information and send it to [our support]({{ link-console-support }}).

{% include [cli-period.md](../../_qa/cli-period.md) %}

#### What should I do if email traffic is blocked? {#if-traffic-blocked}

{{ yandex-cloud }} only [blocks](../concepts/limits.md#vpc-egress-traffic-filter) traffic sent from pubic IP addresses on port 25. The only exception is the traffic sent to Yandex Mail email servers.

To prevent email traffic blocks, reconfigure your email server to use ports 465 and 587. To do this, use these ports as an email gateway and [delegate your domain](https://yandex.com/support/business/delegate-domain.html) to Yandex servers with [Yandex Mail for Domains](https://habr.com/company/plesk/blog/304204/).

If you need port 25, assign your virtual machine a new IP address:

1. [Request]({{ link-console-support }}) a new IP address with port 25 open. In the support ticket, provide the following details:
   * ID of the folder where you need the IP address.
   * Availability zone.
   * PTR record domain, if required.

1. Disassociate the current IP address from the virtual machine by running the following [CLI](../../cli/) command:

   ```bash
   yc compute instance remove-one-to-one-nat \
     --id=<VM_ID> \
     --network-interface-index=0
   ```

1. [Associate](../../compute/operations/vm-control/vm-attach-public-ip.md) the new IP address you got from the support team.

We reserve the right to block an IP address and/or suspend a VM if we receive complaints about spam originating from that IP address.


{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../../_qa/logs.md) %}
