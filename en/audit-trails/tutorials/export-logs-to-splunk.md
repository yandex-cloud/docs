# Exporting audit logs to SIEM Splunk systems

Create a trail to upload management event audit logs of resources in an individual folder to an {{ objstorage-full-name }} bucket with encryption enabled. Then configure continuous log delivery to SIEM Splunk.

The solution described in the tutorial follows the steps below:
1. A [trail](../concepts/trail.md) uploads logs to an {{ objstorage-name }} bucket.
1. The bucket is mounted as part of an intermediate VM's [filesystem](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).
1. The intermediate VM runs a script that pulls logs from the bucket on a schedule and pushes them to Splunk.

To configure delivery of audit log files from a bucket to Splunk:

1. [Prepare your cloud](#before-begin).
1. [Prepare the environment](#prepare-environment).
1. [Assign roles to the service account](#add-roles).
1. [Create a trail](#create-trail).
1. [Set up Splunk for import](#prepare-splunk).
1. [Enable egress NAT for the subnet with the intermediate VM](#enable-nat).
1. [Create an intermediate VM](#create-vm).
1. [Visualize data in Splunk](#splunk-visualization).

Some steps are completed in {{ TF }}.

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

To complete the tutorial, a Splunk instance must be available to the intermediate VM on port `8080`.

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for using VM instances (see [{{ compute-short-name }} pricing](../../compute/pricing.md)).
* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).
* Fee for using KMS keys (see [{{ kms-name }} pricing](../../kms/pricing.md#prices)).

## Prepare the environment {#prepare-environment}

### Create a new bucket to use for uploading audit logs {#create-backet}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
   1. On the bucket creation page:
      1. Enter a name for the bucket according to the [naming requirements](../../storage/concepts/bucket.md#naming).

         By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

      1. Limit the maximum bucket size, if required.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Select the default [storage class](../../storage/concepts/storage-class.md).
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

{% endlist %}

### Create an encryption key in {{ kms-name }} {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your bucket.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
   1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and set the key attributes:

      * Any name and optional description.
      * Encryption algorithm, e.g., AES-256.
      * [Rotation](../../kms/concepts/index.md#rotation) period (how often to change key versions).
      * Click **{{ ui-key.yacloud.common.create }}**.

   The key is created together with its first version: click the key in the list to open a page with its attributes.

{% endlist %}

### Enable bucket encryption {#backet-encoding}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the bucket for which you want to configure encryption.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select an existing key or create a new one:

      {% include [storage-create-kms](../../storage/_includes_service/storage-create-kms.md) %}

   1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

{% endlist %}

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Assign roles to the service account {#add-roles}

{% list tabs group=instructions %}

- CLI {#cli}

   1. Assign the [audit-trails.viewer](../../audit-trails/security/#roles) role to the folder whose resources will be polled for audit logs:

      ```
      yc resource-manager folder add-access-binding \
      --role audit-trails.viewer \
      --id <folder_ID> \
      --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--id`: ID of the folder from which audit logs will be collected.
      * `--service-account-id`: Service account ID.

   1. Assign the [storage.uploader](../../storage/security/#storage-uploader) role to the folder to host the trail:

      ```
      yc resource-manager folder add-access-binding \
      --role storage.uploader \
      --id <folder_ID> \
      --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--id`: ID of the folder to host the trail.
      * `--service-account-id`: Service account ID.

   1. Assign the [kms.keys.encrypterDecrypter](../../kms/security/#service) role to the encryption key:

      ```
      yc kms symmetric-key add-access-binding \
      --role kms.keys.encrypterDecrypter \
      --id <KMS_key_ID> \
      --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--id`: KMS key ID.
      * `--service-account-id`: Service account ID.

{% endlist %}

## Create a trail {#create-trail}

To create the trail, make sure you have the following roles:

* `iam.serviceAccounts.user` for the service account.
* `audit-trails.editor` for the folder to host the trail.
* `audit-trails.viewer` for the folder from which audit logs will be collected.
* `storage.viewer` for the bucket or folder.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create the trail.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
   1. Click **{{ ui-key.yacloud.audit-trails.button_create-trail }}** and specify:

      * **{{ ui-key.yacloud.common.name }}**: Name of the trail being created.
      * **{{ ui-key.yacloud.common.description }}**: Description of the trail (optional).

   1. Under **{{ ui-key.yacloud.audit-trails.label_destination }}**, configure the destination object:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}**: `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}**: Name of the [bucket](../../storage/operations/buckets/create.md) to which you want to upload audit logs.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}**: Optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}**: Specify the encryption key the bucket is [encrypted](../../storage/concepts/encryption.md) with.

   1. Under **{{ ui-key.yacloud.audit-trails.label_service-account }}**, select the service account that the trail will use to upload audit log files to the bucket.

   1. Under **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**, configure the collection of management event audit logs:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: Select `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}**: Select `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}**: Automatically populated field containing the name of the current folder.

   1. Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, select `{{ ui-key.yacloud.common.disabled }}` in the **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** field.

   1. Click **{{ ui-key.yacloud.common.create }}**.

   {% note warning %}

   The solution will delete the logs from the bucket after they are exported to Splunk. If you need to keep the logs in the bucket, create a separate bucket and trail.

   {% endnote %}

{% endlist %}

## Set up Splunk for import {#prepare-splunk}

Enable `HTTPEventCollector` and get an `Event Collector` token by following this [guide](https://docs.splunk.com/Documentation/SplunkCloud/8.2.2105/Data/UsetheHTTPEventCollector#Configure_HTTP_Event_Collector_on_Splunk_Cloud_Platform).

## Set up a NAT gateway for the subnet with the intermediate VM {#enable-nat}

{% list tabs group=instructions %}

- Management console {#console}

   1. Create a NAT gateway:
      1. In the [management console]({{ link-console-main }}), select the folder containing the subnet for the intermediate VM.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. In the left-hand panel, select **{{ ui-key.yacloud.vpc.switch_gateways }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Enter a name for the gateway. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      1. The default gateway type is `{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}`.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Create a route table:
      1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
      1. Click **{{ ui-key.yacloud.common.create }}** to [add](../../vpc/operations/static-route-create.md) a new table, or select an existing one.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. In the window that opens, select `{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}` in the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will be propagated automatically.
      1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.edit.button_edit }}**.
   1. Link the route table to the subnet where you want to deploy the intermediate VM, to forward its traffic via the NAT gateway:
      1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. In the required subnet row, click ![image](../../_assets/console-icons/ellipsis.svg).
      1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. In the window that opens, select the created table from the list.
      1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

## Create a VM for continuous log delivery to Splunk {#create-vm}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

   1. {% include [terraform-install](../../_includes/terraform-install.md) %}
   1. Clone a [repository](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk) from [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library):

      ```
      git clone https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk.git
      ```

   1. Create a subfolder in `/yc-export-auditlogs-to-splunk/terraform/` and go there.
   1. Create a configuration file to invoke the `yc-splunk-trail` module:

      ```
      module "yc-splunk-trail" {
         source = "../modules/yc-splunk-trail/"
         folder_id = <folder_ID>
         splunk_token = <Event_Collector_token>
         splunk_server = <your_Splunk_server_address>:8088
         bucket_name = <bucket_name>
         bucket_folder = <name_of_bucket_root_folder>
         sa_id = <service_account_ID>
         coi_subnet_id = <subnet_ID>
      }
      ```
      Where:

      * `folder_id`: Folder ID.
      * `splunk_token`: Event Collector token retrieved from Splunk.
      * `splunk_server`: Address of your Splunk server as `https://<host_name_or_address>`.
      * `bucket_name`: Bucket name.
      * `bucket_folder`: Name of the root folder in the bucket.
      * `sa_id`: Service account ID.
      * `coi_subnet_id`: ID of the subnet where you set up the NAT gateway.

   1. Make sure that the configuration files are correct:

      ```
      terraform plan
      ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm resource creation: enter `yes` in the terminal and press **Enter**.

{% endlist %}

## Visualize data in Splunk {#splunk-visualization}

1. Go to Splunk and search for the events created by the service account:

   ```
   index="main" authentication.subject_type="SERVICE_ACCOUNT" | stats count by event_type
   ```

1. To visualize the results, select the **Visualization** tab and select a suitable format (`LineChart`, `PieChart`, and so on):

   Data visualization example:

   ![image](../../_assets/audit-trails/tutorials/splunk-dashboard.png)

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. To delete the resources created with {{ TF }}:

   1. Run this command:
      ```
      terraform destroy
      ```

      {% note warning %}

      {{ TF }} will delete all the resources that you created in the current configuration, such as networks, subnets, virtual machines, and so on.

      {% endnote %}


      After the command is executed, the terminal will display a list of resources to be deleted.

   1. To confirm deletion, type `yes` and press **Enter**.

1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

1. [Delete the {{ kms-name }} key](../../kms/operations/key.md#delete).

1. [Delete the route table](../../vpc/operations/delete-route-table.md).

1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
