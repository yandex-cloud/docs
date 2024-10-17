# Adding container environment variables

When you add environment variables, a new container revision is created. You cannot add environment variables to an existing revision.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select the container whose version you want to add an environment variable for.
   1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
   1. In the window that opens, under **{{ ui-key.yacloud.serverless-containers.section_image }}**, specify the environment variable and click **{{ ui-key.yacloud.common.add }}**. You can add multiple environment variables.
   1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. A new container revision with the specified environment variables will be created.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add environment variables, run the command:

   {% note warning %}

   If the previous revision contained environment variables, this command overwrites them.

   {% endnote %}

   ```
   yc serverless container revision deploy \
     --container-name <container_name> \
     --image <Docker_image_URL> \
     --cores 1 \
     --memory 1GB \
     --service-account-id <service_account_ID> \
     --environment <environment_variables>
   ```

   Where:

   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default value is 128 MB.
   * `--environment`: Environment variables in `key=value` format. You can specify multiple pairs separated by commas.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To add environment variables:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, add an environment list with the `environment` variables to the `image` section:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-container"
        memory             = 256
        service_account_id = "ajecvjv1lv01********"
        image {
            url = "{{ registry }}/yc/test-image:v1"
            environment = {
                <key> = "<value>"
            }
        }
      }
      ...
      ```

      Where `environment` is the environment variables in `key="value"` format. You can specify more than one pair.

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

   1. Check the configuration using this command:
      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can check the new environment variables using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

   ```
   yc serverless container revision get <revision_ID>
   ```

- API {#api}

   To add an environment variable, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## See also

* [Environment variables](../concepts/runtime.md#environment-variables).