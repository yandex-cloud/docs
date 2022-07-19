# Creating a function

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a function.
    
    1. Open **{{ sf-name }}**.
    
    1. Click **Create function**.
    1. Enter a name and description for the function. Name format:

        {% include [name-format](../../../_includes/name-format.md) %}

    1. Click **Create**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a function, run the command:

    ```
    yc serverless function create --name=<function name>
    ```

    Result:

    ```
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    status: ACTIVE
    ```

- API

    You can create a function using the [create](../../functions/api-ref/Function/create.md) API method.

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    If you don't have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    To create a function:

    1. In the configuration file, describe the parameters of resources that you want to create:

       * `yandex_function`: Description of the function being created and its source code:
         * `name`: Function name.
         * `folder_id`: ID of the folder.
         * `description`: Text description of the function.
         * `labels`: Function labels in `key:value` format.
         * `user_hash`: An arbitrary string that identifies the function version. When the function changes, update this string, too. The function will update when this string is updated.
         * `runtime`: Function runtime environment. For a full list of runtimes, see [Runtime environments](../../concepts/runtime/index.md).
         * `entrypoint`: Function name in the source code that will serve as an entry point to the applications.
         * `memory`: The amount of memory allocated for function execution, in MB.
         * `execution_timeout`: Function execution timeout.
         * `service_account_id`: ID of the service account that should be used to invoke the function.
         * `environment`: Environment variables in `key:value` format.
         * `tags`: Function tags.
         * `version`: Function version.
         * `image_size`: Size of the image for the function.
         * `loggroup_id`: ID of the log group for the function.
         * `package`: Package with the source code of the function version. You can only use either the `package` or `content` field.
         * `package.0.sha_256`: SHA256 hash of the deployed package.
         * `package.0.bucket_name`: Name of the bucket in {{ objstorage-name }} that stores the source code of the function version.
         * `package.0.object_name`: Name of the object in {{ objstorage-name }} that contains the source code of the function version.
         * `content`: Function source code. You can only use either the `content` or `package` field.
         * `content.0.zip_filename`: Name of the ZIP archive that contains the function source code.

        Example configuration file structure:

        
        ```hcl
        provider "yandex" {
            token     = "<OAuth or static key of service account>"
            folder_id = "<folder ID>"
            zone      = "{{ region-id }}-a"
        }
        
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
                zip_filename   = "<path to ZIP archive>"
            }
        }
        
        output "yandex_function_test-function" {
            value = "${yandex_function.test-function.id}"
        }
        ```



        For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

    2. Make sure that the configuration files are correct.
        1. In the command line, go to the directory where you created the configuration file.
        2. Run the check using the command:

            ```
            terraform plan
            ```

        If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   3. Deploy the cloud resources.
        1. If the configuration doesn't contain any errors, run the command:

            ```
            terraform apply
            ```
        2. Confirm that you want to create the resources.

        Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

- Yandex Cloud Toolkit

    You can create a function using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

