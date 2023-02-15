# 2. Network security

This section provides users with recommendations on security settings in {{ vpc-full-name }}.

For more information about how to configure your network infrastructure, watch our webinar [How a network works in Yandex Cloud](https://www.youtube.com/watch?v=g3cZ0o50qH0).

To isolate applications from each other, put resources in different security groups, and, if strict isolation is required, in different networks. By default, internal network traffic is allowed, while traffic between networks is not. Traffic between networks is only allowed via VMs with two network interfaces in different networks, VPN, or {{ interconnect-name }}.

#### 2.1 Cloud objects use a firewall or security groups {#firewall}

With built-in [security groups](../../../vpc/concepts/security-groups.md), you can manage VM access to resources and security groups in {{ yandex-cloud }} or resources on the internet. A security group is a set of rules for incoming and outgoing traffic that can be assigned to a VM's network interface. Security groups work like a stateful firewall: they monitor the status of sessions and, if a rule allows creating a session, they automatically allow response traffic. For instructions on how to set up security groups, see [{#T}](../../../vpc/operations/security-group-create.md). You can specify a security group in the VM settings.

You can use security groups to protect:

* VMs.
* Managed databases.
* Load balancers in {{ alb-name }}.
* Clusters in {{ managed-k8s-name }}.

The list of available services is not exhaustive.

You can manage network access without security groups, for example, using a separate VM as a firewall based on an [NGFW]({{ link-cloud-marketplace }}/products/usergate/ngfw) image from {{ marketplace-name }} or a custom image. Using the NGFW can be critical to customers if they need the following features:

* Logging network connections.
* Streaming traffic analysis for malicious content.
* Detecting network attacks by signature.
* Other features of classical NGFW solutions.

Make sure you use security groups in your clouds on each cloud object, or a separate VM based on the NGFW from {{ marketplace-name }}, or the <q>Bring Your Own Image</q> (<q>BYOI</q>) approach that lets you deploy your own equipment or system images.

{% list tabs %}

- Performing a check in the management console

   Check if there are security groups in different objects:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to each cloud and each folder and sequentially open all the resources listed in <q>Objects that security groups can be applied to</q>.
   1. In the object settings, find the **Security group** parameter and make sure that at least one security group is assigned.
   1. If the parameters of each object with SG support have at least one SG set, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

   Check if the NGFW is used instead of SGs:

   1. Open the {{ yandex-cloud }} management console in your browser.
   1. Go to each cloud and each folder and open all VM disks one by one.
   1. In the disk settings, find the **Marketplace product** parameter.
   1. If the disk **Marketplace product** parameters have one of the NGFW product names specified, such as <q>Check Point CloudGuard IaaS - Firewall & Threat Prevention PAYG</q> or <q>UserGate NGFW</q>, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for cloud objects with no SG:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for VM_ID in $(yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute instance get --id=$VM_ID --format=json | jq -r '. | select(.network_interfaces[].security_group_ids | not)' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If an empty string is output, the recommendation is fulfilled. If the result with the cloud resource ID is output, proceed to the <q>Instructions and solutions to use</q>.

   Check if the NGFW is used instead of a security group:

   1. Run the command to search for the NGFW in the cloud (by default, the command searches for Checkpoint or Usergate. If you use a custom image, specify it):

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute disk get --id=$DISK_ID --format=json | jq -r '. | select(.product_ids[0]=="f2ecl4ak62mjbl13qj5f" or .product_ids[0]=="f2eqc5sac8o5oic7m99k")' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If the ID of a VM with the NGFW is output, the recommendation is fulfilled. If an empty string is output, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

* Apply SGs to any objects that have no SG.
* To apply SGs through {{ TF }}, [set up security groups (dev/stage/prod) using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation).
* To use the NGFW, [install](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM) the Check Point NGFW in your {{ yandex-cloud }} VM.
* [Instructions](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing) for using the UserGate NGFW in the cloud.
* NGFW in [active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md) mode.

#### 2.2 {{ vpc-short-name }} has at least one security group {#vpc-sg}

To apply a security group to your cloud objects, {{ vpc-short-name }} must have at least one security group. You can also create a [default security group](../../../vpc/concepts/security-groups.md#default-security-group) that will be assigned to cloud objects when connecting to subnets if they have no security group. Make sure that each network has at least one security group.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to each cloud and then to each folder and each {{ vpc-short-name }}.
   1. Go to **Security groups**.
   1. If at least one security group for each {{ vpc-short-name }} or the default security group is found, the recommendation is fulfilled. If not, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for folders with no SG:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id'  && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If each of the SG_ID combinations next to the FOLDER_ID of the folder hosting it has the IDs specified, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Create a security group in each {{ vpc-short-name }} with restricted access rules, so that it can be assigned to cloud objects.

#### 2.3 Security groups have no access rule that is too broad {#access-rule}

A security group lets you grant network access to absolutely any IP address on the internet as well as across all port ranges. A dangerous rule looks as follows:

* Port range: 0-65535 or empty.
* Protocol: Any or TCP/UDP.
* Source: CIDR.
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6).

{% note warning %}

If no port range is set, it's considered that access is granted across all ports (0-65535).

{% endnote %}

Make sure to only allow access through the ports that your application requires to run and from the IPs to connect to your objects from.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to each cloud and then to each folder and each {{ vpc-short-name }}.
   1. Go to **Security groups**.
   1. If there is no security group containing network access rules that allow access through any port and from any IP address (for explanation, see above), the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Find security groups with a dangerous access rule:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID \
      --format=json | jq -r '.[] | select(.rules[].direction=="INGRESS" and .rules[].ports.to_port=="65535" and .rules[].cidr_blocks.v4_cidr_blocks[]=="0.0.0.0/0")' | jq -r '.id'  \
      && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If an empty value is set in SG_ID next to FOLDER_ID, the recommendation is fulfilled. If you see a non-empty SG_ID, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

Delete the dangerous rule in each SG or edit it by specifying trusted IPs.

#### 2.4 Access through control ports is only allowed for trusted IPs {#trusted-ip}

We recommend that you only allow access to your cloud infrastructure through control ports from trusted IP addresses. Make sure your access rules specified in the SG contain no broad rules that allow access through control ports:

* Port range: 22, 3389, or 21
* Protocol: TCP
* Source: CIDR
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6)

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to each cloud and then to each folder and each {{ vpc-short-name }}.
   1. Go to **Security groups**.
   1. If there is no security group containing network access rules that allow access through control ports from any IP address (for explanation, see above), the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for security groups with dangerous access rules:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID \
      --format=json | jq -r '.[] | select(.rules[].direction=="INGRESS" and (.rules[].ports.to_port=="22" or .rules[].ports.to_port=="3389" or .rules[].ports.to_port=="21") and .rules[].cidr_blocks.v4_cidr_blocks[]=="0.0.0.0/0")' | jq -r '.id'  \
      && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If an empty value is set in SG_ID next to FOLDER_ID, the recommendation is fulfilled. If you see a non-empty SG_ID, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

[Delete](../../../cli/cli-ref/managed-services/vpc/security-group/index.md) the dangerous rule in each SG or specify trusted IPs.

#### 2.5 DDoS protection is enabled {#ddos-protection}

{{ yandex-cloud }} has basic and extended DDoS protection. Be sure to at least use basic protection.

* [{{ ddos-protection-full-name }}](../../../vpc/ddos-protection/index.md) is the {{ vpc-short-name }} component that safeguards cloud resources from DDoS attacks. {{ ddos-protection-name }} is provided in partnership with Qrator Labs. You can enable it yourself for an external IP address through cloud administration tools. Supported up to OSI L4.
* [Extended]{% if lang == "ru" %}(https://cloud.yandex.ru/services/ddos-protection){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/services/ddos-protection){% endif %} DDoS protection at OSI Layers 3 and 7. You can also track loads and attack properties, as well as enable Soundwall WAF in your Qrator Labs account. To enable extended protection, contact your manager or the tech support service.

{% list tabs %}

- Performing a check from the console UI (Basic protection)

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Open all the networks created.
   1. Go to **IP addresses**.
   1. If all the public IP addresses have the <q>DDoS protection</q> column set to <q>Enabled</q>, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Running a manual check (Extended protection)

   Contact your account manager from the Yandex Cloud team to find out if you have <q>Extended DDoS protection</q> activated.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for IP addresses with no DDOS protection:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do echo "Address_ID: " && yc vpc address list --folder-id=$FOLDER_ID \
      --format=json | jq -r '.[] | select(.external_ipv4_address.requirements.ddos_protection_provider=="qrator" | not)' | jq -r '.id' \
      && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If an empty value is set in Address_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

* Webinar on [DDoS protection in {{ yandex-cloud }}](https://youtu.be/KWGbLQTth5U).
* All [materials](../../../vpc/ddos-protection/index.md) about DDoS protection in Yandex Cloud.

#### 2.6 Protected remote access is used {#secure-access}

To enable administrators to establish remote connections to your cloud resources, use one of the following:

* A site-to-site VPN between a remote site (such as your office) and a cloud. As a remote access gateway, use a VM featuring a site-to-site VPN based on an [image]({{ link-cloud-marketplace }}?categories=network) from {{ marketplace-name }}.

**Setup options**:

* [Creating an IPsec VPN tunnel using the strongSwan](../../../tutorials/routing/ipsec-vpn.md).
* [Creating a site-to-site VPN connection to {{ yandex-cloud }} using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn).
* A client VPN between remote devices and {{ yandex-cloud }}. As a remote access gateway, use a VM featuring a client VPN based on an [image]({{ link-cloud-marketplace }}?categories=network) from {{ marketplace-name }}.

   See the instructions in [Creating a VPN connection using OpenVPN](../../../tutorials/routing/openvpn.md). You can also use certified data cryptographic security tools.

* A dedicated private connection between a remote site and {{ yandex-cloud }} using [{{ interconnect-name }}](../../../interconnect/index.yaml).

To access the infrastructure using control protocols (for example, SSH or RDP), create a bastion VM. You can do this using a free [Teleport](https://goteleport.com/) solution. Access to the bastion VM or VPN gateway from the internet must be restricted.

For better control of administrative actions, we recommend that you use PAM (Privileged Access Management) solutions that support administrator session logging (for example, Teleport). For SSH and VPN access, we recommend that you avoid using passwords and use public keys, X.509 certificates, and SSH certificates instead. When setting up SSH for your virtual machines, we recommend that you use the SSH certificates (also for the SSH host).

To access web services deployed in the cloud, use TLS version 1.2 or higher.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Open all the networks created.
   1. Go to the **Route tables** section.
   1. If routes to remote sites' private networks through VMs with a VPN gateway are found, the recommendation is fulfilled.
   1. In addition, check each cloud's VMs for VPN gateways and their Security Groups for any known open ports for VPN.

- Manual check

   Contact your account manager from the Yandex Cloud team to find out if you have the {{ interconnect-name }} service activated. If yes, analyze if remote access is used.

{% endlist %}

#### 2.7 Outbound internet access control is performed {#outgoing-access}

Possible options for setting up outbound internet access:

* [Public IP address](../../../vpc/concepts/address.md#public-addresses). Assigned to a VM according to the one-to-one NAT rule.
* [Egress NAT (NAT gateway)](../../../vpc/operations/enable-nat.md). Enables internet access for a subnet through a shared pool of {{ yandex-cloud }} public IP addresses. We don't recommend that you use Egress NAT for critical interactions, since the NAT gateway's IP address might be used by multiple clients at the same time. This feature must be taken into account when modeling threats for your infrastructure. Learn more about the [setting](../../../vpc/operations/create-nat-gateway.md).
* [NAT instance](../../../tutorials/routing/nat-instance.md). The NAT function is performed by a separate VM. You can create this VM using a [NAT instance]({{ link-cloud-marketplace }}/products/yc/nat-instance-ubuntu-18-04-lts) image from {{ marketplace-name }}.

**Comparison of internet access methods**:

# |
|| Public IP	| Egress NAT	| NAT instance ||
|| **Advantages:**	| **Advantages:**	| **Advantages:** ||
||
* No setup required.
* A dedicated IP address for each VM
   |
* No setup required.
* Runs only on egress connections
   |
* Traffic filtering on a NAT instance
* Using your own firewall
* Effective use of IP addresses ||
   || **Disadvantages:**	| **Disadvantages:**	| **Disadvantages:** ||
   ||
* It might be unsafe to expose a VM directly to the internet
* The cost of reserving each IP address |
* Shared pool of IP addresses
* The feature is at the Preview stage, therefore it's not recommended for production environments	|
* Setup required
* The cost of using a VM (vCPU, RAM, and disk space) ||
   |#

Regardless of which option you select for setting up outbound internet access, be sure to limit traffic using one of the mechanisms described above. To build a secure system, use [static IP addresses](../../../vpc/concepts/address.md), since they can be added to the list of exceptions of the receiving party's firewall.

{% list tabs %}

- Performing a check in the management console

   1. Open the {{ yandex-cloud }} console in your browser.
   1. Go to the appropriate folder.
   1. Go to **IP addresses**.
   1. If all the public IP addresses have the **DDoS protection** column set to **Enabled**, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

- Performing a check via the CLI

   1. See what organizations are available to you and write down the desired ID:

      ```bash
      yc organization-manager organization list
      ```

   1. Run the command below to search for all VMs with public IPs:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do echo "VM_ID: " && yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.network_interfaces[].primary_v4_address.one_to_one_nat.address)' | jq -r '.id' \
      && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If an empty value is set in VM_ID next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

   1. Run the command below to see if there is Egress NAT (NAT gateway):

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
      do echo "NAT_GW: " && yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] | select(.id)' | jq -r '.id'  && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
      done;
      done
      ```

   1. If an empty value is set in NAT_GW next to FOLDER_ID, the recommendation is fulfilled. Otherwise, proceed to the <q>Instructions and solutions to use</q>.

   1. Run the command below to see if there is a NAT instance:

      ```bash
      export ORG_ID=<organization ID>
      for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
      do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
      do for DISK_ID in $(yc compute disk list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do yc compute disk get --id=$DISK_ID --format=json | jq -r '. | select(.product_ids[0]=="fd8v7ru46kt3s4o5f0uo")' | jq -r '.id'
      done;
      done;
      done
      ```

   1. If an empty string is output, the recommendation is fulfilled. If you see the ID of a NAT instance, proceed to the <q>Instructions and solutions to use</q>.

{% endlist %}

**Instructions and solutions to use:**

* If any VM has public IPs, make sure they are required. Otherwise, delete an external IP address in the VM settings.
* If any NAT-Gateway is found, make sure it is required. Otherwise, delete it.
* If any NAT instance is found, make sure it is required. Otherwise, delete it.

#### 2.8 DNS queries are not passed to third-party recursive resolvers {#recursive-resolvers}

To increase fault tolerance, some traffic can be routed to third-party recursive resolvers. To avoid this, contact [support](../../../support/overview.md).