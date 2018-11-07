# Create a folder

_A folder_ is an isolated space where Yandex.Cloud resources are created and grouped.

---

**[!TAB Management console]**

[!INCLUDE [create-folder](../../../_includes/create-folder.md)]

**[!TAB CLI]**

1. See the description of the folder creation command:

    ```
    $ yc resource-manager folder create --help
    ```

2. Create a new folder:

    * with a name and without a description:

        ```
        $ yc resource-manager folder create \
            --name new-folder
        ```

        [!INCLUDE [name-format](../../../_includes/name-format.md)]

    * with a name and a description:

        ```
        $ yc resource-manager folder create \
            --name new-folder \
            --description "my first folder with description"
        ```

**[!TAB API]**

To create a folder, use the [create](../../api-ref/Folder/create.md) method for the[Folder](../../api-ref/Folder/index.md) resource.

---

