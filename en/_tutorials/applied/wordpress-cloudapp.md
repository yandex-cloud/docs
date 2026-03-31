

In this tutorial, you will install and configure [WordPress](https://wordpress.org/), a content management system equally suitable for personal blogs and large-scale media and commercial projects. You will deploy [{{ cloud-apps-name }}](../../cloud-apps/) on a virtual machine with all required resources autoconfigured, including a [{{ mmy-full-name }}](../../managed-mysql/) database, a web server, and [{{ postbox-name }}](../../postbox/) integration.

To install WordPress:

1. [Get your cloud ready](#before-you-begin).
1. [Create a {{ vpc-short-name }} network and subnets](#create-network).
1. [Configure a DNS zone](#configure-dns).
1. [Create a {{ lockbox-name }} secret](#create-secret).
1. [Install WordPress using {{ cloud-apps-name }}](#install-wordpress).
1. [Configure WordPress](#configure-wordpress).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for VM usage and data storage on disk (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for public DNS zone usage and public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).
* Fee for computing resources allocated to hosts, storage and backup size (see [{{ mmy-full-name }} pricing](../../managed-mysql/pricing.md)).
* Fee for using a bucket to store media files (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for storage of and operations with secrets (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for outgoing emails (see [{{ postbox-full-name }} pricing](../../postbox/pricing.md)).

## Create a {{ vpc-short-name }} network and subnets {#create-network}

{% include [create-network](../_tutorials_includes/website/create-network.md) %}

## Configure a DNS zone {#configure-dns}

Create a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones) and delegate your domain to it. For more about delegating domains, see [this guide](../../troubleshooting/dns/how-to/delegate-public-zone.md). This DNS zone will host the WordPress domains.

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}

## Create a {{ lockbox-name }} secret {#create-secret}

{{ lockbox-name }} [secrets](../../lockbox/concepts/secret.md) will store the password of the {{ mmy-full-name }} database and the WordPress admin password.

{% list tabs group=instructions %}

- Management console {#console}

  To create a secret that will store the {{ mmy-full-name }} database password:

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `db-password-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `db_password`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, paste the {{ mmy-full-name }} database password.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Similarly, create a secret named `wp-admin-password-secret` that will store the WordPress admin password. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, specify `wp_admin_password`.

- {{ yandex-cloud }} CLI {#cli}

  To create a secret that will store the {{ mmy-full-name }} database password, run this command:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<password>'}]"
  ```

  Where `text_value` is the {{ mmy-full-name }} database password.

  Result:

  ```text
  id: e6q0rdjdggjp********
  folder_id: b1g681qpemb4********
  created_at: "2025-07-12T18:23:49.844Z"
  name: db-password-secret
  status: ACTIVE
  current_version:
    id: e6qbp772i014********
    secret_id: e6q0rdjdggjp********
    created_at: "2025-07-12T18:23:49.844Z"
    status: ACTIVE
    payload_entry_keys:
      - db_password
  ```

  Similarly, create a secret that will store the WordPress admin password. Specify `wp_admin_password` in the `key` parameter.

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

  Specify `db_password` in the `key` parameter for the key to contain the {{ mmy-full-name }} database password. Specify `wp_admin_password` for the key to store the WordPress administrator password.

{% endlist %}

{% note info %}

Creating a secret with a WordPress admin password is not mandatory: you can omit it in the application settings; in this case, it will be created automatically with a random password when installing the application.

{% endnote %}

## Install WordPress {#install-wordpress}

Install [WordPress High Availability](/marketplace/products/yc/wordpress-ha-app) using {{ cloud-apps-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Click **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. In the window that opens, select **WordPress High Availability**.
  1. Configure the application:


     * Application name: Name of your WordPress High Availability instance.
     * Application description. This is an optional property.
     * Service account with the `admin` role for the folder, or select `Auto` to have the service account created when installing the application.
     * DNS zone ID.
     * Site subdomain for WordPress. This is an optional property. By default, the subdomain is empty. The website domain is formed by adding a subdomain to the DNS zone domain.
     * Mail sender. This is an optional property. The default is `noreply@website_domain`. Used to set up SMTP via {{ postbox-name }}.
     * WordPress administrator username: Username for the WordPress admin account. This is an optional property. The default value is `admin`.

       {% note warning %}

       Once created, the WordPress admin login cannot be edited.

       {% endnote %}

     * The WordPress administrator email to use for creating the WordPress admin account, sending system notifications, and resetting the password.
     * ID of the `wp-admin-password-secret` secret with the WordPress administrator password you created earlier. This is an optional property. If you do not specify a secret, it will be created automatically with a random password when installing the application.
     * VPC subnets in the `ru-central1-a` and `ru-central1-d` availability zones for deploying a {{ mmy-name }} cluster and VMs with a file system.
     * Instance group size: The number of VMs in the group. This is an optional property. The default value is 2.
     * Number of vCPUs. This is an optional property. The default value is 2.
     * RAM in GB. This is an optional property. The default value is 2 GB.
     * vCPU guarantee. This is an optional property. The available values are 20%, 50%, or 100%. The default value is 100%.
     * Public SSH key. This is an optional property. It will be added to the WordPress user's `authorized_keys`. To learn how to create an SHH key, see [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * File system size in GB. This is an optional property. The default value is 100 GB.
     * ID of the `db-password-secret` secret you created earlier to store the database password for accessing the {{ mmy-name }} cluster.
     * {{ mmy-name }} cluster disk size in GB. This is an optional property. The default value is 20 GB.

  1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     In the window that opens, you will see the resources that will be created when installing the application. As soon as all resources are created, the VM will start configuring the website, installing plugins, and issuing TLS certificates. Wait for the installation to complete. This may take five to ten minutes.

{% endlist %}

{% note info %}

Automatic installation of the app creates a {{ postbox-name }} [address](../../postbox/concepts/glossary.md#adress) and a DNS record for its verification.

{% endnote %}

## Configure WordPress {#configure-wordpress}

1. In your browser, open the main website address: `https://<website_domain>`, where `<website_domain>` is the main website subdomain or the DNS zone domain, if no subdomain was provided.

1. In your browser, open the admin dashboard address: `https://<website_domain>/wp-admin`.

1. Log in to the admin dashboard using:
   * **Username**: Admin username you provided when installing the application.
   * **Password**: Admin password. If you did not specify a secret containing the admin password in the application settings, you can find the password value in the secret that was generated automatically during the installation. The secret name is `wp-admin-password-secret`.

      {% note info %}

      If you forget the password, you can recover it via the standard WordPress password reset form using the admin email address specified during installation.

      {% endnote %}

Once you log in, you will be redirected to the WordPress admin dashboard page where you can start managing your website.

## Check the result {#check-result}

Make sure WordPress is working correctly:

1. In your browser, open the main website subdomain, if specified during installation. Otherwise, open the DNS zone domain. You should see the WordPress home page.

1. Create a test post:

   1. In the admin dashboard, click **Posts** → **Add New**.
   1. Provide the post title and content.
   1. Upload an image to the post. It will be automatically saved to the {{ objstorage-name }} bucket.
   1. Publish the post.

1. Make sure that the post appears on the website home page.

1. Test email notifications:

   1. In the admin dashboard, go to the settings section.
   1. Try resetting the password using **Lost your password?**.
   1. Check the mailbox you specified for the password reset email.

   {% note info %}

   Integration with {{ postbox-name }} supports user sign-ups and password resets. {{ postbox-name }} does not support bulk mailing because the feature requires a special API.

   {% endnote %}

1. Check the installed plugins:

   1. In the admin dashboard, go to **Plugins**.
   1. Make sure the following plugins are installed:
      * **S3 Uploads**: For integration with **{{ objstorage-full-name }}** to store media files.
      * **WP Mail SMTP**: For integration with **{{ postbox-full-name }}** to send email notifications.

1. Open the database admin dashboard domain in your browser:

   1. Log in to the database admin dashboard.
   1. Use these credentials:
      * **Server**: `db`.
      * **Engine**: `MySQL`.
      * **Username**: `wordpress`.
      * **Password**: Database password you specified in `db-passwords-secret`.

## How to delete the resources you created {#clear-out}

To shut down the resources you created and stop paying for them:

1. Delete the {{ postbox-name }} address and the associated DNS record because they will not be deleted after you delete the application.
1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the {{ objstorage-name }} buckets created when installing the application because non-empty buckets cannot be deleted.
1. Delete WordPress High Availability:

   1. In the [management console]({{ link-console-main }}), select the folder the application is installed in.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Find WordPress High Availability in the list.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the app and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the app deletion.

1. [Delete](../../dns/operations/zone-delete.md) the public DNS zone.
1. [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secrets.
1. Delete the {{ vpc-short-name }} [network](../../vpc/operations/network-delete.md) and [subnets](../../vpc/operations/subnet-delete.md).
