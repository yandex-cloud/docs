# Creating a registry

Any users and service accounts with folder access rights can use the created registry.

{% list tabs %}

- Management console

  To create a [registry](../../concepts/registry.md):

  1. Open the **Container Registry** section in the folder where you want to create the registry.

  1. Click **Create registry**.

  1. Specify a name for the registry.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Click **Create registry**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Make sure that a registry has not been created in the folder yet:

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

      {% include [name-format](../../../_includes/name-format.md) %}

      Note:
      - The `--name` flag is optional: you can create a registry without any name and access it using the ID.
      - The `name` field is user-defined: it is used for listing in the YC CLI and is **not used** in the Docker CLI.

  1. Make sure the registry was created:

      ```
      $ yc container registry list
      +----------------------+--------+----------------------+
      |          ID          |  NAME  |      FOLDER ID       |
      +----------------------+--------+----------------------+
      | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
      +----------------------+--------+----------------------+
      ```

- API

  To create a registry, use the [create](../../api-ref/Registry/create.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}