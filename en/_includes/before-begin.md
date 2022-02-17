## Before you start {#before-you-begin}

Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations. If that folder doesn't exist, create it:

{% list tabs %}

- Management console

  {% include [create-folder](create-folder.md) %}

- CLI

  {% include [cli-install](cli-install.md) %}

  1. See a description of the create folder command:

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

- API

  Use the [create](../resource-manager/api-ref/Folder/create.md) method for the [Folder](../resource-manager/api-ref/Folder/index.md) resource of the {{ resmgr-full-name }} service.

{% endlist %}

