
{% include [revision-service-account-note](./revision-service-account-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select the container to create a revision for.
   1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
   1. Specify the revision parameters.
   1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI

   To create a container revision, run the command:

   ```
   yc serverless container revision deploy \
     --container-name <container_name> \
     --image <Docker_image_URL> \
     --cores 1 \
     --memory 1GB \
     --concurrency 1 \
     --execution-timeout 30s \
     --service-account-id <service_account_ID>
   ```

   Where:

   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default value is 128 MB.
   * `--concurrency`: Maximum number of concurrent requests to a single container instance. May be in the range between 1 (default) and 16. If the number of requests to a container exceeds the value of `concurrency`, {{ serverless-containers-name }} scales the container up by launching additional copies.

      {% note info %}

      The number of container instances and concurrent container requests in each zone cannot exceed the [quota](../../serverless-containers/concepts/limits.md#serverless-containers-quotas).

      {% endnote %}

   * `--execution-timeout`: Timeout. The default value is 3 seconds.
   * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) authorized to download an image.

   Result:

   ```
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

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   In {{ TF }}, a new revision is created every time the resource runtime parameters are updated.

   To create a revision:

   1. Update the `yandex_serverless_container` resource runtime parameters in the configuration file:

      
      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_serverless_container" "test-container" {
         name               = "<container name>"
         memory             = <memory size>
         service_account_id = "<service account ID>"
         image {
             url = "<Docker image URL>"
         }
      }
      ```



      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

   1. Make sure the configuration files are valid.

      1. In the command line, switch to the folder where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of resources being created or updated and their parameters. If the configuration contains any errors, {{ TF }} will point them out.


   1. If the configuration does not contain any errors, run this command:
      ```
      terraform apply
      ```

   1. Confirm the resource creation or update by typing `yes` in the terminal and pressing **Enter**.

      This will create the revision. You can check the new revision using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```
      yc serverless container revision list
      ```

- API

   To create a container revision, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}
