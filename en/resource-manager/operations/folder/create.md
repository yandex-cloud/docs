# Creating a folder

_A folder_ is an isolated space where {{ yandex-cloud }} resources are created and grouped.

{% note alert %}

When creating folders, keep in mind the [quotas and limits](../../concepts/limits.md). Currently, you cannot delete a folder yourself.

{% endnote %}

{% list tabs %}

- Management console

  {% include [create-folder](../../../_includes/create-folder.md) %}

- CLI

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

          {% include [name-format](../../../_includes/name-format.md) %}

      * with a name and description:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  To create a folder, use the [create](../../api-ref/Folder/create.md) method for the[Folder](../../api-ref/Folder/index.md) resource.

{% endlist %}

