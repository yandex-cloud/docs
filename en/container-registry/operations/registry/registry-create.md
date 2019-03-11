# Creating a registry

One folder may have only one [registry](../../concepts/registry.md). Anyone with access rights to the folder can use the created registry.

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Get a list of registries in the default folder:

    ```
    $ yc container registry list
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```

    If the folder already contains a registry, see [Updating a registry](registry-update.md) for information about how you can change it.

1. Create a registry:

    ```
    $ yc container registry create --name my-reg
    ..done
    id: crpd50616s9a2t7gr8mi
    folder_id: b1g88tflru0ek1omtsu0
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```

    The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.

    Note:
    * The `--name` flag is optional: you can create a registry without any name and access it using the ID.
    * The `name` field is user-defined: it is used for listing in the YC CLI and is **not used** in the Docker CLI.

1. Make sure the registry has been created:

    ```
    $ yc container registry list
    +----------------------+--------+----------------------+
    |          ID          |  NAME  |      FOLDER ID       |
    +----------------------+--------+----------------------+
    | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
    +----------------------+--------+----------------------+
    ```

**[!TAB API]**

To create a registry, use the [create](../../api-ref/Registry/create.md) method for the [Registry](../../api-ref/Registry/) resource.

---

