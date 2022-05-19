
{% include [revision-service-account-note](./revision-service-account-note.md) %}

{% list tabs %}

- Management console

   1. In the [management console] ({{ link-console-main }}), select the folder with your container.
   1. Open **{{ serverless-containers-name }}**.
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

   Output:

   ```
   	id: bbajn5q2d74c********
   	container_id: bba3fva6ka5g********
   	created_at: "2021-07-09T15:04:55.135Z"
   	image:
   	  image_url: cr.yandex/crpd3cicopk7********/test-container:latest
   	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
   	resources:
   	  memory: "1073741824"
   	  cores: "1"
   	execution_timeout: 3s
   	service_account_id: ajeqnasj95o7********
   	status: ACTIVE
   ```

{% endlist %}
