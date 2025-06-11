{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В строке с нужной ВМ нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Раскройте секцию **{{ ui-key.yacloud.common.metadata }}** и удалите ключи, нажав ![image](../../_assets/console-icons/xmark.svg).
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления метаданных:

      ```bash
      yc compute instance remove-metadata --help
      ```

  1. Удалите ключи:

      ```bash
      yc compute instance remove-metadata <идентификатор_ВМ> --keys <имя_SSH-ключа>
      ```

- API {#api}

  Чтобы удалить SSH-ключи из метаданных ВМ, воспользуйтесь методом REST API [updateMetadata](../../compute/api-ref/Instance/updateMetadata.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/UpdateMetadata](../../compute/api-ref/grpc/Instance/updateMetadata.md).

  В запросе передайте параметр `delete` с SSH-ключом.

  **Пример запроса для REST API**

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{"delete":["<имя_SSH-ключа>"]}' \
    https://compute.{{ api-host }}/compute/v1/instances/<идентификатор_ВМ>/updateMetadata
  ```

{% endlist %}
