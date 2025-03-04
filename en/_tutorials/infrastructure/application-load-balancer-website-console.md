1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud network](#create-network).
1. [Create security groups](#create-security-groups).
1. [Create an instance group](#create-vms).
1. [Upload the website files](#upload-files).
1. [Create a backend group](#create-backend-group).
1. [Create an HTTP router](#create-http-routers-sites).
1. [Create an L7 load balancer](#create-alb).
1. [Configure DNS](#configure-dns).
1. [Run a fault tolerance test](#test-ha).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/alb-website/paid-resources.md) %}

## Create a cloud network {#create-network}

All the resources created in the use case will belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Specify the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** of the network: `mysite-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

{% endlist %}

## Create security groups {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow the [load balancer](../../application-load-balancer/concepts/application-load-balancer.md) to receive incoming traffic and redirect it to the VMs so they can receive the traffic.

To create security groups for the load balancer and an [instance group](../../compute/concepts/instance-groups/index.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
  1. Create a security group for the load balancer:
     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Name the group, e.g., `alb-sg`.
     1. Select the network to assign the security group to.
     1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

        Traffic<br>direction | Description | Port<br>range | Protocol | Source /<br>target type | Source /<br>target
        --- | --- | --- | --- | --- | ---
        `Outgoing` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Incoming` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Incoming` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Incoming` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | —

        1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
        1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a port range for traffic to come to or from.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and subnet masks that traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Rule will apply to the VMs from the current group or the selected security group.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: Rule allowing a load balancer to health-check VMs.
        1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all rules from the table.
     1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Similarly, create a security group named `alb-vm-sg` for an instance group, with the same network and the following rules:

     Traffic<br>direction | Description | Port<br>range | Protocol | Origin type | Source
     --- | --- | --- | --- | --- | ---
     `Incoming` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `alb-sg`
     `Incoming` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

{% endlist %}

## Creating an instance group {#create-vms}

Your application [backends](../../application-load-balancer/concepts/backend-group.md) will be deployed on the VM instance of the [target group](../../application-load-balancer/concepts/target-group.md). The target group will be connected to the load balancer to enable requests to the application backend endpoints.

To create an instance group with the minimum configuration:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Open the **{{ ui-key.yacloud.compute.switch_groups }}** tab and click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * Name the instance group, e.g., `website-vm-group`.
     * Select the [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete VMs in the group, assign the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account. By default, all operations with security groups are performed on behalf of the service account.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select three availability zones (`{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`) to ensure fault tolerance of your hosting.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and specify your VM [template](../../compute/concepts/instance-groups/instance-template.md):
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, select [LEMP](/marketplace/products/yc/lemp) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify:
       * [Disk](../../compute/concepts/disk.md) **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `HDD`
       * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `5%`
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
       * Select a cloud network and its subnets.
       * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
       * Select the `alb-vm-sg` security group.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for accessing the instance:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select the service account to link to the VM.
       * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter a username.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

       To establish an SSH connection, you need to create a key pair. For more information, see [Connecting to a Linux VM via SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, specify the instance group **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}**: `3`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, select **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and enter `alb-tg` as the group name.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

It may take a few minutes to create an instance group. As soon as all VMs change their [status](../../compute/concepts/vm-statuses.md) to `RUNNING`, you can [upload the website files to them](#upload-files).

## Upload the website files {#upload-files}

{% include [upload-files](../../_tutorials/_tutorials_includes/alb-website/upload-files.md) %}

## Create a backend group {#create-backend-group}

You must link the target group created with the VM group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, the groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response for a certain period.

To create a backend group:

{% list tabs group=instructions %}

- Management console {#console}

  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** in the folder where the instance group was created.
  1. Open the **{{ ui-key.yacloud.alb.label_backend-groups }}** tab.
  1. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Name the backend group, e.g., `website-bg`.
  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**.
  1. Name the backend, e.g., `backend-1`.
  1. In the ***{{ ui-key.yacloud.alb.label_target-groups }}** field, select the `alb-tg` target group you created earlier.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to receive incoming traffic from the load balancer: `80`.
  1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Specify **{{ ui-key.yacloud.alb.label_port }}** the backend VMs will use to accept health check connections: `80`.
  1. Specify **{{ ui-key.yacloud.alb.label_path }}** the load balancer will use for health checks: `/`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create an HTTP router {#create-http-routers-sites}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines HTTP routing rules.

To create an HTTP router and add a route to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the **{{ ui-key.yacloud.alb.label_http-routers }}** tab.
  1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Name the router, e.g., `website-router`.
  1. Click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Name the virtual host, e.g., `alb-host`.
  1. In the **{{ ui-key.yacloud.alb.label_authority }}** field, enter the website's domain name: `alb-example.com`.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Enter a name, e.g., `route-1`.
  1. In the **{{ ui-key.yacloud.alb.label_backend-group }}** field, select `website-bg`, which you created earlier.
  1. Leave all other settings unchanged and click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create an L7 load balancer {#create-alb}

To create a load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the **{{ ui-key.yacloud.alb.label_load-balancers }}** tab.
  1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Name the load balancer, e.g., `website-alb`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network your VM group is connected to and the [previously created](#create-security-groups) security group, `alb-sg`.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the subnets for the load balancer's nodes in each availability zone and enable inbound traffic.
  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**.
  1. Name the listener, e.g., `alb-listener`.
  1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, enable outbound traffic.
  1. Set `80` as the port.
  1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select the previously created `website-router`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Configure DNS {#configure-dns}

You need to link the `alb-example.com` domain name you want to use for your website to the load balancer's IP address using [DNS records](../../dns/concepts/resource-record.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Copy the IP address of the load balancer that you created.
  1. On the site of your DNS hosting provider, go to the DNS settings.
  1. Create or edit the [A record](../../dns/concepts/resource-record.md#a) and [CNAME record](../../dns/concepts/resource-record.md#cname) for `alb-example.com`:

      ```text
      alb-example.com. A <L7_load_balancer_IP_address>
      alb-example.com. CNAME
      ```

      If you use [{{ dns-full-name }}](../../dns/), follow this guide to configure the records:

      {% cut "Configuring DNS records for {{ dns-name }}" %}

      To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your registrar's website.

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. If you do not have a public [DNS zone](../../dns/concepts/dns-zone.md), create one:
          1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
          1. Specify the zone **{{ ui-key.yacloud.common.name }}**: `alb-zone`.
          1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, enter the website's domain name with a trailing dot: `alb-example.com.`.
          1. Select a **{{ ui-key.yacloud.common.type }}** of the zone: `{{ ui-key.yacloud.dns.label_public }}`.
          1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create an A record in the zone:
          1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. **{{ ui-key.yacloud.common.name }}**: Leave empty.
          1. **{{ ui-key.yacloud.common.type }}**: Leave set to `A`.
          1. **TTL** (record time to live): Keep the default value.
          1. **{{ ui-key.yacloud.dns.label_records }}**: Enter the public IP address of the `website-alb` load balancer.
          1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Create a CNAME record:
          1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
          1. **{{ ui-key.yacloud.common.name }}**: `www`.
          1. **{{ ui-key.yacloud.common.type }}**: Select `CNAME`.
          1. **TTL** (record time to live): Keep the default value.
          1. **{{ ui-key.yacloud.dns.label_records }}**: Enter `alb-example.com`.
          1. Click **{{ ui-key.yacloud.common.create }}**.

      {% endcut %}

{% endlist %}

## Run a fault tolerance test {#test-ha}

{% include [test-ha](../../_tutorials/_tutorials_includes/alb-website/test-ha.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Delete the non-billable resources that block the deletion of billable resources:
   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `website-alb` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `website-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `website-bg` backend group.
1. [Delete](../../compute/operations/instance-groups/delete.md) the `website-vm-group` instance group.
1. If you used {{ dns-full-name }}, [delete](../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../dns/operations/zone-delete.md) the DNS zone.