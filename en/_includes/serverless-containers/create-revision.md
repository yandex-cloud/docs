{% include [revision-service-account-note](./revision-service-account-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container to create a revision for.
   1. Go to the **Editor** tab.
   1. Specify the revision parameters.
   1. Click **Create revision**.

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
   * `--memory`: Required memory. The default is 128 MB.
   * `--concurrency`: Maximum number of concurrent requests to a single container instance. Default is 1 and maximum value is 16. If the number of requests to a container exceeds the value of `concurrency`, {{ serverless-containers-name }} scales the container up by launching additional copies.

      {% note info %}

      The number of container instances and concurrent container requests in each zone cannot exceed the [quota](../../serverless-containers/concepts/limits.md#serverless-containers-quotas).

      {% endnote %}

   * `--execution-timeout`: Timeout. Default is 3 seconds.
   * `--service-account-id`: [ID of service account](../../iam/operations/sa/get-id.md) with authorization to download an image.

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

- API

   You can create a container revision using the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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



      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Make sure the configuration files are valid.

      1. In the command line, switch to the folder where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of resources being created or updated and their parameters. If the configuration contains errors, {{ TF }} will point them out.


   1. If the configuration does not contain any errors, run the command:
      ```
      terraform apply
      ```

   1. Confirm the resource creation or update by typing `yes` in the terminal and pressing **Enter**.

      This will create the revision. You can verify that the revision has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/) command:

      ```
      yc serverless container revision list
      ```

{% endlist %}