---
title: "Как получить информацию о целевой группе в {{ alb-full-name }}"
---

# Получить информацию о целевой группе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится [целевая группа](../concepts/target-group.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Выберите целевую группу.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о группе.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [целевой группе](../concepts/target-group.md):

      ```bash
      yc alb target-group get --help
      ```

  1. Получите информацию о целевой группе, указав ее идентификатор или имя:

      ```bash
      yc alb target-group get <имя_целевой_группы>
      ```

      Результат:

      ```text
      id: ds7cjrs15ero********
      name: alb-tg
      folder_id: b1geoelk7fld********
      targets:
        - ip_address: 192.168.3.34
          subnet_id: b0cqh32phmc1********
        - ip_address: 192.168.2.4
          subnet_id: e2ltekraekpc********
        - ip_address: 192.168.1.10
          subnet_id: e9bns2fv233c********
      created_at: "2023-10-24T12:21:09.159841076Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [целевой группе](../concepts/target-group.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_alb_target_group" "my_tg" {
        target_group_id = "<идентификатор_целевой_группы>"
      }

      output "target_group" {
        value = data.yandex_alb_target_group.my_tg.target
      }
      ```

      Где:

      * `data "yandex_alb_target_group"` — описание целевой группы в качестве источника данных:
        * `target_group_id` — идентификатор целевой группы.
      * `output "target_group"` — выходная переменная, которая содержит информацию о подключенных ресурсах целевой группы:
        * `value` — возвращаемое значение.

      Вместо `target` вы можете выбрать любой другой параметр для получения информации. Более подробную информацию о параметрах источника данных `yandex_alb_target_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_alb_target_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      target_group = tolist([
        {
          "ip_address" = "10.129.0.29"
          "private_ipv4_address" = false
          "subnet_id" = "e2lfebujacgf********"
        },
      ])
      ```

- API {#api}

  Чтобы получить подробную информацию о [целевой группе](../concepts/target-group.md), воспользуйтесь методом REST API [get](../api-ref/TargetGroup/get.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Get](../api-ref/grpc/target_group_service.md#Get).

{% endlist %}
