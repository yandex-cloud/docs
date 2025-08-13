---
title: Как получить информацию о ресурсе в {{ cdn-full-name }}
---

# Получение информации о ресурсе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [ресурс](../../concepts/resource.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите CDN-ресурс.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о ресурсе.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [ресурсе](../../concepts/resource.md):

      ```bash
      yc cdn resource get --help
      ```

  1. Получите информацию о ресурсе, указав его идентификатор или имя:
      
      ```bash
      yc cdn resource get <идентификатор_ресурса>
      ```

      Результат:

      ```text
      id: bc8v43fzihmv********
      folder_id: b1ggmp8es27t********
      cname: cdn-res-group.test.com
      created_at: "2023-10-25T11:18:13.630839Z"
      updated_at: "2023-10-25T11:18:13.630858Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        stale:
          enabled: true
          value:
          - error
          - updating
      origin_group_id: "27272********"
      origin_group_name: test-cdn-group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [ресурсе](../../concepts/resource.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<идентификатор_ресурса>"
      }

      output "resource_active" {
        value = data.yandex_cdn_resource.my_resource.active
      }
      ```

      Где:

      * `data "yandex_cdn_resource"` — описание CDN-ресурса в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "resource_active"` — выходная переменная, которая содержит информацию о статусе активности CDN-ресурса:
         * `value` — возвращаемое значение.

     Вместо `active` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_cdn_resource` см. в [документации провайдера]({{ tf-provider-datasources-link }}/cdn_resource).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      resource_active = true
      ```

- API {#api}

  Чтобы получить подробную информацию о [ресурсе](../../concepts/resource.md), воспользуйтесь методом REST API [get](../../api-ref/Resource/get.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Get](../../api-ref/grpc/Resource/get.md).

{% endlist %}

## Получение доменного имени {{ cdn-name }} провайдера {#get-cname}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится ресурс.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Выберите созданный CDN-ресурс.
  1. На странице **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** отобразится доменное имя вида `{{ cname-example-yc }}` или `{{ cname-example-edge }}`в зависимости от используемого [провайдера CDN](../../concepts/providers.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о ресурсе с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_cdn_resource" "my_resource" {
        resource_id = "<идентификатор_ресурса>"
      }

      output "provider_cname" {
        value = data.yandex_cdn_resource.my_resource.provider_cname
      }
      ```

      Где:

      * `data "yandex_cdn_resource"` — описание CDN-ресурса в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "provider_cname"` — выходная переменная, которая содержит информацию о доменном имени:
         * `value` — возвращаемое значение.

     Вместо `provider_cname` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_cdn_resource` см. в [документации провайдера]({{ tf-provider-datasources-link }}/cdn_resource).

  1. Получите информацию о ресурсах:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      provider_cname = "{{ cname-example-yc }}"
      ```

{% endlist %}
