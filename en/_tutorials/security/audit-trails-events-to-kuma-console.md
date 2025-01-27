# Uploading {{ at-full-name }} audit logs to KUMA SIEM through the management console, CLI, or API

To configure delivery of [audit log](../../audit-trails/concepts/format.md) files to [KUMA](https://www.kaspersky.com/enterprise-security/unified-monitoring-and-analysis-platform):

1. [Prepare your cloud environment](#before-you-begin).
1. [Prepare your environment](#setup-environment).
1. [Create a bucket](#create-bucket).
1. [Create a trail](#create-trail).
1. [Create a server](#create-server).
1. [Mount the bucket on a server](#mount-bucket).
1. [Configure the KUMA collector](#setup-collector).

If you no longer need the resources you created, [delete them](#clear-out).


## Prepare your cloud environment{#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/audit-trails-events-to-kuma/paid-resources.md) %}


## Prepare your environment {#setup-environment}

### Create service accounts {#create-service-accounts}

For your new infrastructure to run properly, create two [service accounts](../../iam/concepts/users/service-accounts.md) as follows:

* `kuma-bucket-sa`: For the {{ objstorage-name }} bucket.
* `kuma-trail-sa`: For the {{ at-short-name }} trail.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name of the service account for the bucket: `kuma-bucket-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Repeat steps 3-5 to create the `kuma-trail-sa` service account for the trail.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Run the following commands:

      ```bash
      yc iam service-account create --name kuma-bucket-sa
      yc iam service-account create --name kuma-trail-sa
      ```

      Where `--name` represents the names of the service accounts.

      Result:

      ```text
      id: ajecikmc374i********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:11:42.593107676Z"
      name: kuma-bucket-sa
      
      id: ajedc6uq5o7m********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:11:45.856807266Z"
      name: kuma-trail-sa
      ```

  1. Save the new service accounts' IDs (`id`): you will need them in the next steps.

  For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

{% endlist %}


### Create a static access key {#create-static-key}

To mount a bucket on a server with a KUMA collector installed, create a [static access key](../../iam/concepts/authorization/access-key.md) for the `kuma-bucket-sa` service account.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `kuma-bucket-sa` service account.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key: you will need them later when mounting the bucket on the server.

      {% note alert %}

      After you close this dialog, the key value will not be shown again.

      {% endnote %}

- CLI {#cli}

  1. Run this command:

      ```bash
      yc iam access-key create --service-account-name kuma-bucket-sa
      ```

      Where `--service-account-name` is the name of the service account you are creating the key for.

      Result:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Save the ID (`key_id`) and secret key (`secret`): you will need them later when mounting the bucket on the server.

  For more information about the `yc iam access-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

- API {#api}

  To create a static access key, use the [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call.

{% endlist %}


### Create an encryption key {#create-encryption-key}

Create a [symmetric encryption key](../../kms/concepts/key.md) for encryption of audit logs in the bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and specify the key attributes:

      * **{{ ui-key.yacloud.common.name }}**: `kuma-key`.
      * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}**: `AES-256`.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Run this command:

      ```bash
      yc kms symmetric-key create \
        --name kuma-key \
        --default-algorithm aes-256
      ```

      Where:

      * `--name`: Key name.
      * `--default-algorithm`: [Encryption algorithm](../../kms/concepts/key.md#parameters).

      Result:

      ```text
      id: abje8mf3ala0********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-28T14:22:06Z"
      name: kuma-key
      status: ACTIVE
      primary_version:
        id: abjuqbth02kf********
        key_id: abje8mf3ala0********
        status: ACTIVE
        algorithm: AES_256
        created_at: "2024-11-28T14:22:06Z"
        primary: true
      default_algorithm: AES_256
      ```

  1. Save the symmetric key ID (`id`): you will need it later when creating the bucket.

  For more information about the `yc kms symmetric-key create` command, see the [CLI reference](../../cli/cli-ref/kms/cli-ref/symmetric-key/create.md).

- API {#api}

  To create a symmetric encryption key, use the [create](../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

{% endlist %}


### Assign roles to the service accounts {#assign-roles}

Assign to the service accounts the following [roles](../../iam/concepts/access-control/roles.md) for the folder and the encryption key [created](#create-encryption-key) earlier:

* To `kuma-trail-sa`:

    * `audit-trails.viewer` for the folder.
    * `storage.uploader` for the folder.
    * `kms.keys.encrypterDecrypter` for the encryption key.

* To `kuma-bucket-sa`:

    * `storage.viewer` for the folder.
    * `kms.keys.encrypterDecrypter` for the encryption key.

{% list tabs group=instructions %}

- Management console {#console}

  1. Assign roles for the folder:

      1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. Select the `kuma-trail-sa` service account from the list, use the search if required.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**; in the window that opens, select the `audit-trails.viewer` [role](../../audit-trails/security/index.md#at-viewer).

          Repeat this step and add the `storage.uploader` [role](../../storage/security/index.md#storage-uploader).

      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

      In the same way, assign the `storage.viewer` [role](../../storage/security/index.md#storage-viewer) for the folder to the `kuma-bucket-sa` service account.

  1. Assign roles for the encryption key:

      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}** and click on the line with `kuma-key`.
      1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Select the `kuma-trail-sa` service account.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `kms.keys.encrypterDecrypter` [role](../../kms/security/index.md#kms-keys-encrypterDecrypter).
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

      In the same way, assign the `kms.keys.encrypterDecrypter` role for the encryption key to the `kuma-bucket-sa` service account.

- CLI {#cli}

  1. Assign the `storage.viewer` role for the folder to `kuma-bucket-sa`:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role storage.viewer \
        --subject serviceAccount:<kuma-bucket-sa_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Name or [ID](../../resource-manager/operations/folder/get-id.md) of the folder the role is assigned for.
      * `--role`: Role ID.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) type and ID of the service account you are assigning the role to.

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.viewer
            subject:
              id: ajecikmc374i********
              type: serviceAccount
      ```

      In the same way, assign the `audit-trails.viewer` and `storage.uploader` roles for the folder to `kuma-trail-sa`.

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  2. Assign the `kms.keys.encrypterDecrypter` role for the encryption key to `kuma-bucket-sa`.

      ```bash
      yc kms symmetric-key add-access-binding kuma-key \
        --role kms.keys.encrypterDecrypter \
        --subject serviceAccount:<kuma-bucket-sa_ID>
      ```

      Where:

      * `--role`: Role ID.
      * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) type and ID of the service account you are assigning the role to.

      Result:

      ```text
      ...1s...done (4s)
      ```

      In the same way, assign the `kms.keys.encrypterDecrypter` role for the encryption key to `kuma-trail-sa`.

      For more information about the `yc kms symmetric-key add-access-binding` command, see the [CLI reference](../../cli/cli-ref/kms/cli-ref/symmetric-key/add-access-binding.md).

- API {#api}

  To assign a service account a role, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}


## Create a bucket {#create-bucket}

Create a [bucket](../../storage/concepts/bucket.md) for the trail to save audit logs to and enable [encryption](../../storage/concepts/encryption.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `my-audit-logs-for-kuma`.

      {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field, set the size of the bucket you are creating or enable **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Leave all other parameters as they are and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. On the page with a list of buckets that opens, select the new bucket.
  1. In the left-hand menu, select ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**and go to the **{{ ui-key.yacloud.storage.bucket.switch_encryption }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select the previously created `kuma-key`.
  1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- CLI {#cli}

  1. Create a bucket:

      ```bash
      yc storage bucket create --name <bucket_name>
      ```

      Where `--name` is the bucket name, e.g., `my-audit-logs-for-kuma`.

      {% include [bucket-name-note](../_tutorials_includes/audit-trails-events-to-kuma/bucket-name-note.md) %}

      Result:

      ```text
      name: my-audit-logs-for-kuma
      folder_id: b1g681qpemb4********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2024-11-28T15:01:20.816656Z"
      ```

      For more information about the `yc storage bucket create` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  2. Enable encryption for the new bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --encryption key-id=<symmetric_key_ID>
      ```

      Where:

      * `--name`: Bucket name.
      * `--encryption`: Symmetric key ID you got when [creating](#create-encryption-key) the key.

      Result:

      ```text
      name: my-audit-logs-for-kuma
      folder_id: b1g681qpemb4********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      acl: {}
      created_at: "2024-11-28T15:01:20.816656Z"
      ```

      For more information about the `yc storage bucket update` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/update.md).

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}


## Create a trail {#create-trail}

Create a [trail](../../audit-trails/concepts/trail.md) to collect and deliver audit logs.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and do the following in the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the trail: `kuma-trail`.
      1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

          * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
          * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Bucket you created earlier, e.g., `my-audit-logs-for-kuma`.
          * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

          {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

      1. Make sure the **{{ ui-key.yacloud.audit-trails.title_kms-key }}** field contains the encryption key named `kuma-key`. If the encryption key is not set, click **{{ ui-key.yacloud.audit-trails.action_add-bucket-key }}** and select this key.

      1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

          * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
          * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Automatically populated field containing the name of the current folder.

      1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}** above, select the `kuma-trail-sa` service account.
      1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, keep the `{{ ui-key.yacloud.common.disabled }}` value.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc audit-trails trail create \
    --name kuma-trail \
    --destination-bucket <bucket_name> \
    --destination-bucket-object-prefix <prefix> \
    --service-account-id <kuma-trail-sa_ID> \
    --filter-from-cloud-id <cloud_ID> \
    --filter-some-folder-ids <folder_ID>
  ```

  Where:

  * `--name`: Trail name.
  * `--destination-bucket`: [Name of the bucket](../../storage/concepts/bucket.md#naming) you created [earlier](#create-bucket) to upload audit logs to.
  * `--destination-bucket-object-prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be added to the names of the audit log objects in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.
  * `--service-account-id`: The `kuma-trail-sa` service account's [ID](../../iam/operations/sa/get-id.md) you got [earlier](#create-service-accounts). Your trail will use this account to upload audit log files to the bucket.
  * `--filter-from-cloud-id`: [ID](../../resource-manager/operations/cloud/get-id.md) of the cloud whose resources the trail will collect audit logs for.
  * `--filter-some-folder-ids`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder whose resources the trail will collect audit logs for.

  Result:

  ```text
  id: cnpabi372eer********
  folder_id: b1g681qpemb4********
  created_at: "2024-11-28T15:33:28.057Z"
  updated_at: "2024-11-28T15:33:28.057Z"
  name: kuma-trail
  destination:
    object_storage:
      bucket_id: my-audit-logs-for-kuma
      object_prefix: kuma
  service_account_id: ajedc6uq5o7m********
  status: ACTIVE
  cloud_id: b1gia87mbaom********
  filtering_policy:
    management_events_filter:
      resource_scopes:
        - id: b1g681qpemb4********
          type: resource-manager.folder
  ```

  For more information about the `yc audit-trails trail create` command, see the [CLI reference](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

- API {#api}

  To create a trail, use the [create](../../audit-trails/api-ref/Trail/create.md) REST API method for the [Trail](../../audit-trails/api-ref/Trail/index.md) resource or the [TrailService/Create](../../audit-trails/api-ref/grpc/Trail/create.md) gRPC API call.

{% endlist %}


## Creating a server {#create-server}

As a server to install the KUMA collector on, you can use a {{ compute-name }} [VM](../../compute/concepts/vm.md) or your own hardware. In this tutorial, we are using a {{ compute-short-name }} VM residing in a {{ vpc-full-name }} [cloud network](../../vpc/concepts/network.md#network).


### Create a network and subnet {#create-network}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create an infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Specify the network name, e.g., `kuma-network`.
  1. Make sure the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option is enabled.
  1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

- CLI {#cli}

  1. Create a cloud network:

      ```bash
      yc vpc network create --name kuma-network
      ```

      Where `--name` is the network name.

      Result:

      ```text
      id: enpnmb4jvubr********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-27T22:55:55Z"
      name: kuma-network
      default_security_group_id: enpjgspepn8k********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  2. Create a [subnet](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet create \
        --name kuma-network-{{ region-id }}-b \
        --network-name kuma-network \
        --zone {{ region-id }}-b \
        --range 10.1.0.0/24
      ```

      Where:

      * `--name`: Subnet name.
      * `--network-name`: Name of the network the subnet is created in.
      * `--zone`: The subnet's [availability zone](../../overview/concepts/geo-scope.md).
      * `--range`: Subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).

      Result:

      ```bash
      id: e2l7b3gpnhqn********
      folder_id: b1g681qpemb4********
      created_at: "2024-11-27T22:57:48Z"
      name: kuma-network-ru-central1-b
      network_id: enpnmb4jvubr********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 10.1.0.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. To create a cloud network, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

  1. To create a [subnet](../../vpc/concepts/network.md#subnet), use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}


### Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create the infrastructure in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `kuma-network-{{ region-id }}-b`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to give the VM a random external IP address from the {{ yandex-cloud }} pool or select a static IP address from the list if you reserved one in advance.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select the **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** option and specify the information required to access the VM:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username for the user you are going to create on the VM, e.g., `yc-user`.

          {% include [name-format-2](../../_includes/name-format-2.md) %}

          {% include [dont-use-root-name](../../_includes/dont-use-root-name.md) %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `kuma-server`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc compute instance create \
    --name kuma-server \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=kuma-network-{{ region-id }}-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-id=fd8ulbhv5dpakf3io1mf \
    --ssh-key <SSH_key>
  ```

  Where:

  * `--name`: VM name.
  * `--zone`: [Availability zone](../../overview/concepts/geo-scope.md) corresponding to the `kuma-network-{{ region-id }}-b` subnet.
  * `--network-interface`: Network settings:

      * `subnet-name`: Subnet name.
      * `nat-ip-version`: [Public IP address](../../vpc/concepts/address.md#public-addresses).

  * `--create-boot-disk`: Boot [disk](../../compute/concepts/disk.md) settings, where `image-id` is the [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) public image ID.

  * `--ssh-key`: Path to the public SSH key file and its name, e.g., `~/.ssh/id_ed25519.pub`. You need to create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.

      When the VM is created, a user named `yc-user` will be created in its operating system; use this username to connect to the VM over SSH.

  Result:

  ```text
  id: epd4vr5ra728********
  folder_id: b1g681qpemb4********
  created_at: "2024-11-27T23:00:38Z"
  name: kuma-server
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdk5emph7a4********
    auto_delete: true
    disk_id: epdk5emph7a4********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:4f:ec:bb:51
      subnet_id: e2l7b3gpnhqn********
      primary_v4_address:
        address: 10.1.0.4
        one_to_one_nat:
          address: 84.2**.***.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epd4vr5ra728********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V1
  ```

  For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  To create a VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}


## Mount the bucket on a server {#mount-bucket}

{% include [mount-bucket](../_tutorials_includes/audit-trails-events-to-kuma/mount-bucket.md) %}


## Configure the KUMA collector {#setup-collector}

{% include [setup-collector](../_tutorials_includes/audit-trails-events-to-kuma/setup-collector.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
1. [Delete the subnet](../../vpc/operations/subnet-delete.md).
1. [Delete the network](../../vpc/operations/network-delete.md).
1. Delete the [trail](../../audit-trails/concepts/trail.md).
1. [Delete](../../storage/operations/objects/delete-all.md) all objects in the bucket, then [delete](../../storage/operations/buckets/delete.md) the bucket itself.
1. [Delete](../../kms/operations/key.md#delete) the {{ kms-short-name }} encryption key.
