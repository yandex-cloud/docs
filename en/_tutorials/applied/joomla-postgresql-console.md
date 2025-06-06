1. [Get your cloud ready](#before-you-begin).
1. [Create and set up a cloud network](#setup-network).
1. [Create a VM for Joomla](#create-vm).
1. [Create and configure a public DNS zone](#configure-dns).
1. [Add a TLS certificate to {{ certificate-manager-full-name }}](#issue-certificate).
1. [Create a {{ PG }} DB cluster](#create-cluster).
1. [Set up your VM environment](#env-install).
1. [Configure Joomla](#configure-joomla).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [joomla-postgresql-paid-resources](../_tutorials_includes/joomla-postgresql/joomla-postgresql-paid-resources.md) %}

## Set up a cloud network {#setup-network}

### Create a cloud network and subnets {#create-network}

{% list tabs group=instructions %}

- Management console {#console} 

  1. Create a cloud network:

      1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `joomla-network`.
      1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
      1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Create a subnet in the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md):

      1. In the network list window that opens, select `joomla-network` you have just created.
      1. In the top panel, click ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `joomla-subnet-b`.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select the `{{ region-id }}-b` availability zone.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.1.0/24`.
      1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
  1. Similarly, create subnets named `joomla-subnet-a` and `joomla-subnet-d` in the `{{ region-id }}-a` and `{{ region-id }}-d` availability zones, respectively. Specify `192.168.2.0/24` and `192.168.3.0/24` in the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field for these subnets.

{% endlist %}

### Create security groups {#crete-sg}

Create `joomla-sg` and `postgresql-sg` [security groups](../../vpc/concepts/security-groups.md) to manage network access permissions for the VM and the {{ mpg-full-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a security group named `joomla-sg` for your VM:

      1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}** and click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, enter `joomla-sg`.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `joomla-network`, which you created earlier.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

          | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
          | --- | --- | --- | --- | --- | --- |
          | Inbound | `http`           | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `https`            | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Inbound | `self`            | `All`   | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
          | Outbound | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

      1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Similarly, create a security group named `postgresql-sg` for the {{ mpg-name }} cluster with the following traffic rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }} |
      | --- | --- | --- | --- | --- | --- |
      | Inbound | `port-6432`           | `6432` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `192.168.1.0/24` |
      | Inbound | `self`            | `All`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` |
      | Outbound | `any`           | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

{% endlist %}

### Reserve a static public IP address {#reserve-ip}

Reserve a static [public IP address](../../vpc/concepts/address.md#public-addresses) for the VM that will host your website.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** and click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. In the window that opens, select `{{ region-id }}-b` in the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** field and click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Create a VM for Joomla {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the dashboard of the folder where you want to create your infrastructure, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![cpu](../../_assets/console-icons/cpu.svg) `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, type `Ubuntu 24.04` and select a public [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` availability zone.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `joomla-network` and `joomla-subnet-b`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and then, the previously reserved IP address in the field that appears.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `joomla-sg` security group you created earlier.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify the username: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `joomla-web-server`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  It may take a few minutes to create your VM.

{% endlist %}

## Create and configure a public DNS zone {#configure-dns}

You need to link the domain name you want to use for your website to the IP address of the new `joomla-web-server` VM. You can use [{{ dns-full-name }}](../../dns/index.yaml) to manage the domain.

### Delegate the domain name {#delegate-domain}

Delegation involves reassigning domain management from your registrar's servers to your own ones, which includes creating [NS](../../dns/concepts/resource-record.md#ns) records.

To delegate a domain, specify the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS server addresses in the domain settings in your account on your domain registrar's website.

Delegation does not take effect immediately. Internet provider servers normally update records within 24 hours (86,400 seconds). This depends on the TTL value which specifies how long domain records are cached.

You can check domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

### Create a public DNS zone {#create-zone}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** and click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify the zone settings consistent with your domain:

      1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone. Its name must end with a trailing dot. For example, `example.com.` matches the `example.com` domain. To create a domain name with non-Latin characters, use the [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
      1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      1. **{{ ui-key.yacloud.common.name }}**: `joomla-zone`.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a type A resource record {#create-a-record}

In your DNS zone, create a [type A resource record](../../dns/concepts/resource-record.md#a) pointing to the public IP address of the previously created VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select `joomla-zone` you previously created and click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Specify the record settings:
      1. In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
      1. In the **{{ ui-key.yacloud.common.type }}** field, select the `A` [record type](../../dns/concepts/resource-record.md#rr-types).
      1. In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the [public IP address](../../vpc/concepts/address.md#public-addresses) of the web server VM you created earlier.

          You can find the VM IP address in the [management console]({{ link-console-main }}), on the VM page under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Add a TLS certificate to {{ certificate-manager-full-name }} {#issue-certificate}

Create a new Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) for your domain to enable secure access to your website over TLS:

1. Add the new certificate to {{ certificate-manager-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** and select `{{ ui-key.yacloud.certificate-manager.action_request }}`.
      1. In the window that opens, specify `joomla-cert` in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, specify your domain name, e.g., `example.com`.
      1. Select `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` as the [domain ownership verification type](../../certificate-manager/concepts/challenges.md).
      1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    {% endlist %}

1. To successfully issue the certificate, pass a domain rights check:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
        1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
        1. From the list of certificates, select `joomla-cert`.
        1. In the window that opens, under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, select `CNAME record`.
        1. In the section below, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** and then, **{{ ui-key.yacloud.common.create }}** in the window that opens.

        The domain rights check may take from a few minutes to a few days. Wait until it is complete. As a result, the certificate will be issued and get the `Issued` status.

    {% endlist %}

## Create a {{ PG }} DB cluster {#create-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the dashboard of the folder where you want to create your infrastructure, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the cluster name: `joomla-pg-cluster`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the DBMS version: `17`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the appropriate [host](../../managed-postgresql/concepts/instance-types.md) class.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify: `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `joomla_db`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `joomla`.
      * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** field, select `{{ ui-key.yacloud.component.password-input.label_button-enter-manually }}` and set a password you will use to access the database.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select `joomla-network` and `postgresql-sg` you created previously as the network and security group, respectively.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, add additional hosts to ensure one host per availability zone. When creating hosts, do not enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** for them.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  Creating a DB cluster may take a few minutes.

{% endlist %}

## Set up your VM environment {#env-install}

{% include [joomla-postgresql-install-and-configure](../_tutorials_includes/joomla-postgresql/joomla-postgresql-install-and-configure.md) %}

## Configure Joomla {#configure-joomla}

{% include [joomla-postgresql-setup-joomla](../_tutorials_includes/joomla-postgresql/joomla-postgresql-setup-joomla.md) %}

## Test the website {#test-site}

{% include [joomla-postgresql-test-site](../_tutorials_includes/joomla-postgresql/joomla-postgresql-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `joomla-web-server` VM.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the {{ mpg-name }} cluster named `joomla-pg-cluster`.
1. [Delete](../../dns/operations/resource-record-delete.md) the DNS records and then [delete](../../dns/operations/zone-delete.md) the `joomla-zone` DNS zone.
1. [Delete](../../certificate-manager/operations/managed/cert-delete.md) the `joomla-cert` TLS certificate.
1. [Delete](../../vpc/operations/security-group-delete.md) the `joomla-sg` and `postgresql-sg` security groups.
1. [Delete](../../vpc/operations/subnet-delete.md) the `joomla-subnet-a`, `joomla-subnet-b`, and `joomla-subnet-d` subnets.
1. [Delete](../../vpc/operations/network-delete.md) the `joomla-network` cloud network.