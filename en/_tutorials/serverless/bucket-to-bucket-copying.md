# Automatically copying objects from one {{ objstorage-full-name }} bucket to another


Configure automatic object copying from one {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) to another. Objects will be copied using a {{ sf-name }} [function](../../functions/concepts/function.md) invoked by a [trigger](../../functions/concepts/trigger/os-trigger.md) when a new object is added to a bucket.

To set up object copying:

1. [Get your cloud ready](#before-begin).
1. [Create service accounts](#create-sa).
1. [Create a static key](#create-key).
1. [Create a {{ lockbox-full-name }} secret](#create-secret).
1. [Create {{ objstorage-full-name }} buckets](#create-buckets).
1. [Prepare a ZIP archive with the function code](#create-zip).
1. [Create a {{ sf-full-name }} function](#create-function).
1. [Create a trigger](#create-trigger).
1. [Test the function](#test-function).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources includes:

* Fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for storing secrets (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).



## Create service accounts {#create-sa}

Create a [service account](../../iam/concepts/users/service-accounts.md) named `s3-copy-fn` with the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles that will operate the function, and an account named `s3-copy-trigger` with the `{{ roles-functions-invoker }}` role to invoke the function.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account: `s3-copy-fn`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Repeat the previous steps and create a service account named `s3-copy-trigger` with the `{{ roles-functions-invoker }}` role. This service account will invoke the function.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create the `s3-copy-fn` service account:

      ```bash
      yc iam service-account create --name s3-copy-fn
      ```

      Result:

      ```text
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-03-21T10:36:29.726397755Z"
      name: s3-copy-fn
      ```

      Save the `id` of the `s3-copy-fn` service account and the folder where you created it (`folder_id`).

  1. Assign the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role storage.uploader \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
        --role storage.viewer \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

  1. Create the `s3-copy-trigger` service account:

      ```bash
      yc iam service-account create --name s3-copy-trigger
      ```

      Save the IDs of the `s3-copy-trigger` service account (`id`) and the folder where you created it (`folder_id`).

  1. Assign the `{{ roles-functions-invoker }}` role for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role storage.uploader \
        --subject serviceAccount:<service_account_ID>
      ```

- {{ TF }} {#tf}

  
  {% include [terraform-install](../../_includes/terraform-install.md) %}


  1. In the configuration file, describe the service account parameters:

      ```hcl
      // Service account to operate the function
      resource "yandex_iam_service_account" "s3-copy-fn" {
        name        = "s3-copy-fn"
        folder_id   = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "uploader" {
        folder_id = "<folder_ID>"
        role      = "storage.uploader"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      resource "yandex_resourcemanager_folder_iam_member" "viewer" {
        folder_id = "<folder_ID>"
        role      = "storage.viewer"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      resource "yandex_resourcemanager_folder_iam_member" "payloadViewer" {
        folder_id = "<folder_ID>"
        role      = "{{ roles-lockbox-payloadviewer }}"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      // Service account to invoke the function
      resource "yandex_iam_service_account" "s3-copy-trigger" {
        name        = "s3-copy-trigger"
        folder_id   = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "functionInvoker" {
        folder_id = "<folder_ID>"
        role      = "{{ roles-functions-invoker }}"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-trigger.id}"
      }
      ```

      Where:

      * `name`: Service account name. This is a required parameter.
      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. The default value in use is the one specified in the provider settings.
      * `role`: Role to assign.

      For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/iam_service_account).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display information about the service account. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the service accounts by typing `yes` in the terminal and pressing **Enter**.

          This will create the service accounts. You can check the new service accounts using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

          ```bash
          yc iam service-account list
          ```

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the roles for the folder to the service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}


## Create a static key {#create-key}

Create a [static access key](../../iam/concepts/authorization/access-key.md) for the `s3-copy-fn` service account.


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the service account.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and then, the `s3-copy-fn` service account.
  1. In the top panel, click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

- {{ yandex-cloud }} CLI {#cli}

  1. Run this command:

      ```bash
      yc iam access-key create --service-account-name s3-copy-fn
      ```

      Result:

      ```text
      access_key:
        id: aje6t3vsbj8l********
        service_account_id: ajepg0mjt06s********
        created_at: "2023-03-21T14:37:51Z"
        key_id: 0n8X6WY6S24********
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
      ```

  1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the secret key again.

- {{ TF }} {#tf}

  1. In the configuration file, describe the key parameters:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = "<service_account_ID>"
      }
      ```

      Where `service_account_id` is the `s3-copy-fn` service account ID.

      For more information about the `yandex_iam_service_account_static_access_key` resource parameters in {{ TF }}, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the static access key by typing `yes` in the terminal and pressing **Enter**.

          In there were any errors when creating the key, {{ TF }} will point them out.
          If the key has been created successfully, {{ TF }} will write it into its configuration without showing it to the user. The terminal will only display the ID of the created key.

          You can check the new service account key in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command:

          ```bash
          yc iam access-key list --service-account-name=s3-copy-fn
          ```

- API {#api}

  To create an access key, use the [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call.

{% endlist %}


## Create a secret {#create-secret}

Create a {{ lockbox-name }} [secret](../../lockbox/quickstart.md) to store your static access key.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a secret.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `s3-static-key`.

  1. Under **{{ ui-key.yacloud.lockbox.forms.title_secret-data-section }}**:

      1. Select the **{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}** secret type.
      1. Add the key ID value:

          * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, specify: `key_id`.
          * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, specify the key ID [you got earlier](#create-key).

      1. Click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}**.
      1. Add the secret key value:

          * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, specify: `secret`.
          * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, specify the secret key value [you got earlier](#create-key).

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  To create a secret, run this command:

  ```bash
  yc lockbox secret create --name s3-static-key \
    --payload "[{'key': 'key_id', 'text_value': '<key_ID>'},{'key': 'secret', 'text_value': '<private_key_value>'}]"
  ```

  Result:

  ```text
  id: e6q2ad0j9b55********
  folder_id: b1gktjk2rg49********
  created_at: "2021-11-08T19:23:00.383Z"
  name: s3-static-key
  status: ACTIVE
  current_version:
    id: g6q4fn3b6okj********
    secret_id: e6e2ei4u9b55********
    created_at: "2023-03-21T19:23:00.383Z"
    status: ACTIVE
    payload_entry_keys:
      - key_id
      - secret
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the secret parameters:

      ```hcl
      resource "yandex_lockbox_secret" "my_secret" {
        name = "s3-static-key"
      }

      resource "yandex_lockbox_secret_version" "my_version" {
        secret_id = yandex_lockbox_secret.my_secret.id
        entries {
          key        = "key_id"
          text_value = "<key_ID>"
        }
        entries {
          key        = "secret"
          text_value = "<private_key_value>"
        }
      }
      ```

      Where:

      * `name`: Secret name
      * `key`: Key name
      * `text_value`: Key value

      {% include [secret-version-tf-note](../../_includes/lockbox/secret-version-tf-note.md) %}

      Learn more about the properties of {{ TF }} resources in the Terraform documentation:

      * [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret)
      * [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the secret creation by typing `yes` in the terminal and pressing **Enter**.

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}


## Create {{ objstorage-name }} buckets {#create-buckets}

Create two buckets: a main one to store files and a backup one to copy the main bucket's files to.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create buckets.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Create the main bucket:

      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the main bucket.
      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

  1. Similarly, create the backup bucket.

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).

  Create the main and backup buckets:

  ```bash
  aws --endpoint-url https://{{ s3-storage-host }} \
    s3 mb s3://<main_bucket_name>

  aws --endpoint-url https://{{ s3-storage-host }} \
    s3 mb s3://<backup_bucket_name>
  ```

  Result:

  ```text
  make_bucket: <main_bucket_name>
  make_bucket: <backup_bucket_name>
  ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../_includes/storage/terraform-role.md) %}

  1. Describe the parameters for creating a service account and access key in the configuration file:

      {% include [terraform-sa-key](../../_includes/storage/terraform-sa-key.md) %}

  1. In the configuration file, describe the properties of the main and backup buckets:

      ```hcl
      resource "yandex_storage_bucket" "main-bucket" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<main_bucket_name>"
      }

      resource "yandex_storage_bucket" "reserve-bucket" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<backup_bucket_name>"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the {{ TF }} [documentation]({{ tf-provider-resources-link }}/storage_bucket).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the buckets by typing `yes` in the terminal and pressing **Enter**.

- API {#api}

  To create a bucket, use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource or the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call.

{% endlist %}


## Prepare a ZIP archive with the function code {#create-zip}

1. Save the following code to a file named `handler.sh`:

    ```bash
    set -e
    (
      cat | jq -c '.messages[]' | while read message; 
      do
        SRC_BUCKET=$(echo "$message" | jq -r .details.bucket_id)
        SRC_OBJECT=$(echo "$message" | jq -r .details.object_id)
        aws --endpoint-url="$S3_ENDPOINT" s3 cp "s3://$SRC_BUCKET/$SRC_OBJECT" "s3://$DST_BUCKET/$SRC_OBJECT"
      done;
    ) 1>&2
    ```

1. Add the `handler.sh` file to the `handler-sh.zip` archive.


## Create a function {#create-function}

Create a function that will copy a new [object](../../storage/concepts/object.md) to the backup bucket once you add it to the main one.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. Specify the function name: `copy-function`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:

      1. Select the `Bash` runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Specify the `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` upload method and select the `handler-sh.zip` archive created in the previous step.
      1. Specify the entry point: `handler.sh`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `600`
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
          * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `s3-copy-fn`
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              * `S3_ENDPOINT`: `https://{{ s3-storage-host }}`
              * `DST_BUCKET`: Name of the backup bucket to copy files to

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:

              * `AWS_ACCESS_KEY_ID`: `s3-static-key` secret ID, `latest` version ID, `key_id` secret key.
              * `AWS_SECRET_ACCESS_KEY`: `s3-static-key` secret ID, `latest` version ID, `secret` key.

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a function named `copy-function`:

      ```bash
      yc serverless function create --name=copy-function
      ```

      Result:

      ```text
      id: b09bhaokchn9********
      folder_id: <folder_ID>
      created_at: "2024-10-21T20:40:03.451Z"
      name: copy-function
      http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
      status: ACTIVE
      ```

  1. Create a version of `copy-function`:

      ```bash
      yc serverless function version create \
        --function-name copy-function \
        --memory=128m \
        --execution-timeout=600s \
        --runtime=bash \
        --entrypoint=handler.sh \
        --service-account-id=<service_account_ID> \
        --environment DST_BUCKET=<backup_bucket_name> \
        --environment S3_ENDPOINT=https://{{ s3-storage-host }} \
        --secret name=s3-static-key,key=key_id,environment-variable=AWS_ACCESS_KEY_ID \
        --secret name=s3-static-key,key=secret,environment-variable=AWS_SECRET_ACCESS_KEY \
        --source-path=./handler-sh.zip
        ```

        Where:

        * `--function-name`: Name of the function.
        * `--memory`: Amount of RAM.
        * `--execution-timeout`: Maximum function running time before the timeout is exceeded.
        * `--runtime`: Runtime environment.
        * `--entrypoint`: Entry point.
        * `--service-account-id`: `s3-copy-fn` service account ID.
        * `--environment`: Environment variables.
        * `--secret`: Secret with parts of the static access key.
        * `--source-path`: Path to the `handler-sh.zip` archive.

        Result:

        ```text
        done (1s)
        id: d4e394pt4nhf********
        function_id: d4efnkn79m7n********
        created_at: "2024-10-21T20:41:01.345Z"
        runtime: bash
        entrypoint: handler.sh
        resources:
          memory: "134217728"
        execution_timeout: 600s
        service_account_id: ajelprpohp7r********
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        environment:
          DST_BUCKET: <backup_bucket_name>
          S3_ENDPOINT: https://{{ s3-storage-host }}
        secrets:
          - id: e6qo2oprlmgn********
            version_id: e6q6i1qt0ae8********
            key: key_id
            environment_variable: AWS_ACCESS_KEY_ID
          - id: e6qo2oprlmgn********
            version_id: e6q6i1qt0ae8********
            key: secret
            environment_variable: AWS_SECRET_ACCESS_KEY
        log_options:
          folder_id: b1g681qpemb4********
        concurrency: "1"
        ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the function parameters:

      ```hcl
      resource "yandex_function" "copy-function" {
        name               = "copy-functionn"
        user_hash          = "first function"
        runtime            = "bash"
        entrypoint         = "handler.sh"
        memory             = "128"
        execution_timeout  = "600"
        service_account_id = "<service_account_ID>"
        environment = {
          DST_BUCKET  = "<backup_bucket_name>"
          S3_ENDPOINT = "https://{{ s3-storage-host }}"
        }
        secrets = {
          id = "<secret_ID>"
          version_id = "<secret_version_ID>"
          key = "key_id"
          environment_variable = "AWS_ACCESS_KEY_ID"
        }
        secrets = {
          id = "<secret_ID>"
          version_id = "<secret_version_ID>"
          key = "secret"
          environment_variable = "AWS_SECRET_ACCESS_KEY"
        }
        content {
          zip_filename = "./handler-sh.zip"
        }
      }
      ```

      Where:

      * `name`: Function name.
      * `user_hash`: Any string to identify the function version.
      * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Entry point.
      * `memory`: Amount of memory allocated for the function, in MB.
      * `execution_timeout`: Function running timeout.
      * `service_account_id`: `s3-copy-fn` service account ID.
      * `environment`: Environment variables.
      * `secrets`: Secret with parts of the static access key.
      * `content`: Path to the `handler-sh.zip` archive with the function source code.

      For more information about the `yandex_function` resource parameters, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/function).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the function by typing `yes` in the terminal and pressing **Enter**.

- API {#api}

  To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

  To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}


## Create a trigger {#create-trigger}

Create a trigger for {{ objstorage-name }} that will invoke `copy-function` when you create a new object in the main bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Specify a name for the trigger: `bucket-to-bucket-copying`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select the main bucket.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-object}}`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** field, select `copy-function`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** field, select the `s3-copy-trigger` service account.

  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc serverless trigger create object-storage \
    --name bucket-to-bucket-copying \
    --bucket-id <main_bucket_name> \
    --events 'create-object' \
    --invoke-function-name copy-function \
    --invoke-function-service-account-name s3-copy-trigger
  ```

  Where:

  * `--name`: Trigger name.
  * `--bucket-id`: Name of the main bucket.
  * `--events`: [Events](../../functions/concepts/trigger/os-trigger.md#event) activating the trigger.
  * `--invoke-function-name`: Name of the function being invoked.
  * `--invoke-function-service-account-name`: Name of the service account to use for invoking the function.

  Result:

  ```text
  id: a1s92agr8mpg********
  folder_id: b1g88tflru0e********
  created_at: "2024-10-21T21:04:01.866959640Z"
  name: bucket-to-bucket-copying
  rule:
    object_storage:
      event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
      bucket_id: <main_bucket_name>
      batch_settings:
        size: "1"
        cutoff: 1s
      invoke_function:
        function_id: d4eofc7n0m03********
        function_tag: $latest
        service_account_id: aje3932acd0c********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the trigger parameters:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "bucket-to-bucket-copying"
        object_storage {
            bucket_id = "<main_bucket_name>"
            create    = true
        }
        function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name.
      * `object_storage`: Storage parameters:
          * `bucket_id`: Name of the main bucket.
          * `create`: Trigger will invoke the function when a new object is created in the storage.
      * `function`: Settings for the function which the trigger will activate:
          * `id`: `copy-function` ID.
          * `service_account_id`: `s3-copy-trigger` service account ID.

      For more information about resource parameters in {{ TF }}, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Make sure the configuration files are correct.

      1. In the command line, navigate to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the trigger by typing `yes` in the terminal and pressing **Enter**.

- API {#api}

  To create a trigger for {{ objstorage-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}


## Test the function {#test-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where the main bucket is located.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click the name of the main bucket.
  1. In the top-right corner, click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. In the window that opens, select the required files and click **Open**.
  1. The management console will display all objects selected for upload. Click **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Refresh the page.
  1. Navigate to the backup bucket and make sure it contains the files you added.

{% endlist %}


## How to delete the resources you created {#clear-out}


To stop paying for the resources you created:

1. [Delete the objects](../../storage/operations/objects/delete-all.md) from the buckets.
1. [Delete](../../storage/operations/buckets/delete.md) the buckets.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the `bucket-to-bucket-copying` trigger.
1. [Delete](../../functions/operations/function/function-delete.md) `copy-function`.
