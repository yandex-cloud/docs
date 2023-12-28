---
title: "Как создать группу источников в {{ cdn-full-name }}"
description: "Следуя данной инструкции, вы сможете создать группу источников." 
---

# Создание группы источников

Чтобы создать [группу источников](../../concepts/origins.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
  1. Введите название группы.
  1. Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:

     * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
     * Укажите источник.
     * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` или `{{ ui-key.yacloud.cdn.value_backup }}`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
     * Добавьте другие источники, если необходимо.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы источников:

     ```
     yc cdn origin-group create --help
     ```

  1. Создайте группу источников в каталоге по умолчанию:

     ```
     yc cdn origin-group create --name <имя_группы> \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true,backup=true
     ```

     Где `--origin` — спецификация источника:
     * `source` — IP-адрес или доменное имя источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Результат:

     ```
     id: "89018"
     folder_id: b1g86q4m5vej********
     name: test-group
     use_next: true
     origins:
     - id: "559295"
       origin_group_id: "89018"
       source: www.example2.com
       enabled: true
       backup: true
     - id: "559294"
       origin_group_id: "89018"
       source: www.example1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/create.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_origin_group`:

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_cdn_origin_group" "my_group" {
       name = "<имя_группы>"
       use_next = true
       origin {
        source = "<IP-адрес_или_доменное_имя_источника_1>"
       }
       origin {
        source = "<IP-адрес_или_доменное_имя_источника_2>"
       }
       origin {
        source = "<IP-адрес_или_доменное_имя_источника_3>"
        backup = false
       }
     }
     ```

     Где:

     * `name` — имя группы источников.
     * `use_next` — указывает, использовать ли следующий источник из списка.
     * `origin` — спецификация источника:
       * `source` — IP-адрес или доменное имя источника.
       * `enabled` — флаг, указывающий, включен ли источник.
       * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc cdn origin-group list
     ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/OriginGroup/create.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Create](../../api-ref/grpc/origin_group_service.md#Create).

{% endlist %}
