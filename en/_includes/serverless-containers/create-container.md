{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [container](../../serverless-containers/concepts/container.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Click **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
   1. Enter a name and a description for the container. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a [container](../../serverless-containers/concepts/container.md), run this command:

   ```bash
   yc serverless container create --name <container_name>
   ```

   Result:

   ```text
   id: bba3fva6ka5g********
   folder_id: b1gqvft7kjk3********
   created_at: "2021-07-09T14:49:00.891Z"
   name: my-beta-container
   url: https://bba3fva6ka5g********.{{ serverless-containers-host }}/
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a [container](../../serverless-containers/concepts/container.md) and its [revision](../../serverless-containers/operations/manage-revision.md):

   {% note info %}

   {% include [revision-service-account-note](revision-service-account-note.md) %}

   {% endnote %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Container name. This is a required parameter. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `memory`: Amount of memory allocated to a container, MB. The default value is 128 MB.
      * `service_account_id`: [Service account](../../iam/concepts/users/service-accounts.md) ID.
      * `url`: [Docker image](../../container-registry/concepts/docker-image.md) URL in [{{ container-registry-full-name }}](../../container-registry/).

      > Here is an example of the configuration file structure:
      >
      > ```hcl
      > provider "yandex" {
      >  token     = "<OAuth>"
      >  cloud_id  = "<cloud_ID>"
      >  folder_id = "<folder_ID>"
      >  zone      = "{{ region-id }}-a"
      > }
      >
      > resource "yandex_serverless_container" "test-container" {
      >   name               = "<container_name>"
      >   memory             = <memory_size>
      >   service_account_id = "<service_account_ID>"
      >   image {
      >       url = "<Docker_image_URL>"
      >   }
      > }
      > ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

         ```bash
         yc serverless container list
         ```

- API {#api}

   To create a [container](../../serverless-containers/concepts/container.md), use the [create](../../serverless-containers/containers/api-ref/Container/create.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/container_service.md#Create) gRPC API call.

{% endlist %}