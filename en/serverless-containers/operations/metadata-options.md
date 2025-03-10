# Configuring metadata service parameters for a container

You can configure metadata service parameters when [creating a container revision](manage-revision.md).

{% include [metadata-options](../../_includes/functions/metadata-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your [container](../../serverless-containers/concepts/container.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container.
  1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
  1. Expand the **Metadata service parameters** section.
  1. Configure metadata service parameters for the container: `{{ ui-key.yacloud.serverless-containers.label_gce_http_endpoint }}` and `{{ ui-key.yacloud.serverless-containers.label_aws_v1_http_endpoint }}`.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    To configure metadata service parameters for a container, run this command:

    ```bash
    yc serverless container revision deploy \
      --container-id <container_ID> \
      --image <Docker_image_URL> \
      --service-account-id <service_account_ID>
      --metadata-options <option>=<enable_or_disabled>
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
    * `--image`: {{ container-registry-full-name }} Docker image URL.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
    * `--metadata-options`: Settings for the metadata service parameters, e.g., `aws-v1-http-endpoint=disabled`.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To configure metadata service parameters for a container:

    1. Open the Terraform configuration file and add the `metadata_options` section to the container description:
      
        ```hcl
        resource "yandex_serverless_container" "metadata_container" {
          name               = "<container_name>"
          memory             = "<RAM_size>"
          execution_timeout  = "<execution_timeout>"
          service_account_id = "<service_account_ID>"
          content {
            zip_filename = "<path_to_ZIP_archive>"
          }

          image {
            url = <container_image_path>
          }

          metadata_options {
            metadata_options.0.gce_http_endpoint = "0_or_1_or_2"
            metadata_options.0.aws_v1_http_endpoint = "0_or_1_or_2"
          }
        }
        ```

        Where:

        * `metadata_options`: Settings for the metadata service parameters, e.g., `metadata_options.0.gce_http_endpoint = "1"`. Specify the following:
            * `0` if you want to keep the default value.
            * `1` to enable the parameter.
            * `2` to disable the parameter.

        For more information about the `yandex_serverless_container` resource parameters, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_container).

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check that the container and its settings have changed using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc serverless container revision get <container_revision_ID>
   ```

- API {#api}

    To conigure metadata service parameters for a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}
