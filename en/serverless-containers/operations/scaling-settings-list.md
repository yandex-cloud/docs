# Viewing container scaling settings

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container. The number of provisioned instances is displayed under **Revisions**, in the line with the active container revision.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To view the container scaling settings, run this command:

   ```
   yc serverless container revision get container-id=flhqle7d5o**********
   ```

   Where `--container-id` is the container ID. To find out the ID, [get](list.md) a list of containers.

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

- API

   To view container scaling settings, use the [getRevision](../containers/api-ref/Container/getRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/GetRevision](../containers/api-ref/grpc/container_service.md#GetRevision) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}