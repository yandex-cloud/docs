---
title: "Virtual hosting: how to build it?"
description: "From these instructions, you'll learn how to build a virtual hosting of several websites having different domain names, on a single IP."
---

# Setting up virtual hosting

This use case describes how to set up virtual hosting, that is, how to use {{ alb-full-name }} to host multiple websites with different domain names on the same IP address.

As examples for the use case, we'll have three domain names: `site-a.com`, `site-b.com`, and `default.com`.

To create a virtual hosting:
1. [Prepare your cloud](#before-begin).
1. [Create a cloud network](#create-network).
1. [Reserve a static public IP address](#reserve-ip).
1. [Create security groups](#create-security-groups).
1. [Import TLS certificates of the sites to {{ certificate-manager-name }}](#import-certificates).
1. [Create instance groups for the sites](#create-vms).
1. [Upload the site files to the VMs](#upload-sites-files).
1. [Create backend groups](#create-backend-groups).
1. [Create and configure HTTP routers](#create-http-routers).
1. [Create an L7 load balancer](#create-l7-balancer).
1. [Configure the DNS for the sites](#configure-dns).
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

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Specify the Network **name**: `vhosting-network`.
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

[Security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) include rules that let the load balancer receive incoming traffic and redirect it to the VMs so they can receive the traffic. Two security groups will be created in the use case: the first one for the load balancer and the second one for all VMs.

To create security groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ vpc-name }}**.
   1. Open the **Security groups** tab.
   1. Create a security group for the load balancer:

      1. Click **Create group**.
      1. Enter the Group **name**: `vhosting-sg-balancer`.
      1. Select the **Network**: `vhosting-network`.
      1. Under **Rules**, create the following rules using the instructions below the table:

         | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source/<br/>destination type | Source /<br/>destination |
         | --- | --- | --- | --- | --- | --- |
         | Outgoing | any | All | Any | CIDR | 0.0.0.0/0 |
         | Incoming | ext-http | 80 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | ext-https | 443 | TCP | CIDR | 0.0.0.0/0 |
         | Incoming | healthchecks | 30080 | TCP | Load balancer health checks | N/A |

         1. Select the **Outgoing traffic** or **Incoming traffic** tab.
         1. Click **Add rule**.
         1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
         1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
         1. In the **Purpose** or **Source** field, select the purpose of the rule:

            * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
            * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
            * **Load balancer health checks**: Rule that allows a load balancer to check the health of VMs.

         1. Click **Save**. Repeat the steps to create all rules from the table.

      1. Click **Save**.

   1. In the same way, create a security group for the VM named `vhosting-sg-vms` with the same `vhosting-network` network and the following rules:

      | Traffic<br/>direction | Description | Port<br/>range | Protocol | Source type | Source |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | balancer | 80 | TCP | Security group | `vhosting-sg-balancer` |
      | Incoming | ssh | 22 | TCP | CIDR | 0.0.0.0/0 |

{% endlist %}

## Import TLS certificates of the sites to {{ certificate-manager-name }}{#import-certificates}

To let users access the sites using the secure HTTPS protocol (HTTP over TLS), you must have TLS certificates for the sites. To use certificates in the L7 load balancer, import the certificates to {{ certificate-manager-name }}.

If your sites don't have certificates, you can [obtain them from {{ certificate-manager-name }}Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md). You don't need to do anything else after creating certificates this way, because the certificates are imported automatically.

To import an existing certificate for `site-a.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ certificate-manager-name }}**.
   1. Click **Add certificate** and select **User certificate**.
   1. Enter the **Name** for the certificate: `vhosting-cert-a`.
   1. In the **Certificate** field, click **Add certificate**. Upload the **File** with your certificate or enter its **Contents** and click **Add**.
   1. If your certificate is issued by a third-party certificate authority, in the **Intermediate certificate chain** field, click **Add chain**. Upload the **File** with the certificate chain or enter its **Contents** and click **Add**.
   1. In the **Private key** field, click **Add private key**. Upload the **File** with the key or enter its **Contents** and click **Add**.
   1. Click **Create**.

{% endlist %}

In the same way, import certificates for `site-b.com` and `default.com`, naming them `vhosting-cert-b` and `vhosting-cert-default`.

## Create instance groups for the sites {#create-vms}

{{ compute-name }} VMs will act as web servers for the two websites: one [group](../../compute/concepts/instance-groups/index.md) of multiple identical VMs for each website. In this use case, the servers will be deployed on the LEMP stack (Linux, NGINX, MySQL, PHP). For more information, see the use case [Website on LAMP or LEMP stack](../../tutorials/web/lamp-lemp.md).

To create an instance group for `site-a.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
   1. Open the **Instance groups** tab. Click **Create group**.
   1. Enter the instance group name: `vhosting-ig-a`.
   1. Under **Allocation**, select multiple availability zones to ensure fault tolerance of your hosting.
   1. Under **Instance template**, click **Define**.
   1. Under **Image/boot disk selection**, open the **{{ marketplace-name }}** tab and click **Show more**. Select [LEMP](/marketplace/products/yc/lemp) and click **Use**.
   1. Under **Computing resources**:

      - Select the VM's [platform](../../compute/concepts/vm-platforms.md).
      - Specify the required number of vCPUs and the amount of RAM.

      The minimum configuration is enough for functional website testing:
      * **Platform**: Intel Ice Lake.
      * **Guaranteed vCPU share**: 20%.
      * **vCPU**: 2.
      * **RAM**: 1 GB.

   1. Under **Network settings**, select the **Network** named `vhosting-network` that you [created earlier](#create-network) and its subnets.
   1. In the **Public address** field, select **Auto**.
   1. Select the [previously created](#create-security-groups) `vhosting-sg-vms` security group.
   1. Specify data required for accessing the VM:
      - Enter the username in the **Login** field.
      - In the **SSH key** field, paste the contents of the public key file.

         You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

      {% note alert %}

      The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

      {% endnote %}

   1. Click **Save**.
   1. Under **Scaling**, enter the **Size** of the instance group: 2.
   1. Under **Integration with Application Load Balancer**, select **Create target group** and specify `vhosting-tg-a` as the group name. [Read more about target groups](../../application-load-balancer/concepts/target-group.md).
   1. Click **Create**.

{% endlist %}

That same way, create a second instance group named `vhosting-ig-b` and a target group named `vhosting-tg-b` for `site-b.com`.

It may take several minutes to create an instance group. Once the group's [status](../../compute/concepts/instance-groups/statuses.md#group-statuses) changes to `RUNNING` and the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of all of its VMs to `RUNNING_ACTUAL`, you can [upload the website files to them](#upload-sites-files).

![ig-running](../../_assets/application-load-balancer/tutorials/virtual-hosting/ig-running.png)

## Upload the site files to the VMs {#upload-sites-files}

To check that your web servers are running properly, upload to the VMs two different `index.html` files (with different contents): use one file for the `vhosting-ig-a` group VMs and other file for the `vhosting-ig-b` group VMs.

{% cut "Sample index.html file for the vhosting-ig-a group" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Site A</title>
  </head>
  <body>
    <p>This is site A</p>
  </body>
</html>
```

{% endcut %}

{% cut "Sample index.html file for the vhosting-ig-b group" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Site B</title>
  </head>
  <body>
    <p>This is site B</p>
  </body>
</html>
```

{% endcut %}

To upload a file to a VM:

{% include [upload-files](../_tutorials_includes/upload-web-site-files.md) %}

Repeat these steps for the files you want to upload to each VM in the `vhosting-ig-a` and `vhosting-ig-b` groups.

## Create backend groups {#create-backend-groups}

Target groups created together with instance groups must be linked to the [backend groups](../../application-load-balancer/concepts/backend-group.md) that define the traffic allocation settings.

For the backends, groups will implement [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks): the load balancer will periodically send health check requests to the VMs and expect a response after a certain delay.

To create a backend group for `site-a.com`:

1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
1. Open the **Backend groups** tab. Click **Create backend group**.
1. Enter the **Name** for the backend group: `vhosting-bg-a`.
1. Under **Backends**, click **Add**.
1. Enter the **Name** of the backend: `vhosting-backend-a`.
1. In the **Target group** field, select the `vhosting-tg-a` group.
1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
1. Click **Add health check**.
1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
1. Click **Create**.

That same way, create the second backend group named `vhosting-bg-b` for `site-b.com`. In the group, create the `vhosting-backend-b` backend and link the `vhosting-tg-b` target group to it.

## Create and configure HTTP routers {#create-http-routers}

Backend groups must be linked to [HTTP routers](../../application-load-balancer/concepts/http-router.md) that define the HTTP request routing rules. In this use case, you'll create two routers for the "main" sites (`site-a.com` and `site-b.com`) and the "default" router for the `default.com` site, which will respond to each request with the `404 Not Found` HTTP status code.

### Create HTTP routers for sites {#create-http-routers-sites}

To create an HTTP router for `site-a.com`:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **HTTP routers** tab. Click **Create HTTP router**.
   1. Enter the **Name** of the HTTP router: `vhosting-router-a`.
   1. Click **Add virtual host**.
   1. Enter the **Name** of the virtual host: `vhosting-host-a`.
   1. In the **Authority** field, specify the site's domain name: `site-a.com`.
   1. Click **Add route**.
   1. Enter the **Name** of the route: `vhosting-route-a`.
   1. In the **Backend group** field, select the `vhosting-bg-a` group.
   1. Click **Create**.

{% endlist %}

That same way, create the `vhosting-router-b` HTTP router for `site-b.com` and link the `vhosting-bg-b` backend group to it.

### Create the "default" HTTP router {#create-http-routers-default}

To create an HTTP router for the `default.com` site:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Open the **HTTP routers** tab. Click **Create HTTP router**.
   1. Enter the **Name** of the HTTP router: `vhosting-router-default`.
   1. Click **Add virtual host**.
   1. Enter the **Name** of the virtual host: `vhosting-host-default`.
   1. In the **Authority** field, specify the site's domain name: `default.com`.
   1. Click **Add route**.
   1. Enter the **Name** of the route: `vhosting-route-a`.
   1. In the **Action** field, select **Response**.
   1. In the **HTTP status code** field, select `404 Not Found`.
   1. In the **Response body** field, click **Select**. Select the **Text** method, then in the **Contents** field, enter:

      ```
      404 Not Found

      This is the default site.
      ```

      Click **Add**.
   1. Click **Create**.

{% endlist %}

## Create an L7 load Balancer {#create-l7-balancer}

To create a load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
   1. Click **Create L7 load balancer**.
   1. Enter the **Name** of the load balancer: `vhosting-alb`.
   1. Under **Network settings**, select the `vhosting-sg-balancer` security group that you [created previously](#create-security-groups).
   1. Create a listener to redirect HTTP requests to HTTPS:

      1. Click **Add listener** under **Listeners**.
      1. Enter the **Name** of the listener: `vhosting-listener-http`.
      1. Under **Public IP address settings**, select the **List** type and the IP address [reserved previously](#reserve-ip).
      1. In the **Protocol** field, select **Redirect to HTTPS**.

   1. Create an HTTPS request listener:

      1. Click **Add listener** again.
      1. Enter the **Name** of the listener: `vhosting-listener-https`.
      1. Under **Public IP address settings**, select the **List** type and the IP address [reserved previously](#reserve-ip).
      1. In the **Protocol** field, select **HTTPS**.
      1. Under **Main listener**, select the `vhosting-cert-default` certificate and the `vhosting-router-default` HTTP router.
      1. Add an SNI match for `site-a.com`:

         1. Click **Add SNI match**.
         1. Specify the **Name** for the SNI match: `vhosting-sni-a`.
         1. In the **Server names** field, enter `site-a.com`.
         1. Select the `vhosting-cert-a` certificate and the `vhosting-router-a` HTTP router.

      1. That same way, add an SNI match for `site-b.com`: with the name `vhosting-sni-b`, server name `site-b.com`, certificate `vhosting-cert-b`, and HTTP router `vhosting-router-b`.

   1. Click **Create**.

{% endlist %}

## Configure the DNS for the sites {#configure-dns}

The domain names `site-a.com`, `site-b.com`, and `default.com` must be linked to the L7 load balancer IP address using DNS records.

To configure the DNS for `site-a.com`:

1. In the [management console]({{ link-console-main }}), select **{{ alb-name }}**.
1. Copy the IP address of the load balancer that you created.
1. On the site of your DNS hosting provider, go to the DNS settings.
1. Create or edit the A record for `site-a.com` so that it links to the copied IP address:

   ```
   site-a.com. A <L7 load balancer IP address>
   ```

   If you use {{ dns-name }}, follow these instructions to configure the record:

   {% cut "Instructions for configuring DNS records for {{ dns-name }}" %}

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select **{{ dns-name }}**.
      1. If you don't have a public DNS zone, create one:

         1. Click **Create zone**.
         1. Enter the **Name** of the zone: `vhosting-dns-a`.
         1. In the **Zone** field, enter the site's domain name with a dot at the end: `site-a.com`.
         1. Select the zone **Type**: **Public**.
         1. Click **Create**.

      1. Create a record in the zone:

         1. In the list of zones, click `vhosting-dns-a`.
         1. Click **Create record**.
         1. Leave the **Name** field empty so that the record matches the `site-a.com` domain name (rather than a name with a subdomain, for example, `www.site-a.com`).
         1. Select the record **Type**: **A**.
         1. In the **Value** field, paste the copied IP address of the load balancer.
         1. Click **Create**.

   {% endlist %}

   {% endcut %}

That same way, configure the DNS for `site-b.com` and `default.com` using the same IP address.

Wait 15-20 minutes after setting up the DNS and check that the sites are running properly.

## Check that the hosting is running properly {#test}

To make sure that the hosting is running properly, open each of the three sites in your browser:

* `https://site-a.com` and `https://site-b.com`: the pages you [uploaded to the VMs](#upload-sites-files) should be displayed.
* `https://default.com`: the `404 Not Found` error page configured when [creating the HTTP router](#create-http-routers-default) should be displayed.

## Delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:

   1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the L7 load balancer `vhosting-alb`.
   1. [Delete](../../application-load-balancer/operations/http-router-delete.md) the HTTP routers: `vhosting-router-a`, `vhosting-router-b`, and `vhosting-router-default`.
   1. [Delete](../../application-load-balancer/operations/backend-group-delete.md) the backend groups: `vhosting-bg-a` and `vhosting-bg-b`.

1. [Delete](../../compute/operations/instance-groups/delete.md) the instance groups: `vhosting-ig-a` and `vhosting-ig-b`.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address that you reserved.
