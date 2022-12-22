{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Click **Create container**.
   1. Enter a name and a description for the container. Name format:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **Create**.


- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a container, run the command:

   ```
   	yc serverless container create --name <container_name>
   ```

   Result:

   ```
   	id: bba3fva6ka5g********
   	folder_id: b1gqvft7kjk3********
   	created_at: "2021-07-09T14:49:00.891Z"
   	name: my-beta-container
   	url: https://bba3fva6ka5g********.containers.yandexcloud.net/
   	status: ACTIVE
   ```

- API

   You can create a container using the API [create](../../serverless-containers/containers/api-ref/Container/create.md) method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a container and a container [revision](../../serverless-containers/operations/manage-revision.md):

   {% note info %}

   {% include [revision-service-account-note](revision-service-account-note.md) %}

   {% endnote %}

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `name` is the container name. Required parameter. Naming requirements:

         {% include [name-format](../../_includes/name-format.md) %}

      * `memory`: Amount of memory allocated to a container, MB. The default is 128 MB.
      * `service_account_id` = [service account](../../iam/concepts/users/service-accounts.md) ID.
      * `url`: [Docker image](../../container-registry/concepts/docker-image.md) URL in {{ container-registry-name }}.

      Example configuration file structure:

      
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

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/) command:

      ```
      yc serverless container list
      ```


{% endlist %}
