## Getting started {#before-you-begin}

Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations. If that folder does not exist, create it:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-folder](create-folder.md) %}

- CLI {#cli}

  {% include [cli-install](cli-install.md) %}

  1. View the description of the create folder command:

      ```bash
      yc resource-manager folder create --help
      ```

  1. Create a new folder:

      * with a name and without a description:

          ```bash
          yc resource-manager folder create \
             --name new-folder
          ```

          {% include [name-format](name-format.md) %}

      * with a name and description:

          ```bash
          yc resource-manager folder create \
             --name new-folder \
             --description "my first folder with description"
          ```

- API {#api}

  Use the [create](../resource-manager/api-ref/Folder/create.md) method for the [Folder](../resource-manager/api-ref/Folder/index.md) resource of the {{ resmgr-full-name }} service.

{% endlist %}
