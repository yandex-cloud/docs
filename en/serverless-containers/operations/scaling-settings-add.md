# Adding container scaling settings

You can set the number of provisioned instances.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

The scaling settings must be within the [quotas](../concepts/limits.md#serverless-containers-quotas).

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md)%}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container.
   1. Go to the **Editor** tab.
   1. Under **Settings**, specify the number of provisioned instances.
   1. Click **Create revision**.

- CLI

   To add scaling settings for a container, run this command:

   ```
   yc serverless container revision deploy \
     --container-id <container_ID> \
     --image <Docker_image_URL> \
     --cores 1 \
     --memory 1GB \
     --execution-timeout 3s \
     --service-account-id <service_account_ID> \
     --min-instances 1
   ```

   Where:
   * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default value is 128 MB.
   * `--execution-timeout`: Timeout. The default value is 3 seconds.
   * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) authorized to download an image.
   * `--min-instances`: Number of provisioned instances.


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
	provision_policy:
	  min_instances: "1"
    ```

- API

   You can add scaling settings for a container using the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
