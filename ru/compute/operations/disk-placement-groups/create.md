# Создать группу размещения дисков

Создайте [группу размещения](../../concepts/disk-placement-group.md) для нереплицируемых дисков.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать группу размещения дисков.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/group-placement-pic.svg) **Группы размещений**.
  1. Перейдите на вкладку **Группы размещения нереплицируемых дисков**.
  1. Нажмите кнопку **Создать группу размещения нереплицируемых дисков**.
  1. Введите имя группы.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, добавьте произвольное описание группы.
  1. Укажите [зону доступности](../../../overview/concepts/geo-scope.md).
     
          
     {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
     
     
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для создания группы размещения дисков:
  
      ```bash
      yc compute disk-placement-group create --help
      ```
  
  1. Создайте группу в каталоге по умолчанию:
  
      ```bash
      yc compute disk-placement-group create \
        --name first-group \
        --description "first disk placement group"
      ```
  
      Будет создана группа размещения дисков с именем `first-group` и описанием `first disk placement group`.
  
  1. Получите список групп размещения дисков в каталоге по умолчанию:
  
      ```bash
      yc compute disk-placement-group list
      ```

      Результат:

      ```text
      +----------------------+-------------+---------------+--------+
      |          ID          |    NAME     |     ZONE      | STATUS |
      +----------------------+-------------+---------------+--------+
      | epd4sug6keskb72ub9m7 | first-group | {{ region-id }}-b | READY  |
      +----------------------+-------------+---------------+--------+
      ```

  1. Получите информацию о созданной группе:

      ```bash
      yc compute disk-placement-group get \
        --name first-group
      ```

      Результат:

      ```text
      id: epd4sug6keskb72ub9m7
      folder_id: w3qrbj9swotyns6oiyny
      created_at: "2021-03-23T12:49:59Z"
      name: first-group
      description: first disk placement group
      zone_id: {{ region-id }}-b
      status: READY
      spread_placement_strategy: {}
      ```

{% endlist %}
