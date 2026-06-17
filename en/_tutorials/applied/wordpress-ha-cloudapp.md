

In this tutorial, you will install and configure [WordPress](https://wordpress.org/), a content management system equally suitable for personal blogs and large-scale media and commercial projects. You will deploy [{{ cloud-apps-name }}](../../cloud-apps/) on a virtual machine with all required resources autoconfigured, including a [{{ mmy-full-name }}](../../managed-mysql/) database, a web server, and [{{ postbox-name }}](../../postbox/) integration.

To install WordPress:

1. [Get your cloud ready](#before-you-begin).
1. [Create a {{ vpc-short-name }} network and subnets](#create-network).
1. [Configure a DNS zone](#configure-dns).
1. [Create {{ lockbox-name }} secrets](#create-secret).
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

{% include [wordpress-configure-dns](../_tutorials_includes/wordpress/configure-dns.md) %}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Create {{ lockbox-name }} secrets {#create-secret}

{{ lockbox-name }} [secrets](../../lockbox/concepts/secret.md) will store the password of the {{ mmy-full-name }} database and the WordPress admin password.

{% list tabs group=instructions %}

- Management console {#console}

  To create a secret that will store the {{ mmy-full-name }} database password:

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `db-password-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** field, enter `db_password`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** field, paste the {{ mmy-full-name }} database password.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Similarly, create a secret named `wp-admin-password-secret` that will store the WordPress admin password. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** field, specify `wp_admin_password`.

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
  1. Select **WordPress High Availability** and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Configure the application:

      {% note warning %}

      Once created, the WordPress admin login cannot be edited.

      {% endnote %}

      #|
      || **Parameter** | **Required** | **Default value** | **Description** ||
      || **{{ ui-key.yacloud.common.name }}** | Yes | — | Name of your WordPress High Availability instance. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Application instance description. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Yes | — | Service account with the `admin` role for the folder. To create a service account with the required permissions during app installation, select `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **DNS zone ID** | Yes | — | ID of the DNS zone to host the application's domain. ||
      || **Site subdomain** | — | Empty | Domain for access to the main website, formed by adding a subdomain to the DNS zone domain, i.e., `site.example.com` or `example.com` if no subdomain is specified. ||
      || **Sender** | — | `noreply@<website_domain>` | Email sender. Used to set up SMTP via {{ postbox-name }}. ||
      || **WordPress administrator username** | — | `admin` | Username for the WordPress admin account. ||
      || **WordPress administrator email address** | Yes | — | Email address to use for creating the WordPress admin account, sending system notifications, and resetting the password. ||
      || **ID of the secret with the WordPress admin password** | — | — | ID of the `wp-admin-password-secret` secret with the WordPress administrator password you created earlier. If you do not specify a secret, it will be created automatically with a random password when installing the application. ||
      || **Subnet in {{ region-id }}-a** | Yes | — | Subnet in the {{ region-id }}-a availability zone for deploying a {{ mmy-name }} cluster and VMs with a file system. ||
      || **Subnet in {{ region-id }}-d** | Yes | — | Subnet in the {{ region-id }}-d availability zone for deploying a {{ mmy-name }} cluster and VMs with a file system. ||
      || **Instance group size** | — | `2` | Number of instances in the group. ||
      || **Number of vCPUs** | — | `2` | Number of vCPUs. ||
      || **RAM** | — | `2` | RAM in GB. ||
      || **Guaranteed vCPU share** | — | `100` | Guaranteed vCPU share in %. Available values: 20%, 50%, or 100%. ||
      || **Public SSH key** | — | — | The key will be added to `authorized_keys` of the WordPress user.
      We recommend specifying a public SSH key to access the VM over SSH. You will need to create a key pair for the SSH connection yourself; see [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for details. ||
      || **File system size** | — | `100` | File system size in GB. ||
      || **ID of the secret containing the database password** | Yes | — | ID of the `db-password-secret` secret you created earlier; the secret contains the password to connect to a {{ mmy-name }} cluster. ||
      || **{{ mmy-name }}** cluster disk size | — | `20` | {{ mmy-name }} cluster disk size in GB. ||
      |#

  1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     In the window that opens, you will see the resources that will be created when installing the application. As soon as all resources are created, the VM will start configuring the website, installing plugins, and issuing TLS certificates. Wait for the installation to complete. This may take five to ten minutes.

{% endlist %}

{% include [note-auto-address](../_tutorials_includes/wordpress/note-auto-address.md) %}


## Configure WordPress {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress/configure-wordpress.md) %}


## Check the result {#check-result}

{% include [check-result](../_tutorials_includes/wordpress/check-result.md) %}


## How to delete the resources you created {#clear-out}

To shut down the resources you created and stop paying for them:

1. Delete the {{ postbox-name }} address and the associated [DNS record](../../dns/operations/resource-record-delete.md). These resources are not removed automatically when you delete the application.
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
