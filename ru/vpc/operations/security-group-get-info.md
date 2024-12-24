---
title: Как получить информацию о группе безопасности в {{ vpc-full-name }}
---

# Получить информацию о группе безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [группа безопасности](../concepts/security-groups.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Выберите нужную группу безопасности.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о группе безопасности.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для получения информации о [группе безопасности](../concepts/security-groups.md):

     ```bash
     yc vpc security-group get --help
     ```

  1. Получите информацию о группе безопасности, указав ее имя или идентификатор:

     ```bash
     yc vpc security-group get <имя_группы_безопасности>
     ```

     Результат:

     ```text
     id: enplgn3uok7u********
     folder_id: b1go3el0d8fs********
     created_at: "2023-03-24T11:56:01Z"
     name: default-sg-enpols3n07b8********
     description: Default security group for network
     network_id: enpols3n07b8********
     status: ACTIVE
     default_for_network: true
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [группе безопасности](../concepts/security-groups.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_security_group" "group1" {
       security_group_id = "<идентификатор_группы_безопасности>"
     }

     output "group" {
       value = data.yandex_vpc_security_group.group1.ingress
     }
     ```

     Где:
     * `data "yandex_vpc_security_group"` — описание группы безопасности в качестве источника данных:
       * `security_group_id` — идентификатор группы безопасности.
     * `output "group"` — выходная переменная, которая содержит информацию о правилах входящего трафика:
       * `value` — возвращаемое значение.

     Вместо `ingress` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_security_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_security_group).    

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     group = toset([
       {
         "description" = ""
         "from_port" = -1
         "id" = "enpt1jlfgv3e*********"
         "labels" = tomap({})
         "port" = 8000
         "predefined_target" = "self_security_group"
         "protocol" = "ANY"
         "security_group_id" = ""
         "to_port" = -1
         "v4_cidr_blocks" = tolist([])
         "v6_cidr_blocks" = tolist([])
       },
     ])
     ```

- API {#api}

  Чтобы получить подробную информацию о [группе безопасности](../concepts/security-groups.md), воспользуйтесь методом REST API [get](../api-ref/SecurityGroup/get) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md), или вызовом gRPC API [SecurityGroupService/Get](../api-ref/grpc/SecurityGroup/get.md).

{% endlist %}

## Получить информацию о правиле группы безопасности {#rule}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [правиле группы безопасности](../concepts/security-groups.md#security-groups-structure) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_security_group_rule" "rule1" {
       security_group_binding = "<идентификатор_группы_безопасности>"
       rule_id                = "<идентификатор_правила>"
     }

     output "rule" {
       value = data.yandex_vpc_security_group_rule.rule1.direction
     }
     ```

     Где:
     * `data "yandex_vpc_security_group_rule"` — описание правила группы безопасности в качестве источника данных:
       * `security_group_binding` — идентификатор группы безопасности, которая содержит правило.
       * `rule_id` — идентификатор правила.
     * `output "rule"` — выходная переменная, которая содержит информацию о направлении правила:
       * `value` — возвращаемое значение.

     Вместо `direction` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `datasource_vpc_security_group_rule` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_security_group_rule).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     rule = "ingress"
     ```

{% endlist %}
