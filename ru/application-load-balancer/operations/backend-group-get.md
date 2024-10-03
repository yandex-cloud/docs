---
title: Как получить информацию о группе бэкендов в {{ alb-full-name }}
---

# Получить информацию о группе бэкендов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится [группа бэкендов](../concepts/backend-group.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Выберите группу бэкендов.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о группе.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [группе бэкендов](../concepts/backend-group.md):

      ```bash
      yc alb backend-group get --help
      ```

  1. Получите информацию о группе бэкендов, указав ее имя или идентификатор:

      ```bash
      yc alb backend-group get <имя_группы_бэкендов>
      ```

      Результат:

      ```text
      id: ds7maho6c4or********
      name: alb-bg
      folder_id: b1geoelk7fld********
      http:
        backends:
          - name: backend-1
            backend_weight: "1"
            port: "80"
            target_groups:
              target_group_ids:
                - ds7cjrs15ero********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthcheck_port: "80"
                http:
                  path: /
      created_at: "2023-10-24T12:22:20.870326850Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [группе бэкендов](../concepts/backend-group.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_alb_backend_group" "my_bg" {
        backend_group_id = "<идентификатор_группы_бэкендов>"
      }

      output "backend_group" {
        value = data.yandex_alb_backend_group.my_bg.http_backend
      }
      ```

      Где:
      * `data "yandex_alb_backend_group"` — описание группы бэкендов в качестве источника данных:
        * `backend_group_id` — идентификатор группы бэкендов.
      * `output "backend_group"` — выходная переменная, которая содержит информацию о подключенном HTTP бэкенде:
        * `value` — возвращаемое значение.

      Вместо `http_backend` вы можете выбрать любой другой параметр для получения информации. Более подробную информацию о параметрах источника данных `yandex_alb_backend_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_alb_backend_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      backend_group = tolist([
        {
          "healthcheck" = tolist([
            {
              "grpc_healthcheck" = tolist([])
              "healthcheck_port" = 80
              "healthy_threshold" = 1
              "http_healthcheck" = tolist([
                {
                  "host" = ""
                  "http2" = false
                  "path" = "/health"
                },
              ])
              "interval" = "1s"
              "interval_jitter_percent" = 0
              "stream_healthcheck" = tolist([])
              "timeout" = "1s"
              "unhealthy_threshold" = 1
            },
            ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [группе бэкендов](../concepts/backend-group.md), воспользуйтесь методом REST API [get](../api-ref/BackendGroup/get.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Get](../api-ref/grpc/backend_group_service.md#Get).

{% endlist %}
