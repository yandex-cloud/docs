---
title: Installing Ghost CMS CloudApp
description: Installing and configuring Ghost CMS via Cloud Apps in {{ yandex-cloud }}
keywords:
  - ghost
  - ghost cms
  - cloudapp
  - ghost installation
  - ghost cloudapp
---

# Installing Ghost CMS CloudApp in {{ yandex-cloud }}

Follow this guide to install and configure [Ghost CMS](https://ghost.org/) – a content publishing and blogging platform – via [Cloud Apps](../../cloud-apps/). You will deploy the app on a virtual machine with all required services autoconfigured, including a database, a web server, and email service integration.

To install Ghost CMS:

1. [Get your cloud ready](#before-you-begin).
1. [Configure a DNS zone](#configure-dns).
1. [Install Ghost CMS CloudApp](#install-ghost).
1. [Configure Ghost CMS](#configure-ghost).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Make sure the selected [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) has a [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) in at least one [availability zone](../../overview/concepts/geo-scope.md). Do it by selecting **{{ vpc-short-name }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for using a VM instance (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a public DNS zone and for public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).
* Fee for data storage on disk (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using an S3 bucket to store media files (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

## Configure a DNS zone {#configure-dns}

Before installing Ghost CMS, create a public DNS zone and delegate a domain to it. For more about delegating domains, see [this guide](../../troubleshooting/dns/how-to/delegate-public-zone.md).

{% list tabs group=instructions %}

* Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to create your [DNS zone](../../dns/concepts/dns-zone.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Specify the DNS zone settings:
     * **{{ ui-key.yacloud.dns.label_zone }}**: Specify your registered domain with a trailing dot, e.g., `example.com.`.
     * **{{ ui-key.yacloud.common.type }}**: Select `{{ ui-key.yacloud.dns.label_public }}`.
     * **{{ ui-key.yacloud.common.name }}**: Enter a name for the zone, e.g., `example-zone`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

     Delegation does not take effect immediately. It usually takes up to 24 hours for internet service providers to update records. You can check domain delegation using [Whois](https://www.reg.ru/whois/check_site) or the `dig` utility:

     ```bash
     dig +short NS example.com
     ```

     Result:

     ```text
     ns2.{{ dns-ns-host-sld }}.
     ns1.{{ dns-ns-host-sld }}.
     ```

* {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Create a public DNS zone:

     ```bash
     yc dns zone create \
       --name example-zone \
       --zone example.com. \
       --public-visibility
     ```

     Where `--zone` is your domain name, e.g., `example.com.`. The `--zone` parameter value must end with a trailing dot.

     Result:

     ```text
     id: dns39gihj0ef********
     folder_id: b1g681qpemb4********
     created_at: "2024-09-09T15:23:34.919887Z"
     name: example-zone
     zone: example.com.
     public_visibility: {}
     ```

     For more information about the `yc dns zone create` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

     Delegation does not take effect immediately. It usually takes up to 24 hours for internet service providers to update records.

* API {#api}

  To create a public DNS zone, use the [create](../../dns/api-ref/DnsZone/create.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md) gRPC API call.

  Delegate your domain to {{ yandex-cloud }} servers. Do it by specifying the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` DNS servers in your domain registrar's account.

{% endlist %}

## Install Ghost CMS CloudApp {#install-ghost}

Install [Ghost CMS](https://yandex.cloud/ru/marketplace/products/yc/ghost-cms) via Cloud Apps:

{% list tabs group=instructions %}

* Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to install the app.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Click **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. In the window that opens, select [**Ghost CMS**](https://yandex.cloud/en/marketplace/products/yc/ghost-cms).
  1. Provide the installation parameters:

     {% note info %}

     **Required parameters**:
     * **Subnet** (Host parameters)
     * **DNS zone ID** (Host parameters)

     Other parameters are optional or set to defaults.

     {% endnote %}

     **Common parameters**:

     * **{{ ui-key.yacloud.cloud-apps.section_parameters }}**: Enter a name and description (optional) for the app.
     * **{{ ui-key.yacloud.cloud-apps.label_service-account }}**: Select the service account you are going to use to install the app. If you do not have a service account, create one.

     **Host parameters**:

     * **Subnet**: Select a VPC network to deploy a VM in. **This is a required parameter.**
     * **DNS zone ID**: Select a DNS zone from the list. **This is a required parameter.** Subdomains will be created in the selected DNS zone.

     **Domain parameters**:

     * **Website subdomain**: Specify a subdomain within the selected DNS zone for access to the main website. The website domain will be determined by prepending the subdomain to the DNS zone domain.
     * **Admin panel subdomain**: Specify a subdomain within the selected DNS zone for access to the Ghost CMS admin panel. The default value is `admin`.  The admin panel domain will be determined by prepending the subdomain to the DNS zone domain. The admin panel will be available at `https://<admin-panel-subdomain>.<dns-zone-domain>/ghost`.
     * **Database admin panel subdomain**: Specify a subdomain within the selected DNS zone for access to the database admin panel. The default value is `db`. The database admin panel domain will be determined by prepending the subdomain to the DNS zone domain.
     * **Email sender**: Specify the email address that will be used to send notifications (e.g., on change of password or registration). The default value is `noreply@<website_domain>`.

     **Virtual machine parameters**:

     * **Number of vCPUs**: Specify the number of vCPUs. The default value is `2`.
     * **RAM in GB**: Specify the amount of RAM. The default value is `2`.
     * **Guaranteed vCPU share**: Specify the guaranteed share of CPU time (20, 50, or 100). The default value is `100`.
     * **Public SSH key**: Specify the public SSH key for VM access. If specified, it will be added to `authorized_keys` of the `ghost` user. This is an optional field.

     **Disk parameters**:

     * **Disk type**: Select the disk type. The default value is `network-ssd`.
     * **Disk size in GB**: Specify the disk size. The default value is `20`.

     **Database parameters**:

     * **DB password secret ID**: Specify the ID of the {{ lockbox-name }} secret containing the database password with the `db_password` key. If no secret is specified, a random password will be generated; you can find its value in the automatically created secret.
     * **DB root password secret ID**: Specify the ID of the {{ lockbox-name }} secret containing the root database password with the `db_root_password` key. If no secret is specified, a random password will be generated; you can find its value in the automatically created secret.

  1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     The app installation will take 5-10 minutes. The installation will create the following resources:

     * Service account.
     * Secrets for storing passwords and access keys.
     * Access permissions for the service account.
     * Public IP address for the VM.
     * Security group for the VM.
     * Data storage disk.
     * DNS zone entries for the webiste, admin panel, and DB admin panel subdomains.
     * S3 bucket for storing media files (images, GIFs, and other files uploaded to the website).

     {% note info %}

     Uploading video files to the S3 bucket is not supported due to limitations of the object storage plugin.

     {% endnote %}

     * VM with Ghost CMS.

     Once all the resources are created, the VM will begin configuring the website and issuing TLS certificates. Wait for the installation to complete.

{% endlist %}

{% note info %}

Installing the app automatically creates a {{ postbox-name }} address and DNS entry for its verification.

{% endnote %}

## Configure Ghost CMS {#configure-ghost}

Once the app is successfully installed, configure Ghost CMS:

1. Open the admin panel URL in your browser: `https://<admin-panel-subdomain>/ghost` (where `<admin-panel-subdomain>` is the subdomain you specified during installation or the website subdomain if no admin panel subdomain was specified).

1. Fill out the admin registration form:

   * **Website name**: Specify the name of your website.
   * **Name**: Specify your name.
   * **Email**: Specify the email address for logging in to the admin panel.
   * **Password**: Create a secure password for logging in to the admin panel.

1. Click **Create account and run website**.

1. After you register, the page will redirect you to the Ghost CMS admin panel where you can start using the website.

## Check the result {#check-result}

Make sure that Ghost CMS is up and running:

1. In your browser, open the main website subdomain you specified during the installation. You should see the Ghost CMS home page.

1. Create a test post:

   1. In the admin panel, click **New post**.
   1. Provide the post header and content.
   1. Upload an image to the post. It will be automatically saved in the S3 bucket.
   1. Publish the post.

1. Check that the post has appeared on the website home page.

1. Test email notifications:

   1. In the admin panel, go to the settings section.
   1. Try recovering the password using "Forgot password?".
   1. Check the mailbox you specified for the password recovery email.

   {% note info %}

   The integration with {{ postbox-name }} supports user registration and password recovery. {{ postbox-name }} does not support bulk mailing because the feature requires a special API.

   {% endnote %}

1. Optionally, if you have specified the DB admin panel domain, open it in your browser:

   1. Log in to the the DB admin panel.
   1. Use these credentials:
      * **Server**: `db`.
      * **Engine**: `MySQL`.
      * **Username**: `ghost`.
      * **Password**: Database password. You can view the password value in the secret that was automatically generated during the installation. The secret name contains `db-passwords-secret`.

## How to delete the resources you created {#clear-out}

To shut down the resources you created and stop paying for them:

1. Delete the installed Ghost CMS app:

   1. In the [management console]({{ link-console-main }}), select the folder the application is installed in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Find the installed Ghost CMS app in the list.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the app and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the app deletion.

   {% note warning %}

   When you delete the app, the following is not deleted automatically:
   * {{ postbox-name }} address created during the installation.
   * DNS entry for {{ postbox-name }} verification.

   These resources need to be deleted manually.

   {% endnote %}

1. [Delete](../../dns/operations/zone-delete.md) the public DNS zone if you no longer need it.
1. Delete the {{ postbox-name }} address and DNS entries related to it if you no longer need them.
