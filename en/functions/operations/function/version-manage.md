# Managing function versions

With function versioning, you can:

* [Creating a version](version-manage.md#func-version-create)
* [Get information about a function version](version-manage.md#version-info)
   * [Get a list of function versions](version-manage.md#version-list)
   * [Get detailed information about a function version](version-manage.md#version-get)
* [Adding environment variables](version-manage.md#version-env)
* [Specifying a cloud network where the function will be executed](version-manage.md#networking)
* [Transmitting a {{ lockbox-name }} secret](lockbox)
* [Manage version tags](version-manage.md#manage-tags)

You can change the function code using the [Code editor](function-editor.md).

{% note info %}

To ensure the integrity of version links, you can't update or delete function versions. For more information about relationships between resources, see [{#T}](../../concepts/function.md).

{% endnote %}

## Getting a list of functions {#function-list}

For function versioning, you need to know the name or unique ID of the function that the version belongs to. To find them, get a list of functions.

{% include [function-list](../../../_includes/functions/function-list.md) %}

## Creating a function version {#func-version-create}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Preparing a ZIP archive with the function code {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

### Creating a function version {#version-create}

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
   1. Select the [runtime environment](../../concepts/runtime/index.md). Use the **Add files with code examples** option.
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
   id: d4evvn8obisajd51plaq
   function_id: d4elpv8pft639ku7k0u6
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
   log_group_id: ckg3qh8h363p40gmr9gn
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the version is there on the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function version list --function-name <function name>
   ```

- Yandex Cloud Toolkit

   You can create a function version using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Getting information about a function version {#version-info}

### Getting a list of function versions {#version-list}

{% include [version-list](../../../_includes/functions/version-list.md) %}

### Getting detailed information about a function version {#version-get}

{% include [version-get](../../../_includes/functions/version-get.md) %}

## Adding environment variables {#version-env}

When you add environment variables, a new version of the function is created. You can't add variables to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select the function whose version you want to add an environment variable for.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, specify the environment variable and click **Add**. You can add multiple environment variables.
   1. Click **Create version**. A new version of the function with the specified environment variables is created.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add environment variables, run the command:

   {% note warning %}

   If the previous version contained environment variables, this command overwrites them.

   {% endnote %}

   ```
   yc serverless function version create \
     --function-name=<function name> \
     --runtime <runtime environment> \
     --entrypoint <entry point> \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id <version ID> \
     --environment <environment variables>
   ```

   Where:

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the `<function file name>`.`<handler name>` format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--source-version-id`: The ID of the function version to copy the code of.
   * `--environment`: Environment variables in key=value format. You can specify multiple pairs separated by commas.

- API

   You can add environment variables using the [createVersion](../../functions/api-ref/Function/createVersion.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add environment variables:

   1. In the configuration file, add the `environment` section for the `yandex_function` resource and specify the list of environment variables in `<key>:"<value>"` format.

      Example function description in the {{ TF }} configuration:

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
          tags               = ["my_tag"]
          environment = {
              <environment_variable_key> = "<environment_variable_name>"
          }
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the environment variables are there in the [management console]({{ link-console-main }}).

- Yandex Cloud Toolkit

   You can add environment variables using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Specifying a cloud network {#networking}

{% include [note-preview](../../../_includes/note-preview.md) %}

You can specify a [cloud network](../../../vpc/concepts/network.md#network) where the function will be executed.

{% include [network](../../../_includes/functions/network.md) %}

For more information about [networking](../../concepts/networking.md), see {{ sf-name }}.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, in the **Network** field, choose a network for function execution.
   1. Click **Create version**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To specify a cloud network, run the command:

   ```
   yc serverless function version create \
     --function-name=<function name> \
     --runtime <runtime environment> \
     --entrypoint <entry point> \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id <version ID> \
     --network-id <network ID>
   ```
   Where:

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the `<function file name>`.`<handler name>` format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--source-version-id`: The ID of the function version to copy the code of.
   * `--network-id`: ID of a cloud network where the function will be executed.

- API

   You can specify a cloud network using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

{% endlist %}

## Transmitting a {{ lockbox-name }} secret {#lockbox}

{% include [note-preview-pp](../../../_includes/note-preview-pp.md) %}

[{{ lockbox-name }}](../../../lockbox/) is a service for storing secrets. You can transmit a {{ lockbox-name }} secret to a function in the [environment variable](../../concepts/runtime/environment-variables.md#env).

A function can access the secret when a service account with the `lockbox.payloadViewer` role is specified in the function's parameters. [How to create a service account](../../../iam/operations/sa/create.md).

A new version of a function is created when secrets are transmitted. You can't transmit secrets to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function where you want to transmit a {{ lockbox-name }} secret to.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, specify:
      * In the **Service account** field, the service account with the `lockbox.payloadViewer` role.
      * In the **{{ lockbox-name }} secret** field:
         * The name of the environment variable where the secret will be kept.
         * Secret ID.
         * Secret version ID.
         * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a function.
   1. Click **Create version**. A new version of the function with the specified secrets is created.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To transmit a {{ lockbox-name }} secret to a function, run the command:

   {% note warning %}

   If the secrets were already passed to the previous function version, they are overwritten.

   {% endnote %}

   ```

   yc serverless function version create \
     --function-name=test \
     --runtime nodejs16 \
     --entrypoint index.main \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id vfdsde*************** \
     --service-account-id bfbtfc************** \
     --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the `<function file name>`.`<handler name>` format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--service-account-id`: ID of the function version to copy the code of.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   You can transmit a {{ lockbox-name }} secret to a function using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

{% endlist %}

## Managing version tags {#manage-tags}

When creating a new version, it's assigned the `$latest` [tag](../../concepts/function.md#) by default. You can [add](version-manage.md#set-tag) and [remove](version-manage.md#remove-tag) version tags.

To access the function version, use its unique ID. For information about how to find the unique version ID, see [Getting a list of function versions](version-manage.md#version-list).

### Adding a tag {#set-tag}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add a version tag, run the command:

   ```
   yc serverless function version set-tag --id <version ID> --tag <tag>
   ```

   Result:

   ```
   id: b09ch6pmpohfc9sogj5f
   function_id: b097d9ous3gep99khe83
   created_at: "2019-06-13T09:12:38.464Z"
   runtime: python37
   entrypoint: test.handler
   resources:
     memory: "134217728"
   execution_timeout: 5s
   image_size: "4096"
   status: ACTIVE
   tags:
   - beta
   - first
   log_group_id: eolv6578frac08uh5h6s
   ```

- API

   You can add a tag using the [setTag](../../functions/api-ref/Function/setTag.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a version tag:

   1. In the configuration file, add the `tags` section for the `yandex_function` resource and specify the list of tags in `tags = ["<tag_name>"]` format.

      Example function description in the {{ TF }} configuration:

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
          tags               = ["my_tag"]
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the tags are there in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function version list --function-name <function name>
   ```

- Yandex Cloud Toolkit

   You can add a tag using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

### Removing a tag {#remove-tag}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To remove a version tag, run the command:

   ```
   yc serverless function version remove-tag --id <version ID> --tag <tag>
   ```

   Result:

   ```
   id: b09ch6pmpohfc9sogj5f
   function_id: b097d9ous3gep99khe83
   created_at: "2019-06-13T09:12:38.464Z"
   runtime: python37
   entrypoint: test.handler
   resources:
     memory: "134217728"
   execution_timeout: 5s
   image_size: "4096"
   status: ACTIVE
   tags:
   - beta
   log_group_id: eolv6578frac08uh5h6s
   ```

- API

   You can remove a tag using the [removeTag](../../functions/api-ref/Function/removeTag.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a version tag:

   1. Open the {{ TF }} configuration file and delete the string with the unnecessary tag in the `tags` section.

      Example function description in the {{ TF }} configuration:

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
          tags               = ["my_tag"]
          content {
              zip_filename = "<path to ZIP archive>"
          }
      }
      ```

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that the tags have been deleted in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function version list --function-name <function name>
   ```

- Yandex Cloud Toolkit

   You can delete a tag using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
