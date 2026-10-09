# Network security requirements

## 2. Network security {#network-security}


This section provides users with recommendations on security settings in [{{ vpc-full-name }}](../../../vpc/).


To isolate applications from each other, put resources in different [security groups](../../../vpc/concepts/security-groups.md), and, if strict isolation is required, in different [networks](../../../vpc/concepts/network.md#network). By default, internal network traffic is allowed, while traffic between networks is not. Traffic between networks is only allowed via [VMs](../../../compute/concepts/vm.md) with two network interfaces in different networks, VPN, or [{{ interconnect-full-name }}](../../../interconnect/index.yaml).

### Overview {#general}

#### 2.1 Cloud objects use a firewall or security groups {#firewall}

With built-in security groups, you can manage VM access to resources and security groups in {{ yandex-cloud }} or resources on the internet. A security group is a set of rules for incoming and outgoing traffic that can be assigned to a VM's network interface. Security groups work like a stateful firewall: they monitor the status of sessions and, if a rule allows a session to be created, they automatically allow response traffic. You can find the security group setup guide in [{#T}](../../../vpc/operations/security-group-create.md). You can specify a security group in the VM settings.

You can use security groups to protect:
* VM.
* [Managed databases](/services#data-platform).
* [{{ alb-full-name }}](../../../application-load-balancer/) [load balancers](../../../application-load-balancer/concepts/application-load-balancer.md).
* [{{ managed-k8s-full-name }}](../../../managed-kubernetes/) [clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

The list of available services is being extended.

You can manage network access without security groups, e.g., by using a separate VM as a firewall based on an [NGFW]({{ link-cloud-marketplace }}/products/usergate/ngfw) image from {{ marketplace-full-name }} or a custom image. Using the NGFW can be critical to customers if they need the following features:
* Logging network connections.
* Streaming traffic analysis for malicious content.
* Detecting network attacks by signature.
* Other features of conventional NGFW solutions.

Make sure that your [clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) use any of the following:

* Security groups in each cloud object.
* A separate NGFW VM from {{ marketplace-name }}.
* [BYOI](https://en.wikipedia.org/wiki/Bring_your_own_operating_system) principle, e.g., [your own disk image](../../../compute/operations/image-create/upload.md).

| Requirement ID | Severity |
| --- | --- |
| NET1 | High |

{% note info %}

Automated verification guarantees security only if an explicitly assigned security group is present on the object's network interface. You cannot objectively verify the use of BYOI (NGFW disk images) using the platform tools; therefore, the responsibility for their routing lies with the administrator.

{% endnote %}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  Check if there are security groups in different objects:
  1. Open the [{{ yandex-cloud }} management console]({{ link-console-main }}) in your browser.
  1. Go to each cloud and [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) and open all resources listed in "Objects that security groups can be applied to", one by one.
  1. In the object settings, find the **Security group** parameter and make sure that at least one security group is assigned.
  1. If the parameters of each object with security group support have at least one group set, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. View the organizations available to you and copy the required `ID`:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command to find all VMs without associated security groups:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
     do echo "VMs without SG in FOLDER_ID " $FOLDER_ID ":" && yc compute instance list --folder-id=$FOLDER_ID --format=json |
     jq -r '.[] | select( (.network_interfaces[].security_group_ids | length) == 0 ) | .id' \
     && echo "-----"
     done;
     done
     ```

  1. If the result is empty or does not contain virtual machine IDs, the check is passed. If VMs without associated security groups are found, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use**:
* Apply security groups to any objects that have no group.
* To apply security groups through {{ TF }}, [set up security groups (dev/stage/prod) using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation).
* To use the NGFW, [install](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM) the NGFW on your VM: Check Point.
* Refer to [this guide](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing) on using the UserGate NGFW in the cloud.
* Use NGFW in [active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md) mode.

{% include [check-security-deck](../check-security-deck.md) %}

#### 2.2 A security group is created in {{ vpc-name }}; the default security group is not used {#vpc-sg}

A *security group* (SG) is a resource created at the [cloud network](../../../vpc/concepts/network.md#network) level. Once created, a [security group](../../../vpc/concepts/security-groups.md) can be used in {{ yandex-cloud }} [services](../../../vpc/concepts/security-groups.md#security-groups-apply) to control network access to an object it applies to.

A *default security group* (DSG) is created automatically while creating a [new cloud network](../../../vpc/concepts/network.md#network). The default security group has the following properties:

* In a new network, allows all outgoing (egress) traffic, incoming (ingress) traffic over `SSH` (`TCP` and `UDP` on port `22`), `RDP` (`TCP` and `UDP` on port `3389`), and `ICMP` from any IPv4 address, as well as traffic between objects within the group (the `self` rule).
* It applies to traffic passing through all subnets in the network where the DSG is created.
* It is only used if no security group is explicitly assigned to the object yet.
* You cannot delete the DSG: it is deleted automatically when deleting the network.

The default security group is a convenient yet insecure mechanism. It allows incoming `SSH` and `RDP` traffic from all IPv4 addresses and any outgoing traffic. This simplifies the initial setup at the expense of creating significant risks:

* Attackers can get access to resources through public interfaces.
* Uncontrolled traffic makes your network more vulnerable to DDoS attacks and port scanning.
* The DSG remains active until you assign another security group to the object.

We recommend you to [create](../../../vpc/operations/security-group-create.md) a security group of your own with [rules](../../../vpc/concepts/security-groups.md#security-groups-rules) explicitly allowing only the traffic you need (e.g., `HTTP/HTTPS` for web servers or `SSH` for administration) and assign this group to your cloud [objects](../../../vpc/concepts/security-groups.md#security-groups-apply) ([VMs](../../../compute/concepts/vm.md), [{{ k8s }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster), etc.) to override the DSG.

This is important because without your rules cloud resources remain open to all and any connections from the internet, whereas security groups of your own enable the [principle of least privilege](../../../iam/best-practices/using-iam-securely.md#restrict-access), thus reducing the attack surface.

You can combine security groups by assigning up to five groups per object for more flexible access control.

| Requirement ID | Severity |
| --- | --- |
| NET2 | High |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to each cloud and then to each folder and each {{ vpc-name }}.
  1. Go to **Security groups**.
  1. If at least one security group is found for each {{ vpc-name }} network in addition to the default security group, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the `ID` you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for folders with no security group:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id'); do
       for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); do
         echo "Checking FOLDER_ID " $FOLDER_ID ":"
         for NET_ID in $(yc vpc network list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'); do
           USER_SGS=$(yc vpc security-group list --folder-id=$FOLDER_ID --format=json | jq -r "[.[] | select(.network_id == \"$NET_ID\" and .default_for_network != true)] | length")
           if [ "$USER_SGS" -eq "0" ]; then
             echo "Network $NET_ID has NO custom security groups!"
           fi
         done
         echo "-----"
       done
     done
     ```

  1. If the script does not output any networks with missing security groups, the check is passed. Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use**:

Create a security group in each {{ vpc-name }} with restricted access rules, so that it can be assigned to cloud objects.

{% include [check-security-deck](../check-security-deck.md) %}

#### 2.3 Security groups have no access rule that is too broad {#access-rule}

A security group lets you grant network access to absolutely any IP address on the internet as well as across all port ranges. A dangerous rule looks as follows:
* Port range: 0 to 65535 or empty.
* Protocol: Any or TCP/UDP.
* Source: CIDR.
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6).

{% note warning %}

If no port range is set, it is considered that access is granted across all ports (0-65535).

{% endnote %}

Make sure to only allow access through the ports that your application requires to run and from the IPs to connect to your objects from.

| Requirement ID | Severity |
| --- | --- |
| NET3 | Medium |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to each cloud and then to each folder and each {{ vpc-name }}.
  1. Go to **Security groups**.
  1. If there is no security group containing network access rules that allow access through any port and from any IP address (for explanation, see above), the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the `ID` you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Find security groups with a dangerous access rule:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id'); do
       for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); do
         echo "Checking SG in FOLDER_ID " $FOLDER_ID ":" && yc vpc security-group list --folder-id=$FOLDER_ID --format=json | \
         jq -r 'map(select(
           .rules != null and (
             .rules[] | select(
               .direction == "INGRESS" and
               (.ports == null or .ports.to_port == "65535" or .ports.to_port == null) and
               .cidr_blocks != null and
               .cidr_blocks.v4_cidr_blocks != null and
               (.cidr_blocks.v4_cidr_blocks | index("0.0.0.0/0") != null)
             )
           )
         )) | .[].id' \
         && echo "-----"
       done
     done
     ```

  1. If an empty string is output, the recommendation is fulfilled. If you see a list of security group IDs, proceed to the "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use**:

Delete the dangerous rule in each security group or edit it by specifying trusted IPs.

{% include [check-security-deck](../check-security-deck.md) %}

#### 2.4 Access through control ports is only allowed for trusted IPs {#trusted-ip}

We recommend that you only allow access to your cloud infrastructure through control ports from trusted IP addresses. Make sure your access rules specified in the security group contain no broad rules that allow access through control ports:
* Port range: 22, 3389, or 21.
* Protocol: TCP.
* Source: CIDR.
* CIDR blocks: 0.0.0.0/0 (access from any IP address) or ::/0 (ipv6).

| Requirement ID | Severity |
| --- | --- |
| NET4 | Medium |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to each cloud and then to each folder and each {{ vpc-name }}.
  1. Go to **Security groups**.
  1. If there is no security group containing network access rules that allow access through control ports from any IP address (for explanation, see above), the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the `ID` you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for security groups with dangerous access rules:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id'); do
       for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); do
         echo "SG_ID: " && yc vpc security-group list --folder-id=$FOLDER_ID \
         --format=json | jq -r '.[] | select(.rules[].direction=="INGRESS" and (.rules[].ports.to_port=="22" or .rules[].ports.to_port=="3389" or .rules[].ports.to_port=="21") and .rules[].cidr_blocks.v4_cidr_blocks[]=="0.0.0.0/0")' | jq -r '.id' \
         && echo "FOLDER_ID: " $FOLDER_ID && echo "-----"
       done
     done
     ```

  1. If there is an empty value for `SG_ID` next to `FOLDER_ID`, the recommendation is fulfilled. If the `SG_ID` is not empty, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use**:

