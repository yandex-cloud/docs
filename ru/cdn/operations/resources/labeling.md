---
title: Управление метками CDN-ресурса в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете управлять метками CDN-ресурса в {{ cdn-name }}.
---

# Управление метками ресурса

[Метки CDN-ресурсов](../../concepts/labels.md) — это пары ключ-значение для логической маркировки CDN-ресурсов.

## Добавить или изменить метки {#add-edit-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. В строке с нужным CDN-ресурсом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** найдите поле **{{ ui-key.yacloud_billing.component.label-set.label_labels }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите метку в формате `ключ: значение`. Чтобы изменить существующую метку, введите ее ключ и новое значение.
  1. Нажмите **Enter**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек CDN-ресурса:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список CDN-ресурсов в каталоге по умолчанию:

      ```bash
      yc cdn resource list
      ```

      Результат:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Добавьте метки, указав имя нужного CDN-ресурса:

      ```bash
      yc cdn resource update <идентификатор_CDN-ресурса> \
        --add-labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n>
      ```

      Где `--add-labels` — параметр для перечисления меток CDN-ресурса в формате `ключ=значение`.

      Результат:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

{% endlist %}

## Посмотреть метки {#get-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Перейдите в нужный CDN-ресурс.
  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** найдите поле **{{ ui-key.yacloud_billing.component.label-set.label_labels }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек CDN-ресурса:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список CDN-ресурсов в каталоге по умолчанию:

      ```bash
      yc cdn resource list
      ```

      Результат:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Получите информацию о метках, указав имя нужного CDN-ресурса:

      ```bash
      yc cdn resource get <идентификатор_CDN-ресурса>
      ```

      Результат:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

{% endlist %}

## Удалить метки {#delete-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. В строке с нужным CDN-ресурсом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** найдите поле **{{ ui-key.yacloud_billing.component.label-set.label_labels }}**.
  1. Напротив нужной метки нажмите значок ![image](../../../_assets/console-icons/xmark.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек CDN-ресурса:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список CDN-ресурсов в каталоге по умолчанию:

      ```bash
      yc cdn resource list
      ```

      Результат:

      ```text
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      |          ID          |  CNAME  |           CREATED AT           |           UPDATED AT           | ACTIVE |                         OPTIONS                         |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      | bc8jhcx5o47p******** | ****.ru | seconds:1734615244             | seconds:1734615244             | false  | edge_cache_settings:{enabled:true                       |
      |                      |         | nanos:439618000                | nanos:439638000                |        |  default_value:345600}                                  |
      |                      |         |                                |                                |        | query_params_options:{ignore_query_string:{enabled:true |
      |                      |         |                                |                                |        |  value:true}}  stale:{enabled:true  value:"error"       |
      |                      |         |                                |                                |        | value:"updating"}                                       |
      +----------------------+---------+--------------------------------+--------------------------------+--------+---------------------------------------------------------+
      ```

  1. Удалите метки, указав имя нужного CDN-ресурса:

      ```bash
      yc cdn resource update <идентификатор_CDN-ресурса> \
        --remove-labels <ключ_метки_1>,<ключ_метки_2>,...,<ключ_метки_n>
      ```

      Где `--remove-labels` — параметр для перечисления ключей меток CDN-ресурса.

      Результат:

      ```text
      id: bc8jhcx5o47p********
      folder_id: b1g681qpemb4********
      cname: ****.ru
      ...
      labels:
        key2: value2
        key3: value3
        key4: value4
      ```

      Чтобы удалить все метки, используйте флаг `--remove-all-labels`:

      ```bash
      yc cdn resource update <идентификатор_CDN-ресурса> \
        --remove-all-labels
      ```

{% endlist %}
