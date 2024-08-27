---
title: "Как получить информацию об источнике в {{ cdn-full-name }}"
---

# Получение информации об источниках

Вы можете узнать информацию об отдельном [источнике](#get-origin) или о [группе источников](#get-origin-group).

## Получение информации об источнике {#get-origin}

Чтобы получить URL и другую информацию об источнике:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится источник.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Выберите группу источников, в которой находится источник.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация об источнике.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об источнике:

      ```bash
      yc cdn origin get --help
      ```

  1. Получите информацию об источнике, указав его идентификатор или имя:
      
      ```bash
      yc cdn origin get <идентификатор_источника>
      ```

      Результат:

      ```text
      id: "152152********"
      origin_group_id: "2128********"
      source: test-cdn-1.{{ s3-storage-host }}
      enabled: true
      meta:
        bucket:
          name: test-cdn-1
      ```

- API {#api}

  Чтобы получить подробную информацию об источнике, воспользуйтесь методом REST API [get](../../api-ref/Origin/get.md) для ресурса [Origin](../../api-ref/Origin/index.md) или вызовом gRPC API [OriginService/Get](../../api-ref/grpc/origin_service.md#Get).

{% endlist %}

## Получение информации о группе источников {#get-origin-group}

Чтобы получить имя, состав группы и другую информацию о группе источников:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится группа источников.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Выберите группу источников.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о группе источников.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе источников:

      ```bash
      yc cdn origin-group get --help
      ```

  1. Получите информацию о группе источников, указав ее идентификатор или имя:
      
      ```bash
      yc cdn origin-group get <идентификатор_группы_источников>
      ```

      Результат:

      ```text
      id: "2149********"
      folder_id: b1ggmp8es27t********
      name: test-cdn-group
      use_next: true
      origins:
      - id: "2741********"
        origin_group_id: "2149********"
        source: test-cdn-1-2.{{ s3-storage-host }}
        enabled: true
        backup: true
        meta:
          bucket:
            name: test-cdn-1-2
      - id: "2742********"
        origin_group_id: "2149********"
        source: test-cdn-1-1.{{ s3-storage-host }}
        enabled: true
        meta:
          bucket:
            name: test-cdn-1-1
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_origin_group" "my_group" {
        origin_group_id = "<идентификатор_группы>"
      }

      output "my_group_origin" {
        value = "${data.yandex_cdn_origin_group.my_group.origin}"
      }
      ```

      Где:

      * `data "yandex_cdn_origin_group"` — описание группы источников в качестве источника данных:
        * `origin_group_id` — идентификатор группы источников.
      * `output "my_group_origin"` — выходная переменная, которая содержит информацию о группе источников:
        * `value` — возвращаемое значение. 

      Вместо `origin` вы можете выбрать любой другой параметр для получения информации. Более подробную информацию о параметрах источника данных `yandex_cdn_origin_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_cdn_origin_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      my_group_origin = toset([
        {
          "backup" = false
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-2"
        },
        {
          "backup" = true
          "enabled" = true
          "origin_group_id" = 2149********
          "source" = "test-cdn-1-1"
        },
      ])
      ```

- API {#api}

  Чтобы получить подробную информацию о группе источников, воспользуйтесь методом REST API [get](../../api-ref/OriginGroup/get.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Get](../../api-ref/grpc/origin_group_service.md#Get).

{% endlist %}
