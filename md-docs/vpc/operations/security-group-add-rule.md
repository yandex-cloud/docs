# Добавить новое правило в группу безопасности

Если вы добавили или удалили [правила](../concepts/security-groups.md#security-groups-structure), не нужно перезагружать [ВМ](../../glossary/vm.md). Правила применятся сразу ко всем ресурсам, которым назначена группа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить правило:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется изменить [группу безопасности](../concepts/security-groups.md).

  1. Перейдите в сервис **Virtual Private Cloud**.

  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности**.

  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке группы, в которой требуется добавить правило, и выберите **Редактировать**.

  1. В блоке **Правила** создайте правила для управления трафиком:

     1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.

     1. Нажмите кнопку **Добавить правило**.

     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.

     1. В поле **Протокол** укажите нужный протокол или оставьте `Любой`, чтобы разрешить передачу трафика по всем протоколам.

     1. В поле **Назначение** или **Источник** выберите назначение правила:

        * `CIDR` — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.

        * `Группа безопасности`. Выберите вариант:

           * `Текущая` — правило будет применено к ВМ из текущей группы.
           * `Из списка` — правило будет применено к ВМ из выбранной группы. IP-адреса источника или назначения при обмене трафиком должны быть из [частных диапазонов](../concepts/network.md#subnet). Подробнее в разделе [Концепции](../concepts/security-groups.md#groups).

        * `Проверки состояния балансировщика` — правило, разрешающее проверки состояния ресурсов от [Network Load Balancer](../../network-load-balancer/concepts/health-check.md) или [Application Load Balancer](../../application-load-balancer/concepts/backend-group.md#health-checks).

  1. Нажмите кнопку **Сохранить**.

  1. Повторно нажмите **Сохранить**.

- CLI {#cli}

  Чтобы добавить правило в существующую [группу](../concepts/security-groups.md):

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  1. Откройте файл конфигурации Terraform и добавьте блок `ingress` или `egress` в описании [группы безопасности](../concepts/security-groups.md):

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

     Подробнее о параметрах ресурса `yandex_vpc_security_group` в Terraform в [документации провайдера](../../terraform/resources/vpc_security_group.md).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

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

     Подробнее о параметрах ресурса `yandex_vpc_security_group_rule` в Terraform в [документации провайдера](../../terraform/resources/vpc_security_group_rule.md).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение группы безопасности можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group get <имя_группы_безопасности>
     ```

- API {#api}

  Чтобы добавить правило, воспользуйтесь методом REST API [updateRules](../api-ref/SecurityGroup/updateRules.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/UpdateRules](../api-ref/grpc/SecurityGroup/updateRules.md) и передайте в запросе:

  * Идентификатор [группы безопасности](../concepts/security-groups.md), в которую будут добавлены правила, в параметре `securityGroupId`.

    Чтобы узнать идентификатор группы безопасности, воспользуйтесь методом REST API [list](../api-ref/SecurityGroup/list.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/List](../api-ref/grpc/SecurityGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

  * Новые правила группы безопасности в массиве `additionRuleSpecs[]`:

    * Направление трафика, для которого задается правило, в параметре `additionRuleSpecs[].direction`. Возможные значения:

      * `ingress` — входящий трафик;
      * `egress` — исходящий трафик.

    * Имя протокола передачи трафика в параметре `additionRuleSpecs[].protocolName`. Возможные значения: `tcp`, `udp`, `icmp`, `esp`, `ah`, `any`.
    * Список CIDR и масок подсетей, откуда или куда будет поступать трафик, в параметре `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]`. Если правило задается для передачи трафика в группу безопасности, то вместо этого передайте идентификатор группы безопасности в параметре `additionRuleSpecs[].securityGroupId`.
    * Первый порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.fromPort`. Возможные значения: от `0` до `65535`.
    * Последний порт из диапазона портов для трафика в параметре `additionRuleSpecs[].ports.toPort`. Возможные значения: от `0` до `65535`.

{% endlist %}