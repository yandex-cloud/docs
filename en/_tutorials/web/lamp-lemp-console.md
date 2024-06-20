1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a security group](#create-security-groups).
1. [Create a VM with a pre-installed web server](#create-vm).
1. [Upload the website files](#upload-files).
1. [Configure the DNS](#configure-dns).
1. [Check that the website is running](#test-site).

We will use the `example.com` domain name as an example.

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [lamp-lemp-paid-resources](../_tutorials_includes/lamp-lemp-paid-resources.md) %}

## Create a cloud network and subnets {#create-network}

All the resources created in the use case will belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network and subnets:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Specify the **Name** of the network: `web-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

{% endlist %}

## Create a security group {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) contain rules that allow accessing your VMs from the internet. You need to create a security group named `sg-web`.

To create a security group:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for your VM:
      1. Click **Create group**.
      1. Enter the **Name** of the group: `sg-web`.
      1. Select the **Network**: `web-network`.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         | --- | --- | --- | --- | --- | --- |
         | `Outgoing` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `CIDR` | `0.0.0.0/0` |
         | `Incoming` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | `Incoming` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the appropriate protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:
            * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of [subnets](../../vpc/concepts/network.md#subnet) that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
         1. Click **Save**. Repeat the steps to create all the rules from the table.
      1. Click **Save**.

{% endlist %}

## Create a VM with a pre-installed web server {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [management console]({{ link-console-main }}) [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page, click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter `lamp-vm` or `lemp-vm` as the VM name. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in. If you do not know which availability zone you need, leave the default one.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select the VM image with the components you need:
      * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, {{ MY }}, and PHP.
      * [LEMP](/marketplace/products/yc/lemp) for Linux, Nginx, {{ MY }}, and PHP.

         For static websites, we recommend using LEMP.
   1. Under **Computing resources**:
      * Choose a VM [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      This minimum configuration is enough for functional website testing:
      * **Platform**: Intel Ice Lake
      * **Guaranteed vCPU share**: 20%
      * **vCPU**: 2
      * **RAM**: 1 GB
   1. In the **Network settings** section, select the `web-network` network and the subnet to connect the VM to.
   1. Under **Public address**, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Specify the VM access data:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself; see [{#T}](../../compute/operations/vm-connect/ssh.md) for details.

      {% note alert %}

      Once created, the VM gets an IP address and a [host name (FQDN)](../../compute/concepts/network.md#hostname) for connections. If you selected **No address** in the **Public address** field, you will not be able to access the VM from the internet.

      {% endnote %}

   1. Click **Create VM**.

      It may take a few minutes to create the VM. When the VM status changes to `RUNNING`, you can [upload the website files](#upload-files).

{% endlist %}

## Upload the website files {#upload-files}

{% include [lamp-lemp-paid-upload-files](../_tutorials_includes/lamp-lemp-upload-files.md) %}

## Configure the DNS {#configure-dns}

If you have a registered domain name, use the Cloud DNS service to manage the domain.

Read below to learn how to configure the DNS for the `example.com` domain name. The `example.com` domain name must be mapped to the VM IP address using [DNS records](../../dns/concepts/resource-record.md). To do this:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Copy the IP address of the VM you created.
   1. On the site of your DNS hosting provider, go to the DNS settings.
   1. Create or edit the [A record](../../dns/concepts/resource-record.md#a) for `example.com` so that it points to the copied IP address:

      ```text
      example.com. A <VM_IP_address>
      ```

   1. Create a [CNAME](../../dns/concepts/resource-record.md#CNAME) record named `www` with `example.com` for value.

      If you use [{{ dns-full-name }}](../../dns/), follow this guide to configure the record:

      {% cut "Configuring DNS records for {{ dns-name }}" %}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. If you do not have a public [DNS zone](../../dns/concepts/dns-zone.md), create one:
         1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
         1. Specify `example-zone-1` for zone **{{ ui-key.yacloud.common.name }}**.
         1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, enter the website's domain name with a trailing dot: `example.com.`
         1. Select a **{{ ui-key.yacloud.common.type }}** of the zone: `{{ ui-key.yacloud.dns.label_public }}`.
         1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create an [A](../../dns/concepts/resource-record.md#a) record:
         1. In the list of zones, click `example-zone-1`.
         1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
         1. Leave the **{{ ui-key.yacloud.common.name }}** field empty for the record to match the `example.com` domain name (rather than a name with a subdomain, e.g., `www.example.com`).
         1. Select the record **{{ ui-key.yacloud.common.type }}**: `A`.
         1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the copied IP address of the VM.
         1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
         * Select the `example.com` DNS zone from the list.
         * Click **Create record**.
         * Set the record parameters:
            * **Name**: `www`.
            * **Record type**: Select `CNAME` as the value.
            * **TTL** (record time to live): Keep the default value.
            * **Value**: Enter `example.com`.
         * Click **Create**.

      {% endcut %}

{% endlist %}

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records are created (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`).

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the TTL value which specifies how long domain records are cached.

You can check domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

## Check that the website is running {#test-site}

{% include [lamp-lemp-paid-test](../_tutorials_includes/lamp-lemp-test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

{% list tabs group=instructions %}

- Management console {#console}

   1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `lamp-vm` (`lemp-vm`) virtual machine.
   1. [Delete](../../vpc/operations/address-delete.md) the static public IP address if you reserved one specifically for this VM.
   1. [Delete](../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../dns/operations/zone-delete.md) the DNS zone if you used {{ dns-name }}.

{% endlist %}
