## Before you start

Go to the Yandex.Cloud [management console]({{ link-console-main }}) and select the folder where you want to perform the operations. If there is no such folder, create one:

{% list tabs %}

- Management console

  {% include [create-folder](create-folder.md) %}

- CLI

  {% include [cli-install](cli-install.md) %}

  1. See a description of the create folder command:

      ```
      $ yc resource-manager folder create --help
      ```

  2. Create a new folder:

      * with a name and without a description:

          ```
          $ yc resource-manager folder create \
              --name new-folder
          ```

          {% include [name-format](name-format.md) %}

      * with a name and description:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  To create a folder, use the [create](../resource-manager/api-ref/Folder/create.md) method for the [Folder](../resource-manager/api-ref/Folder/index.md) resource of {{ resmgr-full-name }}.

{% endlist %}

