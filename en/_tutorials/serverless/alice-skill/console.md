To add a skill for Alice based on a [function](*functions):

1. [Get your cloud ready](#before-you-begin).
1. [Prepare the skill code](#prepare-code).
1. [Create a function and a function version](#create-function).
1. [Add the function link to the Alice's skill](#add-link).
1. [Test the skill](#test).

If you no longer need the resources you created, [delete](#clear-out) them.

Learn more about developing a skill for Alice [here](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare the code for the Alice's skill {#prepare-code}

To create a function [version](*function_version), you can use one of the [code upload formats](*upload_formats). In this example, we will upload the code to {{ sf-full-name }} as a ZIP archive.

{% include [prepare-code](../../_tutorials_includes/alice-skill/prepare-code.md) %}

## Create a function and a function version {#create-function}

Once created, the function will contain only information about itself, i.e., its name, description, unique ID, etc. The actual skill code will be added to the function version.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](*folder) to create your function in.
  1. Click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![curly-brackets-function](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
  1. Give the function a [name](*naming), e.g., `my-parrot-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a function version:

      {% list tabs group=programming_language %}

      - Python {#python}

        1. From the list of programming languages, select `{{ python-full-ver }}`.
        1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Prepare the function code:

            * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` and attach the `parrot-py.zip` archive you created earlier.
            * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `parrot.handler`.
        1. Configure the version:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
            * Leave the other settings at their defaults.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

      - Node.js {#node}

        1. In the list of programming languages, select `{{ nodejs-full-ver }}`.
        1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Prepare the function code:

            * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` and attach the `parrot-js.zip` archive you created earlier.
            * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
        1. Configure the version:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
            * Leave the other settings at their defaults.
        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

      {% endlist %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. To create a function, run this command:

      ```bash
      yc serverless function create \
        --name my-parrot-function
      ```

      Result:

      ```text
      id: d4el0mi6ps6s********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-15T08:16:02.695Z"
      name: my-parrot-function
      http_invoke_url: https://{{ sf-url }}/d4el0mi6ps6s********
      status: ACTIVE
      ```

  1. To create a function version, run this command:

      {% list tabs group=programming_language %}

      - Python {#python}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime {{ python-cli-ver }} \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-py.zip
        ```

        Result:

        ```text
        done (2s)
        id: d4easr8ok281********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:42:20.771Z"
        runtime: {{ python-cli-ver }}
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      - Node.js {#node}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime {{ nodejs-cli-ver }} \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-js.zip
        ```

        Result:

        ```text
        done (2s)
        id: d4etv45m1vor********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:45:25.313Z"
        runtime: {{ nodejs-cli-ver }}
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      {% endlist %}

- API {#api}

  To create a function, use the [create](../../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

  To create a function version, use the [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

{% include [add-link](../../_tutorials_includes/alice-skill/add-link.md) %}

{% include [test](../../_tutorials_includes/alice-skill/test.md) %}

## How to delete the resources you created {#clear-out}

To stop the skill, [delete](../../../functions/operations/function/function-delete.md) the function.

[*functions]: With {{ sf-full-name }} functions, you can place your code in {{ yandex-cloud }} and run on request or trigger. For more information, see [{#T}](../../../functions/concepts/function.md).

[*folder]: A folder is a logical space where you create and group your {{ yandex-cloud }} resources. Just like folders in your file system, {{ yandex-cloud }} folders make resource management simpler. For more information, see [{#T}](../../../resource-manager/concepts/resources-hierarchy.md#folder).

[*naming]: The naming requirements are as follows:
* It must be between 3 and 63 characters in length.
* It can only contain lowercase Latin letters, numbers, and hyphens.
* It must start with a letter and cannot end with a hyphen.

[*function_version]: A version contain the function code, execution parameters, as well as all required dependencies. You can use different versions of the same function at different development stages. For more information, see [{#T}](../../../functions/concepts/function.md#version).

[*upload_formats]: There are several ways to upload a function version code: in the editor in the management console, from local files and directories, or as an archive. For more information, see [{#T}](../../../functions/concepts/function.md#upload).