[Delete](../../../cli/cli-ref/vpc/cli-ref/security-group/index.md) the dangerous rule in each security group or specify trusted IPs.

{% include [check-security-deck](../check-security-deck.md) %}

#### 2.5 Protection against DDoS attacks is enabled {#ddos-protection}

You can implement DDoS protection in {{ yandex-cloud }} on two levels:

1. **Basic DDoS protection (L3/L4)**
   To protect public IP addresses from attacks at the network and transport layers, use the built-in [DDoS protection mechanism](../../../vpc/ddos-protection/index.md) that operates in conjunction with [Qrator Labs](https://qrator.net/ru/). You can enable this protection for external IP addresses of VMs and network load balancers.
1. **Application-layer (L7) protection**
   Use {{ sws-full-name }} to protect web applications (WAF) and filter traffic at L7. In {{ sws-name }}, create a security profile, connect it to the load balancer ({{ alb-name }}), and configure the required rules. You can find the setup guide in [{#T}](../../../smartwebsecurity/operations/host-connect.md).

| Requirement ID | Severity |
| --- | --- |
| NET5 | Informational |

{% note info %}

Activating the Qrator protection on public IP addresses may alter your traffic routing (by causing asymmetric routing). Lack of L3/L4 protection is not always a violation in complex network topologies. This check gathers information about unprotected IP addresses and SWS profiles for an informed decision by the administrator.

{% endnote %}

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  * Basic protection (L3/L4) check for IP addresses:

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
    1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_addresses }}**.
    1. Check the status in the **DDoS protection** column. Assess how critical are the addresses where the check is disabled.

  * L7 protection check (Smart Web Security):

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check the {{ sws-name }} status.
    1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. Make sure you have security profiles and they are connected to relevant web resources.

- Performing a check via the CLI {#cli}

  1. See what organizations are available to you and write down the `ID` you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Find external public IP addresses without basic protection (Qrator):

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id'); do
     for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); do
     yc vpc address list --folder-id=$FOLDER_ID --format=json | jq -r 'map(select(
     .external_ipv4_address != null and
     (.external_ipv4_address.requirements == null or .external_ipv4_address.requirements.ddos_protection_provider != "qrator")
     )) | .[].address'
     done
     done
     ```

  1. Find SWS (L7) profiles:

     ```bash
     export ORG_ID=<organization_ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id'); do
     for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); do
     yc smartwebsecurity security-profile list --folder-id=$FOLDER_ID --format=json | jq -r '.[].id'
     done
     done
     ```

{% endlist %}

**Guides and solutions to use**:

* Considering the impact the Qrator protection has on asymmetric routing, analyze whether you need to enable DDoS protection on public IP addresses in your project. Optionally, change the {{ vpc-name }} host settings.
* To enable L7 protection, use {{ sws-name }}.

{% include [check-security-deck](../check-security-deck.md) %}

#### 2.6 Protected remote access is used {#secure-access}

To ensure secure remote connection to cloud resources, use modern access management mechanisms and secure communication channels:

* **OS-level access (OS Login)**

  To access your virtual machines and Kubernetes nodes via SSH, stop using static SSH keys. Use the [OS Login](../../../organization/concepts/os-login.md) mechanism which links Linux accounts with {{ yandex-cloud }} organization users. This allows you to use short-lived SSH certificates, centralized access management via IAM roles, and automatically revoke access if the user is blocked.

* **Secure network channels (VPN and Interconnect)**

* **Site-to-site VPN** between a remote site, e.g., your office, and the cloud. As a remote access gateway, use a VM featuring a site-to-site VPN based on an [image from {{ marketplace-name }}]({{ link-cloud-marketplace }}?categories=network).

  Setup options:

  * [Creating an IPsec VPN tunnel using the strongSwan](../../../tutorials/routing/ipsec/index.md).
  * [Creating a site-to-site VPN connection to {{ yandex-cloud }} using {{ TF }}](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).

* **Client VPN** between remote devices and {{ yandex-cloud }}. As a remote access gateway, use a VM featuring a Client VPN based on an [image from {{ marketplace-name }}]({{ link-cloud-marketplace }}?categories=network).

  See the guide in [Creating a VPN connection using OpenVPN](../../../tutorials/routing/openvpn.md). You can also use certified cryptographic information protection tools.

* **Dedicated private connection** between a remote site and {{ yandex-cloud }} via [{{ interconnect-name }}](../../../interconnect/).

To access the infrastructure using control protocols (such as SSH or RDP), create a bastion VM. You can do this using a free [Teleport](https://goteleport.com/) solution. Access to the bastion VM or VPN gateway from the internet must be restricted.

For better control of administrative actions, we recommend that you use PAM (Privileged Access Management) solutions that support administrator session logging (for example, Teleport). For SSH and VPN access, we recommend that you avoid using passwords and use public keys, X.509 certificates, and SSH certificates instead. When setting up SSH for your VMs, we recommend that you use the SSH certificates (including for the SSH host).

To access web services deployed in the cloud, use TLS version 1.2 or higher.

| Requirement ID | Severity |
| --- | --- |
| NET6 | High |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  **Checking if OS Login is on**:

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.oslogin.title }}**.
  1. Make sure **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}** is on.
  1. [Go]({{ link-console-main }}/link/compute/instances) to the VM settings in {{ compute-short-name }} and make sure **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** is on.

  **Network access check (VPN/Gateways)**:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_route-tables }}**.
  1. If routes to remote sites' private networks through VMs with a VPN gateway are found, the recommendation is fulfilled.
  1. Check the VMs in each cloud for VPN gateways. In addition, check if their security groups have open ports for the VPN.

- Performing a check via the CLI {#cli}

  1. View the list of available organizations and copy the ID of the one you need:

      ```bash
      yc organization-manager organization list
      ```

  1. Run this command to check if OS Login is on at the organization level:

      ```bash
      yc organization-manager oslogin get-settings --organization-id <organization_ID> --format json | jq -r '.ssh_certificate_settings.enabled'
      ```

      If the command returns `true`, the OS Login functionality is enabled globally. If `false` or `null`, look up the guide.

- Manual check {#manual}

  Contact your account manager to find out if you have {{ interconnect-name }} activated. If yes, check if remote access is used.

{% endlist %}

**Guides and solutions to use**:

* Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.
* [Configure OS Login access](../../../compute/operations/vm-connect/os-login.md) on existing VMs (agent installation may be required).

{% endlist %}

#### 2.7 Employees use {{ cloud-desktop-full-name }} for remote access {#use-cloud-desktop}

{{ cloud-desktop-full-name }} is a virtual [desktop](../../../cloud-desktop/concepts/desktops-and-groups.md) infrastructure management service.

Use this service to:

* Quickly create virtual workspaces for new employees.
* Securely connect remote employees to the corporate network.
* Allow your employees to work from any modern internet-enabled device, including a privately owned one ([BYOD](https://en.wikipedia.org/wiki/Bring_your_own_device)).
* Manage desktop computing resources.
* Administer desktops remotely.
* Create desktop groups with the same computing resources and cloud [network](../../../vpc/concepts/network.md).

| Requirement ID | Severity |
| --- | --- |
| NET7 | Medium |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to check for the presence of [desktops](../../../cloud-desktop/concepts/desktops-and-groups.md).
  1. [Navigate]({{ link-console-main }}/link/cloud-desktop) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. If the list contains at least one created desktop, the recommendation is fulfilled; Otherwise, proceed to "Guides and solutions to use".

{% endlist %}

**Guides and solutions to use**:

1. [Create a desktop group](../../../cloud-desktop/operations/desktop-groups/create.md).
1. If you have any specific OS configuration requirements, you can use your own OS image by following the [{#T}](../../../cloud-desktop/operations/images/create-from-compute-linux.md) guide or [create](../../../cloud-desktop/operations/images/create-from-desktop.md) an image based on the existing desktop and reuse it for the group.
1. After you create a desktop group, the administrator can [create](../../../cloud-desktop/operations/desktops/create.md) the required number of desktops and assign users for them. Alternatively, the desktop group users can use the [user desktop showcase](../../../cloud-desktop/concepts/showcase.md) to get a desktop by themselves.

#### 2.8 Secure Yandex Browser is used for remote access to {{ cloud-desktop-name }} {#use-yandex-browser}

Employees working remotely via {{ cloud-desktop-name }} should use the [Secure Yandex Browser](https://browser.yandex.ru/corp) to access the corporate resources. This requirement enforces data security for protection against [phishing](https://en.wikipedia.org/wiki/Phishing), malicious websites, and data leaks. The browser has built-in tools for traffic encryption, blocking of dangerous resources, and integration with corporate authentication systems.

| Requirement ID | Severity |
| --- | --- |
| NET9 | Low |

#### 2.9 Outbound internet access control is performed {#outgoing-access}

Possible options for setting up outbound internet access:
* [Public IP address](../../../vpc/concepts/address.md#public-addresses). Assigned to a VM according to the one-to-one NAT rule.
* [Egress NAT (NAT gateway)](../../../vpc/operations/create-nat-gateway.md). Enables internet access for a subnet through a shared pool of {{ yandex-cloud }} public IP addresses. We do not recommend using an Egress NAT for critical interactions because the NAT gateway's IP address can be used by several clients at the same time. This feature must be taken into account when modeling threats for your infrastructure.
* [NAT instance](../../../tutorials/routing/nat-instance/index.md). The NAT function is performed by a separate VM. You can create this VM using a [NAT instance]({{ link-cloud-marketplace }}/products/yc/nat-instance-ubuntu-18-04-lts) image from {{ marketplace-name }}.

**Comparison of internet access methods**:

| | Public IP address | Egress NAT | NAT instance |
| --- | --- | --- | --- |
| **Advantages:** | | | |
| | * No setup required<br>* Dedicated IP address for each VM | * No setup required<br>* Only works for outgoing connections | * Traffic filtering on a NAT instance<br>* Ability to use your own firewall<br>* Effective use of IP addresses |
| **Disadvantages:** | | | |
| | * It might be unsafe to expose a VM directly to the internet<br>* Cost of reserving each IP address | * Shared pool of IP addresses<br>* The feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage; therefore, it is not recommended for production environments | * Setup required<br>* VM cost (vCPU, RAM, disk space) |

Regardless of which option you select for setting up outbound internet access, be sure to limit traffic using one of the mechanisms described above. To build a secure system, use static IP addresses because they can be added to the list of exceptions of the receiving party's firewall.

| Requirement ID | Severity |
| --- | --- |
| NET10 | Informational |

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder.
  1. Go to **IP addresses**.
  1. If all the public IP addresses have the **DDoS protection** column set to **Enabled**, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Performing a check via the CLI {#cli}

  {% note info %}
  
  This check is of an inventory-taking nature. It outputs a lists of public VMs (one_to_one_nat) and NAT gateways (Egress NAT) for your information. The check is successful (PASS) if the administrator has analyzed the script output and confirmed that all public exit points are legitimate and justified.
  
  {% endnote %}

  1. See what organizations are available to you and write down the `ID` you need:

     ```bash
     yc organization-manager organization list
     ```

  1. Run the command below to search for all VMs with public IPs:

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
     do echo "VM_ID in FOLDER_ID " $FOLDER_ID ":" && yc compute instance list --folder-id=$FOLDER_ID --format=json | jq -r '.[]
     | select(.network_interfaces[].primary_v4_address.one_to_one_nat.address)' | jq -r '.id' \
     && echo "-----"
     done;
     done
     ```

  1. If there is an empty value for `VM_ID` next to `FOLDER_ID`, the recommendation is fulfilled. Otherwise, proceed to `Guides and solutions to use`.
  1. Run the command below to see if there is Egress NAT (NAT gateway):

     ```bash
     export ORG_ID=<organization ID>
     for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
     do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id'); \
     do echo "NAT_GW in FOLDER_ID " $FOLDER_ID ":" && yc vpc gateway list --folder-id=$FOLDER_ID --format=json | jq -r '.[] |
     select(.id)' | jq -r '.id' && echo "-----"
     done;
     done
     ```

  1. If an empty value is set in `NAT_GW` next to `FOLDER_ID`, the recommendation is fulfilled. Otherwise, proceed to `Guides and solutions to use`.

{% endlist %}

**Guides and solutions to use**:
* If a VM has public IPs, make sure they are absolutely necessary. Otherwise, delete an external IP address in the VM settings.
* If any NAT-Gateway is found, make sure it is required. Otherwise, delete it.
* If any NAT instance is found, make sure it is required. Otherwise, delete it.

#### 2.10 DNS queries are not provided to third-party recursive resolvers {#recursive-resolvers}

To increase fault tolerance, some traffic may be routed to third-party recursive resolvers. To avoid this, contact [support](../../../support/overview.md).

| Requirement ID | Severity |
| --- | --- |
| NET8 | Low |