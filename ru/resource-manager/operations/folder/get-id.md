# Получение идентификатора каталога

{% list tabs %}

- Консоль управления

  1. Выберите каталог на [стартовой странице]({{ link-console-cloud }}) консоли управления. На этой странице отображается информация о всех каталогах в выбранном облаке.{% if product == "yandex-cloud" %} Если необходимо, [переключитесь на другое облако](../cloud/switch-cloud.md).{% endif %}
  
  1. Получить идентификатор каталога можно из URL страницы каталога в консоли управления:
      ```
      {{ link-console-main }}/folders/b1gd129pp9ha0vnvf5g7
      ```

      Где `b1gd129pp9ha0vnvf5g7` — это идентификатор каталога.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Если вы знаете имя каталога, получите его идентификатор с помощью команды `get`:

  ```bash
  yc resource-manager folder get my-folder
  ```

  Результат:

  ```
  id: b1gd129pp9ha0vnvf5g7
  ...
  ```

  Если вы не знаете имя каталога, получите список каталогов с идентификаторами для облака по умолчанию:

  ```bash
  yc resource-manager folder list
  ```

  Результат:

  ```
  +----------------------+--------------------+------------------+--------+
  |          ID          |        NAME        |      LABELS      | STATUS |
  +----------------------+--------------------+------------------+--------+
  | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
  | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
  +----------------------+--------------------+------------------+--------+
  ```

  Чтобы посмотреть список каталогов в другом облаке, укажите идентификатор каталога в `cloud-id`:

  ```bash
  yc resource-manager folder list --cloud-id b1glku4lgd6g31h5onqs
  ```

- API

  Чтобы получить список каталогов с идентификаторами, воспользуйтесь методом REST API [list](../../api-ref/Folder/list.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/List](../../api-ref/grpc/folder_service.md#List).

{% endlist %}
