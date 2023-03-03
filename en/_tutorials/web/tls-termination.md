# Terminating TLS connections

{{ alb-name }} L7 load balancers can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the backends, and encrypt backend responses to forward to clients. This scenario describes configuring a load balancer to terminate TLS connections using a certificate from {{ certificate-manager-name }} and to redirect HTTP requests to HTTPS.

This scenario uses `my-site.com` as an example domain name.

To create a virtual hosting:
1. [Before you start](#before-begin).
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

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of virtual hosting includes:

* A fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a public static IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a cloud network {#create-network}

All resources you have created in the tutorial belong to the same [cloud network](../../vpc/concepts/network.md).

To create a network:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Specify a network **Name**: `mysite-network`.
   1. In the **Advanced** field, select **Create subnets**.
   1. Click **Create network**.

{% endlist %}

## Reserve a static public IP address {#reserve-ip}

For your virtual hosting to run, you need to assign a static public IP address to the L7 load balancer.

To reserve an address:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Go to the **IP addresses** tab. Click **Reserve address**.
   1. In the window that opens, select the `{{ region-id }}-a` availability zone. Click **Reserve address**.

{% endlist %}

## Create security groups {#create-security-groups}

{% include [security-groups-note](../../application-load-balancer/_includes_service/security-groups-note.md) %}

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic. Two security groups will be created in the use case: the first one for the load balancer and the second one for all VMs.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. Specify a group **Name**: `mysite-sg-balancer`.
      1. Select the **Network**: `mysite-network`.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | healthchecks | 30080 | TCP | Load balancer health checks | — |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

            * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: The rule will apply to the VMs from the current group or the selected security group.
            * **Load balancer health checks** is a rule that allows a load balancer to check the health of VMs.

         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

   1. In a similar manner, create a security group called `mysite-sg-vms` for the VM and a network named `mysite-network` with the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | balancer | 80 | TCP | Security group | `mysite-sg-balancer` |
      | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

{% endlist %}

## Import the site's TLS certificate into {{ certificate-manager-name }} {#import-certificate}

For users to access the site using the secure HTTPS protocol (HTTP over TLS), the site must have a TLS certificate issued. For use in the L7 load balancer, import the certificate into {{ certificate-manager-name }}.

If your site does not have a certificate, you can use [to get a {{ certificate-manager-name }}certificate from Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md). This does not require additional steps after creating a certificate. It is imported automatically.

To import an existing certificate for `my-site.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ certificate-manager-name }}**.
   1. Click **Add certificate** and select **User certificate**.
   1. Specify a certificate **Name**: `mysite-cert`.
   1. In the **Certificate** field, click **Add certificate**. Upload the **File** with your certificate or enter its **Contents** and click **Add**.
   1. If your certificate is issued by a third-party certificate authority, in the **Intermediate certificate chain** field, click **Add chain**. Upload the **File** with the certificate chain or enter its **Contents** and click **Add**.
   1. In the **Private key** field, click **Add private key**. Upload the **File** with the key or enter its **Contents** and click **Add**.
   1. Click **Create**.

{% endlist %}

## Create a VM group for the site {#create-ig}

To create a VM group for `my-site.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab. Click **Create group**.
   1. Specify a VM group name: `mysite-ig`.
   1. Under **Allocation**, select multiple availability zones to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define**.
   1. Under **Image/boot disk selection**, open the **{{ marketplace-name }}** tab and click **Show more**. Select [LEMP](/marketplace/products/yc/lemp) and click **Use**.
   1. Under **Computing resources**:

      * Select the VM's [platform](../../compute/concepts/vm-platforms.md).
      * Specify the necessary number of vCPUs and amount of RAM.

      The minimum configuration is enough for functional website testing:
      * **Platform**: Intel Cascade Lake.
      * **Guaranteed vCPU share**: 5%.
      * **vCPU**: 2.
      * **RAM**: 1 GB.

   1. Under **Network settings**, select the **Network** named `mysite-network` that you [created earlier](#create-network) and its subnets.
   1. Select the [previously created](#create-security-groups) `mysite-sg-vms` security group.
   1. Specify data required for accessing the VM:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      The IP address and host name (FQDN) to connect to the VM are assigned at VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

      {% endnote %}

   1. Click **Save**.
   1. Under **Scaling**, enter the **Size** of the instance group: 2.
   1. Under **Integration with Application Load Balancer**, select **Create target group** and specify `mysite-tg` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
   1. Click **Create**.

{% endlist %}

It may take several minutes to create an instance group. Once the group's [status](../../compute/concepts/instance-groups/statuses.md#group-statuses) changes to `RUNNING` and the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of all of its VMs to `RUNNING_ACTUAL`, you can [upload the website files to them](#upload-site-files).

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

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **Backend groups** tab. Click **Create backend group**.
   1. Specify a **Name** for the backend group: `my-site-bg`.
   1. Under **Backends**, click **Add**.
   1. Specify a **Name** for the backend: `mysite-backend`.
   1. In the **Target group** field, select `mysite-tg`.
   1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
   1. Click **Add health check**.
   1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
   1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
   1. Click **Create**.

{% endlist %}

## Create and configure an HTTP router {#create-http-router}

The backend group should be linked to an [HTTP router](../../application-load-balancer/concepts/http-router.md) that defines routing rules.

To create an HTTP router:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **HTTP routers** tab. Click **Create HTTP router**.
   1. Specify a **Name** for the HTTP router: `mysite-router`.
   1. Click **Add virtual host**.
   1. Specify a **Name** for the virtual host: `mysite-host`.
   1. In the **Authority** field, specify the site's domain name as `my-site.com`.
   1. Click **Add route**.
   1. Specify a **Name** for the route: `mysite-route`.
   1. In the **Backend group** field, select `my-site-bg` as the group.
   1. Click **Create**.

{% endlist %}

## Create an L7 load Balancer {#create-l7-balancer}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Click **Create L7 load balancer**.
   1. Specify a **Name** for the load balancer: `mysite-alb`.
   1. Under **Network settings**, select the `mysite-sg-balancer` security group that you [created previously](#create-security-groups).
   1. Create a listener to redirect HTTP requests to HTTPS:

      1. Click **Add listener** under **Listeners**.
      1. Enter a **Name** for the listener: `listener-http`.
      1. Under **Public IP address settings**, select the **List** type and the IP address [reserved previously](#reserve-ip).
      1. In the **Protocol** field, select **Redirect to HTTPS**.

   1. Create an HTTPS request listener:

      1. Click **Add listener** again.
      1. Enter a **Name** for the listener: `listener-https`.
      1. Under **Public IP address settings**, select the **List** type and the IP address [reserved previously](#reserve-ip).
      1. In the **Protocol** field, select **HTTPS**.
      1. Under **Main listener**, select the `mysite-cert` certificate and the `mysite-router` HTTP router.
      1. Add an SNI match for `my-site.com`:

         1. Click **Add SNI match**.
         1. Specify a **Name** for the SNI match: `mysite-sni`.
         1. In the **Server names** field, enter `my-site.com`.
         1. Select the `mysite-cert` certificate and the `mysite-router` HTTP router.

   1. Click **Create**.

{% endlist %}

Wait 15 to 20 minutes after setting up the DNS to check that the site is up.

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
