---
title: Как создать группу источников в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете создать группу источников.
---

# Создание группы источников

Чтобы создать [группу источников](../../concepts/origins.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать группу источников.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_origins-group-create }}**.
  1. Введите название группы источников.
  1. Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
     * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
     * Укажите источник.
     * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.value_active }}` или `{{ ui-key.yacloud.cdn.value_backup }}`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
     * Добавьте другие источники, если необходимо.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Если вы создаете первую группу источников, сначала подключитесь к провайдеру:

     ```bash
     yc cdn provider activate --type gcore
     ```

  1. Посмотрите описание команды [CLI](../../../cli/) для создания группы источников:

     ```bash
     yc cdn origin-group create --help
     ```

  1. Создайте группу источников в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc cdn origin-group create --name <имя_группы_источников> \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true \
       --origin source=<IP-адрес_или_доменное_имя_источника>,enabled=true,backup=true
     ```

     Где `--origin` — спецификация [источника](../../concepts/resource.md):
     * `source` — [IP-адрес](../../../vpc/concepts/address.md) или доменное имя источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Результат:

     ```text
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

- {{ TF }} {#tf}

  Провайдер CDN должен быть активирован до создания группы источников. Сделать это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc cdn provider activate \
    --folder-id <идентификатор_каталога> \
    --type gcore
  ```

  Где:
  * `--folder-id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором вы хотите активировать провайдера CDN.
  * `--type` — тип провайдера: единственное возможное значение — `gcore`.

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_origin_group`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_cdn_origin_group" "my_group" {
       name = "<имя_группы_источников>"
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
     * `use_next` — указывает, использовать ли следующий [источник](../../concepts/resource.md) из списка.
     * `origin` — спецификация источника:
       * `source` — [IP-адрес](../../../vpc/concepts/address.md) или доменное имя источника.
       * `enabled` — флаг, указывающий, включен ли источник.
       * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc cdn origin-group list
     ```

- API {#api}

  Если вы создаете первую группу источников, подключитесь к провайдеру CDN. Для этого воспользуйтесь методом REST API [activate](../../api-ref/Provider/activate.md) для ресурса [Provider](../../api-ref/Provider/index.md) или вызовом gRPC API [ProviderService/Activate](../../api-ref/grpc/Provider/activate.md).

  Воспользуйтесь методом REST API [create](../../api-ref/OriginGroup/create.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Create](../../api-ref/grpc/OriginGroup/create.md).

{% endlist %}