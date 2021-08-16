# Getting information about existing registries

Find out how to get:

- [A list of registries in a folder](#registry-list)
- [Detailed information about a registry](#registry-get)

## Getting a list of registries in a folder {#registry-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Get the list of [registries](../../concepts/registry.md) in the default folder:

  ```
  $ yc container registry list
  +----------------------+--------+----------------------+
  |          ID          |  NAME  |      FOLDER ID       |
  +----------------------+--------+----------------------+
  | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
  +----------------------+--------+----------------------+
  ```

- API

  To get the list of registries in the default folder, use the [list](../../api-ref/Registry/list.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Getting detailed information about a registry {#registry-get}

You can access the registry using the `id` or `name` parameters from the [previous](#registry-list) item.

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Get detailed information about the registry:

  ```
  $ yc container registry get my-reg
  id: crpd50616s9a2t7gr8mi
  folder_id: b1g88tflru0ek1omtsu0
  name: my-reg
  status: ACTIVE
  created_at: "2019-01-09T14:34:06.601Z"
  ```

- API

  You can get detailed information about a registry using the [get](../../api-ref/Registry/get.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}