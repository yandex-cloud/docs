# Adding container scaling settings

You can set the following:

{% include [scaling-settings](../../_includes/serverless-containers/scaling-settings.md) %}

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

The scaling settings must be within the [quotas](../concepts/limits.md#serverless-containers-quotas).

{% note info %}

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md)%}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder with your container.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, specify the number of provisioned instances.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To configure scaling settings, run this command:

    ```bash
    yc serverless container revision deploy \
      --container-id <container_ID> \
      --image <Docker_image_URL> \
      --min-instances 3 \
      --zone-instances-limit 2 \
      --zone-requests-limit 1 \
      --service-account-id <service_account_ID>
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
    * `--image`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
    * `--min-instances`: Number of provisioned instances.
    * `--zone-instances-limit`: Maximum number of container instances per availability zone.
    * `--zone-requests-limit`: Maximum number of simultaneous container invocations per availability zone.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.

    Result:

    ```
    done (3s)
    id: bbalbpl7k8hmn********
    container_id: bbab5i36nvda********
    created_at: "2026-04-01T13:46:38.069Z"
    image:
      image_url: cr.yandex/crpp35hht729********/ubuntu:hello
      image_digest: sha256:f6f34c6cf5f56e594e9828274592f1cc4d9383b1689057ccaf188d41********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    provision_policy:
      min_instances: "1"
    scaling_policy:
      zone_instances_limit: "2"
      zone_requests_limit: "1"
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    To learn more about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/serverless/container/revision/deploy).

- {{ TF }} {#tf}
  
    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. To set the number of prepared instances, describe the `min_instances` parameter in the configuration file.

        You can configure other scaling settings using the management console, {{ yandex-cloud }} CLI, or API.
        
        Here is an example of the configuration file structure:
        
        ```
        resource "yandex_serverless_container" "container" {
          name               = "container"
          service_account_id = "ajeh91ebakk1********"
          memory             = 128
          image {
            url = "cr.yandex/crpnj09pj62e********/ubuntu:hello"
          }
          provision_policy {
            min_instances = 2
          }
        }
        ```

        Where:
        * `name`: Container name.
        * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
        * `memory`: Required memory. The default value is 128 MB.
        * `url`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
        * `min_instances`: Number of provisioned instances.
       
       For more information about the `yandex_serverless_container` properties, see [this provider guide]({{ tf-provider-resources-link }}/serverless_container).

    1. Run a check using the following command:

        ```
        terraform plan
        ```

        The terminal will display a list of resource parameters. This is a verification step: the resource will not be modified. {{ TF }} will show any errors in the configuration.

    1. Apply the configuration changes:

        ```
        terraform apply
        ```

    1. Confirm changing the resources: enter `yes` in the terminal window and press **Enter**.

- API {#api}

    To add container scaling settings, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
