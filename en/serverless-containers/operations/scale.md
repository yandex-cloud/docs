# Scaling a container

You can set the number of provisioned instances.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

Learn more about [container scaling](../concepts/container.md#scaling) in {{ serverless-containers-name }}.

## Viewing scaling settings {#list}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ serverless-containers-name }}**.
    1. Select the container. The number of provisioned instances is displayed under **Revisions**, in the line with the active container revision.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view a container's scaling settings, run the command:

    ```
    yc serverless container revision get container-id=flhqle7d5o**********
    ```

    Where `--container-id` is a container ID. To find out the ID, [get](list.md) a list of containers.

    Result:

    ```
    id: flhqle7d5o**********
	container_id: flhqle7d5o**********
	created_at: "2022-09-14T12:48:55.914Z"
	image:
	  image_url: cr.cloud-preprod.yandex.net/crtrvt9l6f**********/billing-test
	  image_digest: sha256:e3aaa4c9af7d99ea5e4e4236bc540a3cc826d1f1344a601ddb9cbc**********
	resources:
	  memory: "134217728"
	  cores: "1"
	  core_fraction: "100"
	execution_timeout: 10s
	service_account_id: bfbdkhbl8f**********
	status: ACTIVE
	provision_policy:
	  min_instances: "1"
    ```

    The number of provisioned instances is displayed in the `min_instances` field.

{% endlist %}

## Adding scaling settings {#add}

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

    To add a container's scaling settings, run the command:

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
    * `--memory`: Required memory. The default is 128 MB.
    * `--execution-timeout`: Timeout. Default is 3 seconds.
    * `--service-account-id`: [ID of service account](../../iam/operations/sa/get-id.md) with authorization to download an image.
    * `--min-instances`: Number of provisioned instances.


    Result:

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
	provision_policy:
	  min_instances: "1"
    ```

{% endlist %}

## Deleting scaling settings {#delete}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ serverless-containers-name }}**.
    1. Select the container.
    1. Go to the **Editor** tab.
    1. Under **Settings**, specify the number of provisioned instances equal to `0`.
    1. Click **Create revision**.

- CLI

    To delete a container's scaling settings, create a new container revision and specify the `0` value for the `min-instances` parameter:

    ```
    yc serverless container revision deploy \
	  --container-id <container_ID> \
	  --image <Docker_image_URL> \
	  --cores 1 \
	  --memory 1GB \
	  --execution-timeout 3s \
	  --service-account-id <service_account_ID> \
	  --min-instances 0
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
    * `--cores`: Number of cores available for the container.
    * `--memory`: Required memory. The default is 128 MB.
    * `--execution-timeout`: Timeout. Default is 3 seconds.
    * `--service-account-id`: [ID of service account](../../iam/operations/sa/get-id.md) with authorization to download an image.
    * `--min-instances`: Number of provisioned instances.

    Result:

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
