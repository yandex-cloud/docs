

In this tutorial, you will install and configure [WordPress](https://wordpress.org/), a content management system equally suitable for personal blogs and large-scale media and commercial projects. You will deploy [{{ cloud-apps-name }}](../../cloud-apps/) on a virtual machine with all required resources autoconfigured, including a web server and [{{ postbox-name }}](../../postbox/) integration.

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
* Fee for storage of and operations with secrets (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for outgoing emails (see [{{ postbox-full-name }} pricing](../../postbox/pricing.md)).


## Create a {{ vpc-short-name }} network and subnets {#create-network}

Create a [cloud network](../../vpc/concepts/network.md) with a [subnet](../../vpc/concepts/network.md#subnet) to deploy the VM in.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to deploy your infrastructure.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Keep **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** enabled.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a cloud network in the default folder:

      ```
      yc vpc network create --name wordpress-network
      ```

  1. Get the list of the cloud networks in the folder:

      ```
      yc vpc network list --folder-id b1g6ci08ma55********
      ```

      Result:

      ```
      +----------------------+-------------------+
      |          ID          |      NAME         |
      +----------------------+-------------------+
      | enpavfmgapum******** | wordpress-network |
      | enplom7a98s1******** | default           |
      +----------------------+-------------------+
      ```

  1. Select `NAME` or `ID` of the cloud network you need. Create a subnet in any availability zone:

      ```
      yc vpc subnet create \
        --network-id enpavfmgapum******** \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Where:

      * `--network-id`: Cloud network ID. When creating a subnet, specify the cloud network for the subnet and CIDR.
      * `--zone`: Subnet availability zone.
      * `--range`: List of internal IPv4 addresses specified for this subnet, such as `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, and the maximum subnet size is `/16`. Only IPv4 is supported.

      The subnet naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

- API {#api}

  To create a cloud network, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call and provide the ID of the folder to host the new network in the `folderId` parameter of your request:

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  To create a subnet, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call, and provide the following in the request:

  * ID of the folder the subnet will reside in, in the `folderId` parameter.
  * ID of the network the subnet will be placed in, in the `networkId` parameter.
  * ID of the availability zone the subnet will be placed in, in the `zoneId` parameter.
  * List of internal IPv4 addresses specified for this subnet, in the `v4CidrBlocks[]` array, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, while the maximum subnet size is `/16`. Only IPv4 is supported.

  {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

{% endlist %}


## Configure a DNS zone {#configure-dns}

{% include [wordpress-configure-dns](../_tutorials_includes/wordpress/configure-dns.md) %}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Create {{ lockbox-name }} secrets {#create-secret}

{{ lockbox-name }} [secrets](../../lockbox/concepts/secret.md) will store the {{ mmy-name }} database password, database root password, and WordPress admin password.

{% list tabs group=instructions %}

- Management console {#console}

  To create a secret that will store the {{ mmy-name }} database password:

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `db-password-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** field, specify `db_password`.
  1. In the **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** field, paste the {{ mmy-name }} database password.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Repeat the steps to create two more secrets:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Description
  --- | --- | ---
  `db-root-password-secret`  | `db_root_password`  | {{ mmy-name }} database root password
  `wp-admin-password-secret` | `wp_admin_password` | WordPress administrator password


- {{ yandex-cloud }} CLI {#cli}

  To create a secret that will store the {{ mmy-name }} database password, run this command:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<password>'}]"
  ```

  Where `text_value` is the {{ mmy-name }} database password.

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

  Repeat the steps to create two more secrets:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Description
  --- | --- | ---
  `db-root-password-secret`  | `db_root_password`  | {{ mmy-name }} database root password
  `wp-admin-password-secret` | `wp_admin_password` | WordPress administrator password

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

  Use the following names and keys:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Description
  --- | --- | ---
  `db-password-secret`       | `db_password`       | {{ mmy-name }} database password
  `db-root-password-secret`  | `db_root_password`  | {{ mmy-name }} database root password
  `wp-admin-password-secret` | `wp_admin_password` | WordPress administrator password

{% endlist %}

{% note info %}

Creating secrets with the database root password or WordPress admin password is not mandatory: you can omit them in the application settings, in which case they will be created automatically with random passwords when installing the application.

{% endnote %}


## Install WordPress {#install-wordpress}

Install [WordPress](/marketplace/products/yc/wordpress-app) using {{ cloud-apps-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Click **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. Select the **WordPress** app and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Configure the application:

      {% note warning %}

      Once created, the WordPress admin login cannot be edited.

      {% endnote %}

      #|
      || **Parameter** | **Required** | **Default value** | **Description** ||
      || **{{ ui-key.yacloud.common.name }}** | Yes | — | Name of your WordPress instance. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Application instance description. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Yes | — | Service account with the `admin` role for the folder. To create a service account with the required permissions during app installation, select `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **DNS zone ID** | Yes | — | ID of the DNS zone to host the application's domain. ||
      || **Site subdomain** | — | Empty | Domain for access to the main website, formed by adding a subdomain to the DNS zone domain, i.e., `site.example.com` or `example.com` if no subdomain is specified. ||
      || **Subdomain of the database admin panel** | — | `db` | Domain for access to the website's admin panel, formed by adding a subdomain to the DNS zone domain, e.g., `db.example.com`. ||
      || **Email sender** | — | `noreply@<website_domain>` | Email sender. Used to set up SMTP via {{ postbox-name }}. ||
      || **WordPress administrator username** | — | `admin` | Username for the WordPress admin account. ||
      || **WordPress administrator email** | Yes | — | Email address to use for creating the WordPress admin account, sending system notifications, and resetting the password. ||
      || **ID of the secret with the WordPress admin password** | — | — | ID of the `wp-admin-password-secret` secret with the WordPress administrator password you created earlier. If you do not specify a secret, it will be created automatically with a random password when installing the application. ||
      || **VPC subnet** | Yes | — | Subnet to deploy your VM in. ||
      || **Number of vCPUs** | — | `2` | Number of vCPUs. ||
      || **RAM in GB** | — | `2` | RAM in GB. ||
      || **Guaranteed vCPU share** | — | `100` | Guaranteed vCPU share in %. Available values: 20%, 50%, or 100%. ||
      || **Public SSH key** | — | — | The key will be added to `authorized_keys` of the WordPress user.
      We recommend specifying a public SSH key to access the VM over SSH. You will need to create a key pair for the SSH connection yourself; see [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for details. ||
      || **Disk type** | — | `network-ssd` | Type of disk to attach to the VM. ||
      || **Disk size in GB** | — | `20` | Size of disk to attach to the VM, in GB. ||
      || **ID of the secret with the database password** | Yes | — | ID of the `db-password-secret` secret you created earlier to store the database password for accessing the {{ mmy-name }} cluster. ||
      || **ID of the secret with the database root password** | Yes | — | ID of the `db-root-password-secret` secret you created earlier to store the password for accessing the {{ mmy-name }} cluster. ||
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

1. Delete the {{ postbox-name }} address and the associated [DNS record](../../dns/operations/resource-record-delete.md) because they will not be deleted after you delete the application.
1. Delete the installed WordPress app:

   1. In the [management console]({{ link-console-main }}), select the folder the application is installed in.
   1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Find WordPress in the list.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the app and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the app deletion.

1. [Delete](../../dns/operations/zone-delete.md) the public DNS zone.
1. [Delete](../../lockbox/operations/secret-delete.md) the {{ lockbox-name }} secrets.
1. Delete the {{ vpc-short-name }} [network](../../vpc/operations/network-delete.md) and [subnets](../../vpc/operations/subnet-delete.md).
