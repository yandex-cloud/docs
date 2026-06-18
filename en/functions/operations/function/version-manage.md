---
title: How to create a function version
description: Follow this guide to create a function version.
---

# Creating a function version

{% include [create-version](../../../_includes/functions/create-version.md) %}

## Preparing a ZIP archive with the function code {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

## Creating a function version {#version-create}

When creating a version, specify the following settings:

* _{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}_: Provides additional libraries and environment variables accessible from the function code. It matches the programming language of your function. For more information, see [Runtime](../../concepts/runtime/index.md).
* _{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}_: Function to invoke as the [handler](../../concepts/function.md#programming-model).
* _{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}_: Maximum function execution time. After this time, the service stops the function without waiting for a response. It includes the initialization time during the first run.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function whose version you want to create.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Select the [runtime](../../concepts/runtime/index.md). Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Prepare the function code:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs18`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `hello-js.zip`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
    1. Configure the version:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
       * [**{{ ui-key.yacloud.forms.label_service-account-select }}**](../../../iam/concepts/users/service-accounts.md): `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
       * [**{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**](../../concepts/runtime/environment-variables.md): `{{ ui-key.yacloud.common.not-selected }}`.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function version, run this command:

    ```
    yc serverless function version create \
      --function-name=my-nodejs-function \
      --runtime nodejs18 \
      --entrypoint index.handler \
      --memory 128m \
      --execution-timeout 5s \
      --source-path ./hello-js.zip
    ```

    Where:

    * `--function-name`: Name of the function whose version you want to create.
    * `--runtime`: Runtime.
    * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before timeout.
    * `--source-path`: ZIP archive with the function code and required dependencies.

    Result:

    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs18
    entrypoint: index.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      folder_id: b1g681qpemb4********
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To create a new function version:

    1. Open the {{ TF }} configuration file and change the function settings:
      
       * `yandex_function`: Description of the new function and its source code.
         * `name`: Function name.
         * `description`: Text description of the function.
         * `user_hash`: Any string to identify the function version. When you change the function, update this string as well. Updating this string triggers a function update.
         * `runtime`: Function [runtime](../../concepts/runtime/index.md).
         * `entrypoint`: Function name in the source code that will serve as an entry point to applications.
         * `memory`: Amount of memory allocated for the function, in MB.
         * `execution_timeout`: Function execution timeout.
         * `service_account_id`: ID of the service account you want to use to invoke the function.
         * `content`: Function source code.
           * `content.0.zip_filename`: Name of the ZIP archive containing the function source code.

        Here is an example of the configuration file structure:

        ```
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "nodejs18"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<service_account_ID>"
            content {
                zip_filename = "<path_to_ZIP_archive>"
            }
        }
        ```

       {% note info %}
    
       If you change the function name or description, the system will not create a new version.

       {% endnote %}

        For more information about `yandex_function` resource properties, see [this provider guide]({{ tf-provider-resources-link }}/function).

    1. Validate your configuration using this command:
        
       ```
       terraform validate
       ```

       If the configuration is valid, you will get this message:
        
       ```
       Success! The configuration is valid.
       ```

    1. Run this command:

       ```
       terraform plan
       ```
        
       You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration. 
         
    1. Apply the configuration changes:

       ```
       terraform apply
       ```
    1. Type `yes` and press **Enter** to confirm the changes.
      
    You can check the new version using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

    ```
    yc serverless function version list --function-name <function_name>
    ```

- API {#api}

    To create a function version, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

    **Request examples**

    To use the examples below, install [cURL](https://curl.haxx.se) and [authenticate](../../api-ref/functions/authentication.md) with the API.

    {% cut "Example where code is fetched from an {{ objstorage-name }} bucket" %}

    1. [Upload](../../../storage/operations/objects/upload.md) the `hello-js.zip` archive with the function version code to your {{ objstorage-name }} bucket.
    1. Create a file named `body.json` with the following request body:

        ```json
        {
          "functionId": "<function_ID>",
          "runtime": "nodejs22",
          "entrypoint": "index.handler",
          "resources": {
            "memory": "134217728"
          },
          "executionTimeout": "5s",
          "serviceAccountId": "<service_account_ID>",
          "package": {
            "bucketName": "<bucket_name>",
            "objectName": "hello-js.zip"
          },
        }
        ```

        Where:

        * `functionId`: ID of the function whose version you want to create.
        * `runtime`: [Runtime](../../concepts/runtime/index.md#runtimes).
        * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
        * `memory`: Amount of RAM.
        * `executionTimeout`: Maximum function execution time before timeout.
        * `serviceAccountId`: ID of the service account with a [role](../../../storage/security/index.md#service-roles) that allows bucket data reads.
        * `bucketName`: Name of the bucket where you uploaded the ZIP archive with the function code and required dependencies.
        * `objectName`: [Key of the bucket object](../../../storage/concepts/object.md#key) that contains the function code.

    {% endcut %}

    {% cut "Example where code is provided in the request body" %}

    1. Encode the ZIP archive with the function code into Base64 format:

        ```bash
        base64 -i hello-js.zip > output.txt
        ```

    1. Create a file named `body.json` with the following request body:

        ```json
        {
          "functionId": "<function_ID>",
          "runtime": "nodejs22",
          "entrypoint": "index.handler",
          "resources": {
            "memory": "134217728"
          },
          "executionTimeout": "5s",
          "content": "<ZIP_archive_contents_in_Base64_encoding>"
        }
        ```

        Where:

        * `functionId`: ID of the function whose version you want to create.
        * `runtime`: [Runtime](../../concepts/runtime/index.md#runtimes).
        * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
        * `memory`: Amount of RAM.
        * `executionTimeout`: Maximum function execution time before timeout.
        * `content`: Function version code in Base64 encoding, `output.txt` file contents.

    {% endcut %}

    {% cut "Example where code is fetched from another function version in {{ sf-name }}" %}

    Create a file named `body.json` with the following request body:

    ```json
    {
      "functionId": "<function_ID>",
      "runtime": "nodejs22",
      "entrypoint": "index.handler",
      "resources": {
        "memory": "134217728"
      },
      "executionTimeout": "5s",
      "versionId": "<previous_function_version_ID>"
    }
    ```

    Where:

    * `functionId`: ID of the function whose version you want to create.
    * `runtime`: [Runtime](../../concepts/runtime/index.md#runtimes).
    * `entrypoint`: Entry point in `<file_name_without_extension>.<handler_name>` format.
    * `memory`: Amount of RAM.
    * `executionTimeout`: Maximum function execution time before timeout.
    * `versionId`: ID of a [previous function version](./version-list.md).

    {% endcut %}

    Send the request by specifying the path to the previously created file with the request body:

    ```bash
    export IAM_TOKEN=$(yc iam create-token)
    curl -X POST \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d "@<body.json_file_path>" \
      https://serverless-functions.{{ api-host }}/functions/v1/versions
    ```
    
    Result:
    
    ```json
    {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.serverless.functions.v1.CreateFunctionVersionMetadata",
        "functionVersionId": "d4e25m0gila4********"
      },
      "id": "d4edk0oobcc9********",
      "description": "Create function version",
      "createdAt": "2023-10-11T11:22:21.286786431Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2023-10-11T11:22:21.286786431Z"
    }
    ```


{% endlist %}

{% note info %}

To ensure integrity of references, you cannot update function versions. For more information about the resource relationships, see [{#T}](../../concepts/function.md).

{% endnote %}
