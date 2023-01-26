# Creating a function version

{% include [create-version](../../../_includes/functions/create-version.md) %}

## Preparing a ZIP archive with the function code {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

## Creating a function version {#version-create}

When creating a version, set the following parameters:

* _Runtime environment_: Provides additional libraries and environment variables that can be accessed from the function code. It corresponds to the programming language that your function is written in. For more information, see [Runtime environment](../../concepts/runtime/index.md).
* _Entry point_: The function to be invoked as a handler. To read more about the handler, see [Programming model](../../concepts/function.md#programming-model).
* _Timeout_: The maximum function execution time, after which the service will terminate its execution without waiting for a response. It includes the time of the first initialization when the function is first run.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select the function to create a version of.
   1. Under **Latest version**, click **Create in editor**.
   1. Select the [runtime environment](../../concepts/runtime/index.md). Don't select the **Add files with code examples** option.
   1. Prepare the function code:
      * Runtime environment: `nodejs`.
      * Method: ZIP archive.
      * File: `hello-js.zip`.
      * Entry point: `index.handler`.
   1. Set the version parameters:
      * Timeout: 5 sec.
      * RAM: 128 MB.
      * [Service account](../../../iam/concepts/users/service-accounts): None selected.
      * [Environment variables](../../concepts/runtime/environment-variables.md): None selected.
   1. In the top right-hand corner, click **Create version**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a function version, run the command:

   ```
   yc serverless function version create \
     --function-name=my-nodejs-function \
     --runtime nodejs12 \
     --entrypoint index.handler \
     --memory 128m \
     --execution-timeout 5s \
     --source-path ./hello-js.zip
   ```

   Where:

   * `--function-name`: The name of the function you want to create a version of.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the `<filename without extension>`.`<handler name>` format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--source-path`: A ZIP archive with the function code and required dependencies.

   Result:

    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs12
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```

- API

   You can create a function version using the [createVersion](../../functions/api-ref/Function/createVersion.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a new function version:

   1. Open the {{ TF }} configuration file and change the function parameters:

      * `yandex_function`: Description of the function being created and its source code.
         * `name`: Function name.
         * `description`: Text description of the function.
         * `user_hash`: An arbitrary string that identifies the function version. When the function changes, update this string, too. The function will update when this string is updated.
         * `runtime`: The function [runtime environment](../../concepts/runtime/index.md).
         * `entrypoint`: Function name in the source code that will serve as an entry point to the applications.
         * `memory`: The amount of memory allocated for function execution, in MB.
         * `execution_timeout`: Function execution timeout.
         * `service_account_id`: ID of the service account that should be used to invoke the function.
         * `content`: Function source code.
            * `content.0.zip_filename`: Name of the ZIP archive that contains the function source code.

      Example configuration file structure:

      ```
      resource "yandex_function" "test-function" {
          name               = "test-function"
          description        = "Test function"
          user_hash          = "first-function"
          runtime            = "python37"
          entrypoint         = "main"
          memory             = "128"
          execution_timeout  = "10"
          service_account_id = "<service account ID>"
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

      {% note info %}

      If the function name or description is changed, the version will not be created.

      {% endnote %}

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-link }}/function).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the version is there on the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function version list --function-name <function name>
   ```

- {{ yandex-cloud }} Toolkit

   You can create a function version using the [{{ yandex-cloud }} Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% note info %}

To ensure the integrity of version links, you can't update or delete function versions. For more information about relationships between resources, see [{#T}](../../concepts/function.md).

{% endnote %}
