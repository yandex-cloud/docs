1. [Prepare your cloud environment](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a security group](#create-security-groups).
1. [Create a VM with a pre-installed web server](#create-vm).
1. [Upload the website files](#upload-files).
1. [Configure DNS](#configure-dns).
1. [Test the website](#test-site).

We will use the `example.com` domain name as an example.

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud environment {#before-you-begin}

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
  1. Enter `web-network` for the network **Name**.
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
      1. Enter a **Name** for the group: `sg-web`.
      1. Select `web-network` for **Network**.
      1. Under **Rules**, create the following rules using the instructions below the table:

          | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>target | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
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

  1. On the [folder page](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, enter `LAMP` or `LEMP` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select the VM image with the components you need: 
      * [LAMP](/marketplace/products/yc/lamp) for Linux, Apache, {{ MY }}, and PHP
      * [LEMP](/marketplace/products/yc/lemp) for Linux, Nginx, {{ MY }}, and PHP

          For static websites, we recommend using LEMP.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) to create your VM in. If you do not know which availability zone you need, leave the default one.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM. This minimum configuration is enough for functional website testing:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `web-network` and the subnet to create your VM in.
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the access credentials for the VM:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter a username. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser privileges, use the `sudo` command.

      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

          If there are no saved SSH keys in your profile, or you want to add a new key:
          * Click **Add key**.
          * Enter a name for the SSH key.
          * Upload or paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.
          * Click **{{ ui-key.yacloud.common.add }}**.

          The SSH key will be added to your organization user profile.

          If users cannot add SSH keys to their profiles in the organization, the added public SSH key will only be saved to the user profile of the VM being created.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `lamp-vm` or `lemp-vm`. The name should match the following format:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

      {% note alert %}

      Once created, the VM gets an IP address and a [host name (FQDN)](../../compute/concepts/network.md#hostname) for connections. If you selected `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` in the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, you will not be able to access the VM from the internet.

      {% endnote %}

  1. Click **Create VM**.

      It may take a few minutes to create your VM. When the VM status changes to `RUNNING`, you can [upload the website files to it](#upload-files).

{% endlist %}

## Upload the website files {#upload-files}

{% include [lamp-lemp-paid-upload-files](../_tutorials_includes/lamp-lemp-upload-files.md) %}

## Configure DNS {#configure-dns}

If you have a registered domain name, use the Cloud DNS service to manage the domain.

Below we describe how to configure the DNS for the `example.com` domain name. The `example.com` domain name must be mapped to the VM IP address using [DNS records](../../dns/concepts/resource-record.md). To do this:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Copy the IP address of the VM you created.
  1. On the site of your DNS hosting provider, go to the DNS settings.
  1. Create or edit the [A record](../../dns/concepts/resource-record.md#a) for `example.com` so that it points to the copied IP address:

      ```text
      example.com. A <VM_IP_address>
      ```

  1. Create a [CNAME](../../dns/concepts/resource-record.md#CNAME) record named `www` with `example.com` as its value.    

      If you use [{{ dns-full-name }}](../../dns/), follow this guide to configure the record:

      {% cut "Configuring DNS records for {{ dns-name }}" %}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. If you do not have a public [DNS zone](../../dns/concepts/dns-zone.md), create one:
          1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
          1. Specify the zone **{{ ui-key.yacloud.common.name }}**: `example-zone-1`.
          1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, enter the website's domain name with a trailing dot: `example.com.`.
          1. Select a **{{ ui-key.yacloud.common.type }}** of the zone: `{{ ui-key.yacloud.dns.label_public }}`.
          1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create an [A](../../dns/concepts/resource-record.md#a) record:
          1. In the list of zones, click `example-zone-1`.
          1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. Leave the **{{ ui-key.yacloud.common.name }}** field empty for the record to match the `example.com` domain name rather than a name with a subdomain, e.g., `www.example.com`.
          1. Select the record **{{ ui-key.yacloud.common.type }}**: `A`.
          1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the copied IP address of the VM.
          1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create a [CNAME](../../dns/concepts/resource-record.md#cname) record:
         * Select the `example.com` DNS zone from the list.
         * Click **Create record**.
         * Specify the record parameters:
           * **Name**: `www`.
           * **Record type**: Select `CNAME`.
           * **TTL** (record time to live): Keep the default value.
           * **Value**: Enter `example.com`.
         * Click **Create**.
      
      {% endcut %}

{% endlist %}

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`) are created.

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the TTL value which specifies how long domain records are cached.

You can check the domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

## Test the website {#test-site}

{% include [lamp-lemp-paid-test](../_tutorials_includes/lamp-lemp-test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Delete](../../compute/operations/vm-control/vm-delete.md) `lamp-vm` (`lemp-vm`).
  1. [Delete](../../vpc/operations/address-delete.md) the static public IP address if you reserved one for your VM.
  1. [Delete](../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../dns/operations/zone-delete.md) the DNS zone if you used {{ dns-name }}.

{% endlist %}
