---
title: "Deleting container scaling settings"
description: "Follow this guide to delete container scaling settings."
---

# Deleting container scaling settings

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, set the number of ready-to-go instances to `0`.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

    To delete scaling settings for a container, create a new container revision and set the `min-instances` parameter to `0`:

    ```bash
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
    * `--cores`: Number of cores available to the container.
    * `--memory`: Required memory. The default value is 128 MB.
    * `--execution-timeout`: Timeout. The default value is 3 seconds.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) authorized to download the image.
    * `--min-instances`: Number of ready-to-go instances.

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

- API {#api}

  To delete container scaling settings, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
