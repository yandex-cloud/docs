# Installing Ghost CMS High Availability using {{ cloud-apps-name }}

Follow this guide to install and configure [Ghost CMS High Availability](https://ghost.org/), a content publishing and blogging platform. You will deploy [{{ cloud-apps-full-name }}](../../cloud-apps/) on a virtual machine with all required resources autoconfigured, including a database, a web server, and email service integration.

To install Ghost CMS High Availability:

1. [Get your cloud ready](#before-you-begin).
1. [Create a {{ vpc-short-name }} network and subnets](#create-network).
1. [Configure a DNS zone](#configure-dns).
1. [Create a {{ lockbox-name }} secret](#create-secret).
1. [Install Ghost CMS High Availability](#install-ghost).
1. [Configure Ghost CMS High Availability](#configure-ghost).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for [VM](../../compute/concepts/vm.md) usage and data storage on [disk](../../compute/concepts/disk.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using [public IP address](../../vpc/concepts/address.md#public-addresses) and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for public [DNS zone](../../dns/concepts/dns-zone.md) usage and public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).
* Fee for computing resources allocated to {{ MY }} [hosts](../../managed-mysql/concepts/index.md), storage and backup size (see [{{ mmy-full-name }} pricing](../../managed-mysql/pricing.md)).
* Fee for using a [bucket](../../storage/concepts/bucket.md) to store media files (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for storage of and operations with [secrets](../../lockbox/concepts/secret.md) (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for outgoing emails (see [{{ postbox-full-name }}](../../postbox/pricing.md) pricing).


## Create a {{ vpc-short-name }} network and subnets {#create-network}

{% include [create-network](../_tutorials_includes/website/create-network.md) %}


## Configure a DNS zone {#configure-dns}

Create a [public DNS zone](../../dns/concepts/dns-zone.md#public-zones) and delegate your domain to it. For more about delegating domains, see [this guide](../../troubleshooting/dns/how-to/delegate-public-zone.md).

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Create a {{ lockbox-name }} secret {#create-secret}

Create a [{{ lockbox-name }}](../../lockbox/) secret to store the [{{ mmy-name }}](../../managed-mysql/) database password.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `db-password-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `db_password`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, set a password for the {{ mmy-name }} database. Password requirements:

      * It must be from 8 to 128 characters long.
      * It must contain numbers, upper-case and lower-case Latin letters, and special characters.
      * It cannot consist only of digits.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<password>'}]"
  ```

  Where `text_value` is the {{ mmy-name }} database password. Password requirements:

  * It must be from 8 to 128 characters long.
  * It must contain numbers, upper-case and lower-case Latin letters, and special characters.
  * It cannot consist only of digits.

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

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

  Specify `db_password` in the `key` parameter for the key to contain the {{ mmy-name }} database password. Password requirements:

  * It must be from 8 to 128 characters long.
  * It must contain numbers, upper-case and lower-case Latin letters, and special characters.
  * It cannot consist only of digits.

{% endlist %}


## Install Ghost CMS High Availability {#install-ghost}

Install [Ghost CMS High Availability](marketplace/products/yc/ghost-cms-ha) using {{ cloud-apps-name }}.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Click **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. In the window that opens, select **Ghost CMS High Availability**.
  1. Configure your application:

      #|
      || **Parameter** | **Required** | **Default value** | **Description** ||
      || **{{ ui-key.yacloud.common.name }}** | Yes | — | Application instance name. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Application instance description. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Yes | — | Service account you are going to use to install the app. The service account must have the `admin` role for the folder.
      To create a service account with the required permissions during app installation, select `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **DNS zone ID** | Yes | — | ID of the DNS zone to host the application's domain. ||
      || **Site subdomain** | — | Empty | Domain for access to the main website, formed by adding a subdomain to the DNS zone domain, i.e., `site.example.com` or `example.com` if no subdomain is specified. ||
      || **Administrator dashboard subdomain** | — | `admin` | Domain for access to the admin panel, formed by adding a subdomain to the DNS zone domain, e.g., `admin.example.com/ghost`. ||
      || **Sender** | — | `noreply@<website_domain>` | Email sender. Used to set up [SMTP](https://{{ lang }}.wikipedia.org/wiki/SMTP) via {{ postbox-name }}. ||
      || **Subnet in {{ region-id }}-a** | Yes | — | Subnet in the `{{ region-id }}-a` availability zone for the {{ mmy-name }} cluster, created previosly.
||
      || **Subnet in {{ region-id }}-d** | Yes | — | Subnet in the `{{ region-id }}-d` availability zone for the {{ mmy-name }} cluster, created previosly. ||
      || **VPC subnet for the VM** | — | Subnet in the `{{ region-id }}-d` availability zone. | Subnet to host the new VM. ||
      || **Number of vCPUs** | — | `2` | Number of vCPUs. ||
      || **RAM** | — | `2` | RAM in GB. ||
      || **Guaranteed vCPU share** | — | `100` | Guaranteed vCPU share in %. The available values are 20%, 50%, or 100%. ||
      || **Public SSH key** | — | — | The key will be added to `authorized_keys` of the `ghost` VM user.
      We recommend specifying a public SSH key to access the VM over SSH. You need to create a key pair for the SSH connection on your own. To learn how, see [Connecting to a VM over SSH](../../compute/operations/vm-connect/ssh.md). ||
      || **Disk type** | — | `network-ssd` | VM disk type. ||
      || **Disk size** | — | `20` | VM disk size in GB. ||
      || **ID of the secret containing the database password** | Yes | — | Secret containing the password to connect to a {{ mmy-name }} cluster. This password should be specified in the `db_password` key. ||
      || **{{ mmy-name }} cluster disk size** | — | `20` | {{ mmy-name }} cluster disk size in GB. ||
      |#

  1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

      Installing the app and creating all required resources will take from five to ten minutes.

      As soon as all resources are created, the VM will start configuring the website and issuing TLS certificates. Wait for the installation to complete.

{% endlist %}


## Configure Ghost CMS High Availability {#configure-ghost}

Once the app is successfully installed, configure Ghost CMS High Availability:

1. In your browser, open the admin panel using its address:

    ```text
    https://<admin_panel_subdomain>.<domain>/ghost
    ```

    Where:

    * `<admin_panel_subdomain>`: Admin panel subdomain you specified when creating the application. The default value is `admin`.
    * `<your_domain>`: Domain you specified when creating the DNS zone.

    For example: `https://admin.example.com/ghost`.

1. Fill out the admin registration form:

    * **Site title**: Enter a name for the website.
    * **Full name**: Enter a name to publish posts under.
    * **Email address**: Specify the email address for logging in to the admin panel. You will get a notification at this address.
    * **Password**: Create a secure password for logging in to the admin panel.

1. Click **Create account & start publishing**.

    After you register, the page will redirect you to the Ghost CMS High Availability admin panel where you can start using the website.


## Check the result {#check-result}

Make sure that Ghost CMS High Availability is up and running:

1. Create a test post:

    1. In the admin panel interface, click ![image](../../_assets/console-icons/plus.svg) next to the **Posts** tab.
    1. Provide the post title and content.
    1. Upload an image to the post. It will be automatically saved in the S3 bucket.
    1. At the top right, click **Publish** → **Continue, final review** → **Publish post, right now**.
    1. In the window that opens, copy the post link by clicking **Copy link**.


1. Open the link in your browser.

    You should see a post with a URL in this format:`https://example.com/new-post/`.


## How to delete the resources you created {#clear-out}

{% note warning %}

Do not manually delete automatically created resources: this may cause an error when uninstalling the app.

{% endnote %}

To shut down the resources you created and stop paying for them:

1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the {{ objstorage-name }} bucket you created when installing the app.
1. Delete the installed Ghost CMS High Availability app:

    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
    1. Locate the installed Ghost CMS High Availability app in the list.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the app and select **{{ ui-key.yacloud.common.delete }}**.
    1. Confirm the app deletion.

        Wait for the deletion to complete.

1. [Delete](../../dns/operations/zone-delete.md) the public DNS zone.
1. [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secret.
1. Delete the {{ vpc-short-name }} [network](../../vpc/operations/network-delete.md) and [subnets](../../vpc/operations/subnet-delete.md).
1. Delete the {{ postbox-name }} address and the associated DNS record because they will not be deleted after you delete the application.