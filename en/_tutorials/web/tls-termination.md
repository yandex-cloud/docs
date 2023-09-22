# Terminating TLS connections

{{ alb-name }} L7 load balancers can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the backends, and encrypt backend responses to forward to clients. This scenario describes configuring a load balancer to terminate TLS connections using a certificate from {{ certificate-manager-name }} and to redirect HTTP requests to HTTPS.

This scenario uses `my-site.com` as an example domain name.

To create a virtual hosting:
1. [Prepare your cloud](#before-begin).
1. [Create a cloud network](#create-network).
1. [Reserve a static public IP address](#reserve-ip).
1. [Create security groups](#create-security-groups).
1. [Import the site's TLS certificate into {{ certificate-manager-name }}](#import-certificate).
1. [Create a VM group for the site](#create-ig).
1. [Upload the site files to the VM](#upload-site-files).
1. [Create a backend group](#create-backend-group).
1. [Create and configure an HTTP router](#create-http-router).
1. [Create an L7 load balancer](#create-l7-balancer).
1. [Check that the hosting is running properly](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of virtual hosting includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a public static IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a cloud network {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
   1. Enter a **{{ ui-key.yacloud.vpc.networks.create.field_name }}** for the network: `mysite-network`.
   1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
   1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

{% endlist %}

## Reserve a static public IP address {#reserve-ip}

For your virtual hosting to run, you need to assign a static public IP address to the L7 load balancer.

To reserve an address:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Open the **{{ ui-key.yacloud.vpc.switch_addresses }}** tab. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. In the window that opens, select the `{{ region-id }}-a` availability zone. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Create security groups {#create-security-groups}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that allow the load balancer to receive incoming traffic and redirect it to the VMs so they can receive the traffic. In this use case, we will create two security groups: one for the load balancer and another one for all VMs.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Open the **{{ ui-key.yacloud.vpc.switch_security-groups }}** tab.
   1. Create a security group for the load balancer:

      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. Enter a **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** for the group: `mysite-sg-balancer`.
      1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}**: `mysite-network`.
      1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
         | --- | --- | --- | --- | --- | --- |
         | `Outgoing` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | `Incoming` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | `Incoming` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
         | `Incoming` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | N/A |

         1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
         1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
         1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:

            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}**.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Rule will apply to the VMs from the current group or the selected security group.
            * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`: Rule that allows a load balancer to check the health of VMs.

         1. Click **{{ ui-key.yacloud.common.save }}**. Repeat the steps to create all the rules from the table.

      1. Click **{{ ui-key.yacloud.common.save }}**.

   1. In the same way, create a security group named `mysite-sg-vms` for the VM and a network named `mysite-network` with the following rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | `Incoming` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `mysite-sg-balancer` |
      | `Incoming` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

{% endlist %}

## Import the site's TLS certificate into {{ certificate-manager-name }} {#import-certificate}

For users to access the site using the secure HTTPS protocol (HTTP over TLS), the site must have a TLS certificate issued. For use in the L7 load balancer, import the certificate into {{ certificate-manager-name }}.

If your site does not have a certificate, you can use [to get a {{ certificate-manager-name }}certificate from Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md). This does not require additional steps after creating a certificate. It is imported automatically.

To import an existing certificate for `my-site.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. Click **{{ ui-key.yacloud.certificate-manager.button_add }}** and select the **{{ ui-key.yacloud.certificate-manager.action_import }}** option.
   1. Enter a **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** for the certificate: `mysite-cert`.
   1. In the **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**. Upload the **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** with your certificate or enter its **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** and click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
   1. If your certificate is issued by a third-party certificate authority, click **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}** in the **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** field. Upload the **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** with the certificate chain or enter its **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** and click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
   1. In the **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** field, click **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**. Upload the **{{ ui-key.yacloud.component.file-content-dialog.field_file }}** with the key or enter its **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** and click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create a VM group for the site {#create-ig}

To create a VM group for `my-site.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Open the **{{ ui-key.yacloud.compute.switch_groups }}** tab. Click **{{ ui-key.yacloud.compute.groups.button_create }}**.
   1. Specify a VM group name: `mysite-ig`.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select multiple availability zones to ensure fault tolerance of your hosting.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, open the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and click **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}**. Select [LEMP](/marketplace/products/yc/lemp) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Select the VM's [platform](../../compute/concepts/vm-platforms.md).
      * Specify the required number of vCPUs and the amount of RAM.

      The minimum configuration is enough for functional website testing:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `5%`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** named `mysite-network` that you [created earlier](#create-network) and its subnets.
   1. Select the [previously created](#create-security-groups) `mysite-sg-vms` security group.
   1. Specify the data required for accessing the VM:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. See [Connecting to a VM via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      The IP address and host name (FQDN) to connect to the VM are assigned at VM creation. If you selected **{{ ui-key.yacloud.compute.instances.create.value_address-none }}** in the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, you will not be able to access the VM from the internet.

      {% endnote %}

   1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**, enter the **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** of the instance group: 2.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, select **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** and specify `mysite-tg` as the group name. You can read more about target groups [here](../../application-load-balancer/concepts/target-group.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

It may take a few minutes to create an instance group. When the group [status](../../compute/concepts/instance-groups/statuses.md#group-statuses) changes to `RUNNING` and the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of all its VMs to `RUNNING_ACTUAL`, you can [upload the website files to them](#upload-site-files).

## Upload the site files to the VM {#upload-site-files}

To test the web servers, upload the `index.html` files to the virtual machines.

{% cut "Example of the index.html file" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My site</title>
  </head>
  <body>
    <h1>This is my site</h1>
  </body>
</html>
```

{% endcut %}

To upload a file to a VM:

{% include [upload-files](../_common/upload-web-site-files.md) %}

## Create a backend group {#create-backend-group}

You must link the target group created with the VM group to the [backend group](../../application-load-balancer/concepts/backend-group.md) that defines traffic allocation settings.

For the backends, groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response after a certain delay.

To create a backend group for `my-site.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Open the **{{ ui-key.yacloud.alb.label_backend-groups }}** tab. Click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the backend group: `my-site-bg`.
   1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the backend: `mysite-backend`.
   1. In the **{{ ui-key.yacloud.alb.label_target-groups }}** field, select the `mysite-tg` group.
   1. Specify the **{{ ui-key.yacloud.alb.label_port }}** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
   1. Click **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
   1. Specify the **{{ ui-key.yacloud.alb.label_port }}** that the backend VMs will use to accept health check connections: `80`.
   1. Enter the **{{ ui-key.yacloud.alb.label_path }}** to be accessed by the load balancer for health checks: `/`.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create and configure an HTTP router {#create-http-router}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines routing rules.

To create an HTTP router:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Open the **{{ ui-key.yacloud.alb.label_http-routers }}** tab. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the HTTP router: `mysite-router`.
   1. Click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the virtual host: `mysite-host`.
   1. In the **{{ ui-key.yacloud.alb.label_authority }}** field, specify the site domain name: `my-site.com`.
   1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the route: `mysite-route`.
   1. In the **{{ ui-key.yacloud.alb.label_backend-group }}** field, select the `my-site-bg` group.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Create an L7 load Balancer {#create-l7-balancer}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Click **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
   1. Enter a **{{ ui-key.yacloud.common.name }}** for the load balancer: `mysite-alb`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the `mysite-sg-balancer` security group that you [previously created](#create-security-groups).
   1. Create a listener to redirect HTTP requests to HTTPS:

      1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}**.
      1. Enter a **{{ ui-key.yacloud.common.name }}** for the listener: `listener-http`.
      1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, select the `{{ ui-key.yacloud.alb.label_address-list }}` type and the IP address you [reserved earlier](#reserve-ip).
      1. In the **{{ ui-key.yacloud.alb.label_protocol-type }}** field, select `{{ ui-key.yacloud.alb.label_redirect-to-https }}`.

   1. Create an HTTPS request listener:

      1. Click **{{ ui-key.yacloud.alb.button_add-listener }}** again.
      1. Enter a **{{ ui-key.yacloud.common.name }}** for the listener: `listener-https`.
      1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, select the `{{ ui-key.yacloud.alb.label_address-list }}` type and the IP address you [reserved earlier](#reserve-ip).
      1. In the **{{ ui-key.yacloud.alb.label_protocol-type }}** field, select `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
      1. Under **{{ ui-key.yacloud.alb.section_default-sni-match }}**, select the `mysite-cert` certificate and the `mysite-router` HTTP router.
      1. Add an SNI match for `my-site.com`:

         1. Click **{{ ui-key.yacloud.alb.button_add-sni-match }}**.
         1. Specify the **{{ ui-key.yacloud.common.name }}** for the SNI match: `mysite-sni`.
         1. In the **{{ ui-key.yacloud.alb.label_server-names }}** field, enter `my-site.com`.
         1. Select the `mysite-cert` certificate and the `mysite-router` HTTP router.

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Check that the hosting is running properly {#test}

To check that your hosting is functional, open the website at `http://my-site.com` in your browser. A redirect to `https://my-site.com` should occur with the TLS certificate from {{ certificate-manager-name }} already enabled.

## Delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:

   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `mysite-alb` L7 load balancer.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the `mysite-router` HTTP router.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the `my-site-bg` backend group.

1. [Delete](../../compute/operations/instance-groups/delete.md) the `mysite-ig` instance group.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address that you reserved.
