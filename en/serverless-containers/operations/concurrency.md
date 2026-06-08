# Setting the number of concurrent container instance calls

Number of concurrent container instance calls (`concurrency`) cannot exceed the relevant [quota](../concepts/limits.md#serverless-containers-quotas).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Set the number of concurrent container instance calls under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set the number of concurrent container instance calls, run this command:

    ```bash
    yc serverless container revision deploy \
      --container-id <container_ID> \
      --image <Docker_image_URL> \
      --concurrency 2 \
      --service-account-id <service_account_ID>
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) the list of containers.
    * `--image`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
    * `--concurrency`: Maximum number of concurrent invocations per container instance.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with Docker image download permissions.

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
    concurrency: "2"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    To learn more about the command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/container/revision/deploy.md).

- {{ TF }} {#tf}
  
    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. To set the number of concurrent requests to a single container instance, describe the `concurrency` parameter in the configuration file.
        
        Here is an example of the configuration file structure:
        
        ```
        resource "yandex_serverless_container" "container" {
          name               = "container"
          service_account_id = "ajeh91ebakk1********"
          memory             = 128
          concurrency        = 2
          image {
            url = "cr.yandex/crpnj09pj62e********/ubuntu:hello"
          }
        }
        ```

        Where:
        * `name`: Container name.
        * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) with Docker image download permissions.
        * `memory`: Required memory. The default value is 128 MB.
        * `concurrency`: Maximum number of concurrent invocations per container instance.
        * `url`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
       
       For more information about `yandex_serverless_container` properties, see [this provider guide]({{ tf-provider-resources-link }}/serverless_container).

    1. Run a check using the following command:

        ```
        terraform plan
        ```

        A list of resource parameters will be displayed in the terminal. This is a test step: the resource will not be changed. {{ TF }} will show any errors in the configuration.

    1. Apply the configuration changes:

        ```
        terraform apply
        ```

    1. Confirm changing the resources: enter `yes` in the terminal window and press **Enter**.

- API {#api}

    To set the number of concurrent container instance calls, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
