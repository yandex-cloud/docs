{% include [revision-service-account-note](./revision-service-account-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container whose [revision](../../serverless-containers/concepts/container.md#revision) you want to create.
  1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
  1. Under **{{ ui-key.yacloud.serverless-containers.section_image }}**:
      * Specify the {{ container-registry-full-name }} Docker image URL.
      * Additionally specify the revision parameters, if needed:
          * **{{ ui-key.yacloud.serverless-containers.label_command }}**: Commands that the container will run when started. It matches the `ENTRYPOINT` instruction in the Dockerfile.
          * **{{ ui-key.yacloud.serverless-containers.label_args }}**: Matches the `CMD` instruction in the Dockerfile. Specify arguments in `key = value` format. If you do not specify this parameter, the default `CMD` value from the Docker image will be used.

              You can provide multiple arguments to a container. To do this, click **{{ ui-key.yacloud.common.add }}**.

          * **{{ ui-key.yacloud.serverless-containers.label_working-directory }}**: Allows you to change the working directory of a container. It matches the `WORKDIR` instruction in the Dockerfile. We recommend setting absolute paths to folders.

  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  To create a [container](../../serverless-containers/concepts/container.md) [revision](../../serverless-containers/concepts/container.md#revision), run this command:

  ```bash
  yc serverless container revision deploy \
    --container-name <container_name> \
    --image <Docker_image_URL> \
    --cores 1 \
    --memory 1GB \
    --concurrency 1 \
    --execution-timeout 30s \
    --service-account-id <service_account_ID> \
    --command '<command_1>','<command_2>' \
    --args '<key_1=value_1>','<key_2=value_2>'
  ```


  Where:
  * `--cores`: Number of cores available to the container.
  * `--memory`: Required memory. The default value is 128 MB.
  * `--concurrency`: Maximum number of concurrent requests to a single container instance. May be in the range between 1 (default) and 16. If the number of requests to a container exceeds the `concurrency` value, {{ serverless-containers-name }} scales the container up by running its additional instances.

      {% include [quota-containers-requests](quota-containers-requests.md) %}

   * `--execution-timeout`: Timeout. The default value is 3 seconds.
   * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
   * `--command`: Commands the container will run when started. Separate them by commas. It matches the `ENTRYPOINT` instruction in the Dockerfile.
   * `--args`: Arguments matching the `CMD` instruction in the Dockerfile. Specify them in `key = value` format separated by commas. If you do not specify this parameter, the default `CMD` value from the Docker image will be used.

  Result:

  ```text
  id: bbajn5q2d74c********
  container_id: bba3fva6ka5g********
  created_at: "2021-07-09T15:04:55.135Z"
  image:
    image_url: {{ registry }}/crpd3cicopk7********/test-container:latest
    image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
  resources:
    memory: "1073741824"
    cores: "1"
  execution_timeout: 3s
  service_account_id: ajeqnasj95o7********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  In {{ TF }}, a new [revision](../../serverless-containers/concepts/container.md#revision) is created every time the resource runtime parameters are updated.

  To create a revision:
  1. Update the parameters of the `yandex_serverless_container` resource in the configuration file:

     ```hcl
     resource "yandex_serverless_container" "test-container" {
       name               = "<container_name>"
       cores              = "<number_of_cores>"
       memory             = "<memory_size>"
       concurrency        = "<concurrent_requests>"
       service_account_id = "<service_account_ID>"
       image {
         url      = "<Docker_image_URL>"
         command  = ["<command_1>","<command_2>"]
         args     = ["<key_1=value_1>","key_2=value_2"]
         work_dir = "<working_directory>"
       }
     }
     ```

     Where:

    * `cores`: Number of cores available to the container.
    * `memory`: Required memory. The default value is 128 MB.
    * `concurrency`: Maximum number of concurrent requests to a single container instance. May be in the range between 1 (default) and 16. If the number of requests to a container exceeds the `concurrency` value, {{ serverless-containers-name }} scales the container up by running its additional instances.

        {% include [quota-containers-requests](quota-containers-requests.md) %}

     * `command`: Commands the container will run when started. Separate them by commas. It matches the `ENTRYPOINT` instruction in the Dockerfile.
     * `args`: Arguments matching the `CMD` instruction in the Dockerfile. Specify them in `key = value` format separated by commas. If you do not specify this parameter, the default CMD value from the Docker image will be used.
     * `work_dir`: Allows you to change the working directory of a container. It matches the `WORKDIR` instruction in the Dockerfile. We recommend setting absolute paths to folders.

     For more information about the `yandex_serverless_container` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/serverless_container).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create the revision. You can check the new revision using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc serverless container revision list
     ```

- API {#api}

  To create a [container](../../serverless-containers/concepts/container.md) [revision](../../serverless-containers/concepts/container.md#revision), use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}
