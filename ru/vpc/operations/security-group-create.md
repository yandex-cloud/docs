---
title: Как создать группу безопасности
description: Следуя данной инструкции, вы сможете создать группу безопасности.
---

# Создать группу безопасности

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

Чтобы создать новую [группу безопасности](../concepts/security-groups.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать группу безопасности.
  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Введите имя группы безопасности.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, которой будет назначена группа безопасности.
  1. {% include [security-group-add-rule](../../_includes/vpc/security-group-add-rule.md) %}
  1. Повторно нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
  Чтобы создать группу с правилом для IPv4 CIDR, выполните команду:

  ```bash
  yc vpc security-group create \
    --name test-sg-cli \
    --description "My security group" \
    --rule "description=Allow HTTPS,direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24]" \
    --network-id c645mh47vscb********
  ```

  Где:

  * `--name` — имя группы безопасности.
  * `--description` — описание группы безопасности.
  * `--labels` — список меток группы безопасности в формате `ключ=значение`.
  * `--rule` — правило группы безопасности:
    * `description` — описание правила.
    * `direction` — направление трафика. `ingress` — входящий трафик, `egress` — исходящий.
    * `port` — порт для получения или передачи трафика. Также можно указать диапазон портов с помощью параметров `from-port` и `to-port`.
    * `protocol` — протокол передачи данных. Возможные значения: `any`, `tcp`, `udp`, `icmp` или [номер IP-протокола IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    * `v4-cidrs` — список CIDR IPv4 и масок подсетей, откуда или куда будет поступать трафик.
  * `--network-id` — идентификатор сети, к которой будет подключена группа безопасности.

  Чтобы создать группу с правилом, разрешающим трафик от всех ресурсов другой группы безопасности, выполните команду:

  ```bash
  yc vpc security-group create \
    --name allow-connection-from-app \
    --rule "direction=ingress,port=443,protocol=tcp,security-group-id=enp099cqehlf********" \
    --network-name infra2
  ```

  Где:

  * `--name` — имя группы безопасности.
  * `--rule` — правило группы безопасности:
    * `direction` — направление трафика. `ingress` — входящий трафик, `egress` — исходящий.
    * `port` — порт для получения или передачи трафика. Также можно указать диапазон портов с помощью параметров `from-port` и `to-port`.
    * `protocol` — протокол передачи данных. Возможные значения: `any`, `tcp`, `udp`, `icmp` или [номер IP-протокола IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
    * `security-group-id` — идентификатор группы безопасности, для которой разрешен трафик в сторону создаваемой группы безопасности по порту 443. Вместо идентификатора можно указать имя группы безопасности в параметре `security-group-name`.
    * `predefined` — предопределенная цель правила. Укажите вместо `security-group-id`, `security-group-name` или `v4-cidrs`. Возможные значения:
      * `self_security_group` — ресурсы, к которым применяется создаваемая группа безопасности. Подробнее о [правиле Self](../concepts/security-groups.md#self-rule).
      * `loadbalancer_healthchecks` — узлы проверки состояния балансировщиков нагрузки.
  * `--network-name` — имя сети, к которой будет подключена группа безопасности.

  Например, чтобы разрешить входящий трафик на порт `443` от ресурсов с создаваемой группой безопасности, используйте `predefined=self_security_group`:

  ```bash
  yc vpc security-group create \
    --name allow-connection-from-self \
    --rule "direction=ingress,port=443,protocol=tcp,predefined=self_security_group" \
    --network-name infra2
  ```

  Также поддерживается параметр `--async` — вывод информации о выполняемой операции без ожидания ее завершения.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать группу безопасности с несколькими правилами: 
    
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя группы безопасности.
     * `description` — опциональное описание группы безопасности.
     * `network_id` — идентификатор сети, которой будет назначена группа безопасности.
     * `ingress` и `egress` — параметры правил для входящего и исходящего трафика:
       * `protocol` — протокол передачи трафика. Возможные значения: `tcp`, `udp`, `icmp`, `esp`, `ah`, `any`.
       * `description` — опциональное описание правила.
       * `v4_cidr_blocks` — список CIDR и масок подсетей, откуда или куда будет поступать трафик.
       * `port` — порт для трафика.
       * `from-port` — первый порт из диапазона портов для трафика.
       * `to-port` — последний порт из диапазона портов для трафика.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "<идентификатор_сети>"

       egress {
         protocol       = "ANY"
         description    = "Rule description 2"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         from_port      = 8090
         to_port        = 8099
       }

       ingress {
         protocol       = "TCP"
         description    = "Rule description 1"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         port           = 8080
       }

       ingress {
         protocol          = "ANY"
         description       = "Разрешает взаимодействие между ресурсами текущей группы безопасности"
         predefined_target = "self_security_group"
         from_port         = 0
         to_port           = 65535
       }

       ingress {
         protocol = "TCP"
         description       = "Разрешает подключение по порту 27017 со стороны ресурсов с группой безопасности sg-frontend"
         security_group_id = yandex_vpc_security_group.sg-frontend.id
         port = 27017
       }
     }
     ```

     Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, в [документации провайдера]({{ tf-provider-link }}).
     
  1. Примените конфигурацию:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../api-ref/grpc/SecurityGroup/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена группа безопасности, в параметре `folderId`.
  * Имя группы безопасности в параметре `name`.
  * Описание группы безопасности в параметре `description`.
  * Метки группы безопасности в виде пар `ключ:значение` в параметре `labels`.
  * Идентификатор сети, в которой будет размещена группа безопасности, в параметре `networkId`.
  * Настройки правил группы безопасности в массиве `ruleSpecs[]`:

    * Описание правила в параметре `ruleSpecs[].description`.
    * Метки правила в виде пар `ключ:значение` в параметре `ruleSpecs[].labels`.
    * Направление трафика, для которого задается правило, в параметре `ruleSpecs[].direction`. Возможные значения:

      * `ingress` — входящий трафик;
      * `egress` — исходящий трафик.

    * Имя протокола передачи трафика в параметре `ruleSpecs[].protocolName` или номер протокола по [реестру IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml) в параметре `ruleSpecs[].protocolNumber`. Одновременно можно передать только один из этих параметров.
    * Целевые ресурсы правила — передайте только один из следующих параметров:

      * Список CIDR IPv4 и масок подсетей, откуда или куда будет поступать трафик, в параметре `ruleSpecs[].cidrBlocks.v4CidrBlocks[]`.
      * Идентификатор группы безопасности, для ресурсов которой применяется правило, в параметре `ruleSpecs[].securityGroupId`.
      * Предопределенную цель правила в параметре `ruleSpecs[].predefinedTarget`. Возможные значения:
        * `self_security_group` — ресурсы, к которым применяется создаваемая группа безопасности. Подробнее о [правиле Self](../concepts/security-groups.md#self-rule).
        * `loadbalancer_healthchecks` — узлы проверки состояния балансировщиков нагрузки.

    * Первый порт из диапазона портов для трафика в параметре `ruleSpecs[].ports.fromPort`. Возможные значения: от `0` до `65535`.
    * Последний порт из диапазона портов для трафика в параметре `ruleSpecs[].ports.toPort`. Возможные значения: от `0` до `65535`.

{% endlist %}
