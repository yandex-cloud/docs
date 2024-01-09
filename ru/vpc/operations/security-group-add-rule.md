---
title: "Добавить новое правило в группу безопасности {{ vpc-full-name }}"
description: "Добавлять правила можно через консоль управления, CLI и API {{ vpc-name }}. Если вы добавили или удалили правила, не нужно перезагружать ВМ. Правила применятся сразу ко всем ресурсам, которым назначена группа."
---

# Добавить новое правило в группу безопасности

Если вы добавили или удалили правила, не нужно перезагружать [ВМ](../../glossary/vm.md). Правила применятся сразу ко всем ресурсам, которым назначена группа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить правило:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.

  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.

  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы, в которой требуется добавить правило, и выберите **{{ ui-key.yacloud.common.edit }}**.

  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте правила для управления трафиком:

     1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.

     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.

     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.

     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.

     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:

        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}**.

        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`. Выберите вариант:

           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` — правило будет применено к ВМ из текущей группы.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}` — правило будет применено к ВМ из выбранной группы. IP-адреса источника или назначения при обмене трафиком должны быть из [частных диапазонов](../concepts/network.md#subnet). Подробнее см. в разделе [Концепции](../concepts/security-groups.md#groups).

        * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, разрешающее проверки состояния ресурсов от [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) или [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. Повторно нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Чтобы добавить правило в существующую группу:

  1. Узнайте имя или идентификатор группы, которую требуется изменить:

     ```
     yc vpc security-groups list
     ```
     Результат:
     ```
     +----------------------+---------------------------------+------------------------------------+----------------------+
     |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     | enp9bmjge93b******** | default-sg-enp509crtquf******** | Default security group for network | enp509crtquf******** |
     | enp9rs9u4h6j******** | sg-1                            |                                    | enp509crtquf******** |
     | enp9d8m73d1c******** | sg-2                            |                                    | enp509crtquf******** |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     ```

  1. Добавьте правило с помощью команды `update-rules` и параметра `--add-rule`:

     ```
     yc vpc security-group update-rules <имя_или_идентификатор_группы> --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
     ```
     Результат:
     ```
     done (12s)
     id: enp9rs9i4h9j********
     folder_id: b1gau98l79li********
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9q9f********
     status: ACTIVE
     rules:
       - id: enp68o6cdi87********
         direction: INGRESS
         ports:
           from_port: "443"
           to_port: "443"
         protocol_name: TCP
         protocol_number: "6"
         cidr_blocks:
           v4_cidr_blocks:
             - 10.0.0.0/24
             - 10.10.0.0/24
          ...
     ```

     {% note info %}

     Вы можете использовать `predefined=self_security_group` что бы задействовать правило на машины внутри изменяемой группы безопасности.

     Подробнее о правиле `Self` читайте в [видах правил групп безопасности](../concepts/security-groups.md#rules-types).

     {% endnote %}

     Чтобы получить справку о параметре `--add-rule`, выполните команду `yc vpc security-group update-rules --help`.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `ingress` или `egress` в описании группы безопасности:

     ```hcl
     ...
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "${yandex_vpc_network.lab-net.id}"

       ingress {
         protocol       = "TCP"
         description    = "Rule description 1"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         port           = 8080
       }

       egress {
         protocol       = "ANY"
         description    = "Rule description 2"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         from_port      = 8090
         to_port        = 8099
       }
	   
	   egress {
         protocol       = "UDP"
         description    = "rule3 description"
         v4_cidr_blocks = ["10.0.1.0/24"]
         from_port      = 8090
         to_port        = 8099
       }
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_security_group).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group get <имя_группы_безопасности>
     ```

  ### Добавить новое правило с помощью ресурса yandex_vpc_security_group_rule {#add-rule-with-yandex-vpc-security-group-rule}

  Вы также можете добавить новое правило в существующую группу безопасности, используя ресурс `yandex_vpc_security_group_rule`.

     {% note warning %}

     Оба способа равнозначны, но несовместимы друг с другом: одновременное использование ресурсов `yandex_vpc_security_group_rule` и `yandex_vpc_security_group` приведет к конфликту конфигурации правил.

     {% endnote %}

  1. Опишите в конфигурационном файле следующие параметры:

     * `security_group_binding` — идентификатор группы безопасности.
     * `direction` — входящий или исходящий трафик. Возможные значения: `ingress` или `egress`.
     * `description` — описание правила.
     * `v4_cidr_blocks` — список CIDR и масок подсетей, откуда или куда будет поступать трафик.
     * `port` — порт для трафика.
     * `from_port` — первый порт из диапазона портов для трафика.
     * `to_port` — последний порт из диапазона портов для трафика.
     * `protocol` — протокол передачи трафика. Возможные значения: `TCP`, `UDP`, `ICMP`, `ANY`.

     ```hcl
     ...
     resource "yandex_vpc_security_group_rule" "rule1" {
       security_group_binding = <идентификатор_группы_безопасности>
       direction              = "ingress"
       description            = "<описание_правила>"
       v4_cidr_blocks         = ["10.0.1.0/24", "10.0.2.0/24"]
       port                   = 8080
       protocol               = "TCP"
     }

     resource "yandex_vpc_security_group_rule" "rule2" {
       security_group_binding = yandex_vpc_security_group.group1.id
       direction              = "egress"
       description            = "rule2 description"
       v4_cidr_blocks         = ["10.0.1.0/24"]
       from_port              = 8090
       to_port                = 8099
       protocol               = "UDP"
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group_rule` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/resources/vpc_security_group_rule).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group get <имя_группы_безопасности>
     ```

- API {#api}

  Чтобы добавить правило, воспользуйтесь методом REST API [updateRules](../api-ref/SecurityGroup/updateRules.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/UpdateRules](../api-ref/grpc/security_group_service.md#UpdateRules) и передайте в запросе:

  * Идентификатор группы безопасности, в которую будут добавлены правила, в параметре `securityGroupId`.

    {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Новые правила группы безопасности в массиве `additionRuleSpecs[]`:

    * Направление трафика, для которого задается правило, в параметре `additionRuleSpecs[].direction`. Возможные значения:

      * `ingress` — входящий трафик;
      * `egress` — исходящий трафик.

    * Имя протокола передачи трафика в параметре `additionRuleSpecs[].protocolName`. Возможные значения: `tcp`, `udp`, `icmp`, `esp`, `ah`, `any`.
    * Список CIDR и масок подсетей, откуда или куда будет поступать трафик, в параметре `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]`. Если правило задается для передачи трафика в группу безопасности, то вместо этого передайте идентификатор группы безопасности в параметре `additionRuleSpecs[].securityGroupId`.
    * Первый порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.fromPort`. Возможные значения: от `0` до `65535`.
    * Последний порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.toPort`. Возможные значения: от `0` до `65535`.

{% endlist %}
