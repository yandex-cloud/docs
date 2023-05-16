# Automatically copying objects from one {{ objstorage-name }} bucket to another

Configure automatic object copy from one {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) to another. Objects will be copied using a {{ sf-name }} [function](../../functions/concepts/function.md) invoked by a [trigger](../../functions/concepts/trigger/os-trigger.md) when a new object is added to a bucket.

To set up object copy:

1. [Prepare your cloud](#before-begin).
1. [Create service accounts](#create-sa).
1. [Create a static key](#create-key).
1. [Create a {{ lockbox-full-name }} secret](#create-secret).
1. [Create {{ objstorage-full-name }} buckets](#create-buckets).
1. [Prepare a ZIP archive with the function code](#create-zip).
1. [Create a {{ sf-full-name }} function](#create-function).
1. [Create a trigger](#create-trigger).
1. [Test the function](#test-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources includes:

* Fee for storing data in a bucket (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Payment for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Secret storage fees (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).


## Create service accounts {#create-sa}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `s3-copy-fn` to use for invoking the function:

   {% list tabs %}

   - Management console

      1. In [the management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. Click the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter the service account name: `s3-copy-fn`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create a service account named `s3-copy-fn`:

         ```bash
         yc iam service-account create --name s3-copy-fn
         ```

         Result:

         ```
         id: nfersamh4sjq********
         folder_id: b1gc1t4cb638********
         created_at: "2023-03-21T10:36:29.726397755Z"
         name: s3-copy-fn
         ```

         Save the `id` of the `s3-copy-fn` service account and that of the folder where it was created (`folder_id`).

      1. Assign the service account the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles for the folder:

         ```bash
         yc resource-manager folder add-access-binding <folder_ID> \
           --role storage.uploader \
           --subject serviceAccount:<service_account_ID>

         yc resource-manager folder add-access-binding <folder_ID> \
           --role storage.viewer \
           --subject serviceAccount:<service_account_ID>

         yc resource-manager folder add-access-binding <folder_ID> \
           --role lockbox.payloadViewer \
           --subject serviceAccount:<service_account_ID>
         ```

         Result:

         ```
         done (1s)
         ```

   - {{ TF }}

      
      If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


      1. In the configuration file, describe the service account parameters:

         ```hcl
         resource "yandex_iam_service_account" "s3-copy-fn" {
           name        = "s3-copy-fn"
           folder_id   = "<folder_ID>"
         }

         resource "yandex_resourcemanager_folder_iam_member" "uploader" {
           folder_id = "<folder_ID>"
           role      = "storage.uploader"
           member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
         }

         resource "yandex_resourcemanager_folder_iam_member" "viewer" {
           folder_id = "<folder_ID>"
           role      = "storage.viewer"
           member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
         }

         resource "yandex_resourcemanager_folder_iam_member" "payloadViewer" {
           folder_id = "<folder_ID>"
           role      = "lockbox.payloadViewer"
           member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
         }
         ```

         Where:

         * `name`: Service account name. This parameter is required.
         * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.
         * `role`: Role being assigned.

         For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account).

      1. Make sure the configuration files are valid.

         1. In the command line, go to the directory where you created the configuration file.
         1. Run the check using this command:

            ```bash
            terraform plan
            ```

         If the configuration is described correctly, the terminal displays information about the service account. If the configuration contains any errors, {{ TF }} will point them out.

      1. Deploy cloud resources.

         1. If the configuration does not contain any errors, run this command:

            ```bash
            terraform apply
            ```

         1. Confirm the service account creation by typing `yes` in the terminal and pressing **Enter**.

            The service account will then be created. You can verify that the service account is there in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command:

            ```bash
            yc iam service-account list
            ```

   - API

      To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API call.

      To assign the service account the `storage.uploader`, `storage.viewer`, and `{{ roles-lockbox-payloadviewer }}` roles for the folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

   {% endlist %}

1. Follow the same steps to create an `s3-copy-trigger` service account with the `{{ roles-functions-ivoker }}` role. This service account will be used to invoke the function.

## Create a static key {#create-key}

Create a [static access key](../../iam/concepts/authorization/access-key.md) for the `s3-copy-fn` service account.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the service account.
   1. Click the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the line with its name.
   1. On the top panel, click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and private key.

- CLI

   1. Run this command:

      ```bash
      yc iam access-key create --service-account-name s3-copy-fn
      ```

      Result:

      ```text
      access_key:
        id: aje6t3vsbj8lp9******
        service_account_id: ajepg0mjt06siu******
        created_at: "2023-03-21T14:37:51Z"
        key_id: 0n8X6WY6S24N7O*****
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9h******
      ```

   1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key value again.

- {{ TF }}

   1. In the configuration file, describe the key parameters:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = "<service_account_ID>"
      }
      ```

      Where `service_account_id` is the ID of the `s3-copy-fn` service account.

      For more information about the `yandex_iam_service_account_static_access_key` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_static_access_key).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the static access key creation by typing `yes` in the terminal and pressing **Enter**.

         If any errors occur when creating the key, {{ TF }} will indicate them.
         If the key is successfully created, {{ TF }} will write it into its configuration, but will not show it to the user. The terminal will only display the ID of the created key.

         You can verify that the key of the service account is there in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command:

         ```bash
         yc iam access-key list --service-account-name=s3-copy-fn
         ```

- API

   To create an access key, use the [create](../../iam/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../iam/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../iam/api-ref/grpc/access_key_service.md#Create) gRPC API call.

{% endlist %}

## Create a secret {#create-secret}

Create a {{ lockbox-name }} [secret](../../lockbox/quickstart.md) to store your static access key.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a secret.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the secret name: `s3-static-key`.
   1. Under **{{ ui-key.yacloud.lockbox.forms.section_version }}**:

      1. Add the key ID value:

         * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `key_id`.
         * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the key ID [you obtained earlier](#create-key).

      1. Click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}**.
      1. Add the secret key value:

         * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `secret`.
         * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the secret key value [you obtained earlier](#create-key).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   To create a secret, run this command:

   ```bash
   yc lockbox secret create --name s3-static-key \
     --payload "[{'key': 'key_id', 'text_value': '<key_ID>'},{'key': 'secret', 'text_value': '<secret_key_value>'}]"
   ```

   Result:

   ```
   id: e6q2ad0j9b55tk******
   folder_id: b1gktjk2rg494e******
   created_at: "2021-11-08T19:23:00.383Z"
   name: s3-static-key
   status: ACTIVE
   current_version:
     id: g6q4fn3b6okjkc******
     secret_id: e6e2ei4u9b55gh******
     created_at: "2023-03-21T19:23:00.383Z"
     status: ACTIVE
     payload_entry_keys:
       - key_id
       - secret
   ```

- {{ TF }}

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
          text_value = "<secret_key_value>"
        }
      }
      ```

      Where:

      * `name`: Secret name.
      * `key`: Key name.
      * `text_value`: Key value.

      For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

      * [yandex_lockbox_secret]({{ tf-provider-link }}/lockbox_secret).
      * [yandex_lockbox_secret_version]({{ tf-provider-link }}/lockbox_secret_version).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the secret creation: type `yes` in the terminal and press **Enter**.

- API

   To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create) gRPC API call.

{% endlist %}

## Create {{ objstorage-name }} buckets {#create-buckets}

Create two buckets: `main-bucket` to store files and `reserve-bucket` to copy the `main-bucket` files to.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your buckets.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Create a bucket named `main-bucket`:

      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter the bucket name: `main-bucket`.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

   1. Similarly, create a bucket named `reserve-bucket`.

- AWS CLI

   1. Create a bucket named `main-bucket`:

      ```bash
      aws --endpoint-url https://{{ s3-storage-host }} \
        s3 mb s3://main-bucket
      ```

      Result:

      ```
      make_bucket: s3://main-bucket
      ```

   1. Similarly, create a bucket named `reserve-bucket`.

- {{ TF }}

   1. In the configuration file, describe the `main-bucket` and `reserve-bucket` parameters:

      ```
      resource "yandex_storage_bucket" "main-bucket" {
        bucket = "main-bucket"
      }

      resource "yandex_storage_bucket" "reserve-bucket" {
        bucket = "reserve-bucket"
      }
      ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/storage_bucket).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the bucket creation: type `yes` in the terminal and press **Enter**.

- API

   To create a bucket, use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource or the [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) gRPC API call.

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
     done
   ) 1>&2
   ```

1. Add the `handler.sh` file to the `handler-sh.zip` archive.

## Create a function {#create-function}

Create a function that will copy a new [object](../../storage/concepts/object.md) to `reserve-bucket` once you add it to `main-bucket`

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. In the list of services, select **{{ sf-name }}**
   1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. Enter the function name: `copy-function`.
      1. Click **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.

   1. Create the function version:

      1. Select the `Bash` runtime environment, disable the **Add files with code examples** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Specify the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** upload method and select the `handler-sh.zip` archive created in the previous step.
      1. Specify the entry point: `handler.sh`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: 600 seconds.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: 128 MB.
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `s3-copy-fn`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

            * `S3_ENDPOINT`: `https://storage.yandexcloud.net`.
            * `DST_BUCKET`: Name of the bucket to copy files to (`reserve-bucket`).

         * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:

            * `AWS_ACCESS_KEY_ID`: The `key_id` key of the `s3-static-key` secret.
            * `AWS_SECRET_ACCESS_KEY`: The `secret` key of the `s3-static-key` secret.

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

   1. Create a function named `copy-function`:

      ```bash
      yc serverless function create --name=copy-function
      ```

      Result:

      ```
      id: b09bhaokchn9pn******
      folder_id: aoek49ghmknnpj******
      created_at: "2023-03-21T10:03:37.475Z"
      name: copy-function
      log_group_id: eolm8aoq9vcpps******
      http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pn******
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
        --environment DST_BUCKET=reserve-bucket \
        --environment S3_ENDPOINT=https://storage.yandexcloud.net \
        --secret name=s3-static-key,key=key_id,environment-variable=AWS_ACCESS_KEY_ID \
        --secret name=s3-static-key,key=secret,environment-variable=AWS_SECRET_ACCESS_KEY \
        --source-path=./handler-sh.zip
      ```

      Where:

      * `--function-name`: Name of the function a version of which you are creating.
      * `--memory`: RAM amount.
      * `--execution-timeout`: Maximum function execution time before the timeout is reached.
      * `--runtime`: Runtime environment.
      * `--entrypoint`: Entry point.
      * `--service-account-id`: ID of the `s3-copy-fn` service account.
      * `--environment`: Environment variables.
      * `--secret`: Secret with parts of the static access key.
      * `--source-path`: Path to the `handler-sh.zip` archive.

      Result:

      ```
      done (1s)
      id: d4e6qqlh53nuh5******
      function_id: d4emc80mnp5n96******
      created_at: "2023-03-22T16:49:41.800Z"
      runtime: bash
      entrypoint: handler.sh
      resources:
        memory: "134217728"
      execution_timeout: 600s
      service_account_id: aje20nhregkcvu******
      image_size: "4096"
      status: ACTIVE
      tags:
        - $latest
      log_group_id: ckgmc3l93cl0lf******
      environment:
        DST_BUCKET: reserve-bucket
        S3_ENDPOINT: https://storage.yandexcloud.net
      secrets:
        - id: e6q5qe9a1hgk1a******
          version_id: e6qrdn2e1acb7e******
          key: key_id
          environment_variable: AWS_ACCESS_KEY_ID
        - id: e6q5qe9a1hgk1a******
          version_id: e6qrdn2e1acb7e******
          key: secret
          environment_variable: AWS_SECRET_ACCESS_KEY
      log_options:
        folder_id: b1g86q4m5vej8l******
      ```

- {{ TF }}

   1. In the configuration file, describe the function parameters:

      ```
      resource "yandex_function" "copy-function" {
        name               = "copy-functionn"
        user_hash          = "first function"
        runtime            = "bash"
        entrypoint         = "handler.sh"
        memory             = "128"
        execution_timeout  = "600"
        service_account_id = "aje20nhregkcvuik0q44"
        environment = {
          DST_BUCKET  = "reserve-bucket"
          S3_ENDPOINT = "https://storage.yandexcloud.net"
        }
        secrets = {
          id = "e6q5qe9a1hgk1a******"
          version_id = "e6qrdn2e1acb7e******"
          key = "key_id"
          environment_variable = "AWS_ACCESS_KEY_ID"
        }
        secrets = {
          id = "e6q5qe9a1hgk1a******"
          version_id = "e6qrdn2e1acb7e******"
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
      * `user_hash`: Arbitrary string that identifies the function version.
      * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Entry point.
      * `memory`: Amount of memory allocated for function execution, in MB.
      * `execution_timeout`: Function execution timeout.
      * `service_account_id`: ID of the `s3-copy-fn` service account.
      * `environment`: Environment variables.
      * `secrets`: Secret with parts of the static access key.
      * `content`: Path to the `handler-sh.zip` archive with the function source code.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-link }}/function).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the function creation: type `yes` in the terminal and press **Enter**.

- API

   To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create) gRPC API call

   To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call

{% endlist %}

## Create a trigger {#create-trigger}

Create a trigger for {{ objstorage-name }} that will invoke `copy-function` when you create a new object in the `main-bucket`.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.
   1. In the list of services, select **{{ sf-name }}**
   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter the trigger name: `bucket-to-bucket-copying`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}**.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** field, select `main-bucket`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-object}}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** field, select `copy-function`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** field, select the `s3-copy-trigger` service account.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   Run this command:

   ```bash
   yc serverless trigger create object-storage \
     --name bucket-to-bucket-copying \
     --bucket-id <bucket_ID> \
     --events 'create-object' \
     --invoke-function-name copy-function \
     --invoke-function-service-account-name s3-copy-trigger
   ```

   Where:

   * `--name`: Trigger name.
   * `--bucket-id`: ID of `main-bucket`.
   * `--events`: [Events](../../functions/concepts/trigger/os-trigger.md#event) to fire the trigger.
   * `--invoke-function-name`: Name of the function being invoked.
   * `--invoke-function-service-account-name`: Name of the service account to use for invoking the function.

   Result:

   ```text
   id: a1s92agr8mpgeo******
   folder_id: b1g88tflru0ek1******
   created_at: "2023-03-22T09:47:50.079103Z"
   name: bucket-to-bucket-copying
   rule:
     object_storage:
       event_type:
       - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
       bucket_id: main-bucket
       invoke_function:
         function_id: d4eofc7n0m03lm******
         function_tag: $latest
         service_account_id: aje3932acd0c5u******
   status: ACTIVE
   ```

- {{ TF }}

   1. In the configuration file, describe the trigger parameters:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "bucket-to-bucket-copying"
        object_storage {
           bucket_id = "<bucket_ID>"
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
         * `bucket_id`: Bucket ID.
         * `create`: Trigger will invoke the function when a new object is created in the storage.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: ID of `copy-function`.
         * `service_account_id`: ID of the `s3-copy-trigger` service account.

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the trigger creation: type `yes` in the terminal and press **Enter**.

- API

   To create a trigger for {{ objstorage-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Test the function {#test-function}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder with `main-bucket`.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click the `main-bucket` name.
   1. In the top-right corner, click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
   1. In the window that opens, select the required files and click **Open**.
   1. The management console will display all objects selected for upload. Click **{{ ui-key.yacloud.storage.button_upload }}**.
   1. Refresh the page.
   1. Go to the `reserve-bucket` and make sure it contains the files you added.

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../storage/operations/objects/delete-all.md) the objects from `main-bucket` and `reserve-bucket`.
1. [Delete](../../storage/operations/buckets/delete.md) `main-bucket` and `reserve-bucket`.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the `bucket-to-bucket-copying` trigger.
1. [Delete](../../functions/operations/function/function-delete.md) `copy-function`.

