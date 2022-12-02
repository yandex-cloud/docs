# Добавить новое правило

Если вы добавили или удалили правила, не нужно перезагружать ВМ. Правила применятся сразу ко всем ресурсам, которым назначена группа.

{% include [Preview](../../_includes/vpc/preview.md) %}

{% list tabs %}

- Консоль управления

  Чтобы добавить правило:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.

  1. В списке сервисов выберите **{{ vpc-name }}**.

  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**.

  1. Выберите группу, которую требуется изменить.

  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы.

  1. В открывшемся меню нажмите кнопку **Редактировать**.

  1. В блоке **Правила** создайте правила для управления трафиком:

     1. Выберите вкладку **Исходящий трафик** или **Входящий трафик**.

     1. Нажмите кнопку **Добавить правило**.

     1. В открывшемся окне в поле **Диапазон портов** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.

     1. В поле **Протокол** укажите нужный протокол или оставьте **Любой**, чтобы разрешить передачу трафика по всем протоколам.

     1. В поле **Назначение** или **Источник** выберите назначение правила:

        * **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.

        * **Группа безопасности**. Выберите вариант:

           * **Текущая** (`Self`) — правило будет применено к ВМ из текущей группы.
           * **Из списка** — правило будет применено к ВМ из выбранной группы. IP-адреса источника или назначения при обмене трафиком должны быть из [частных диапазонов](../concepts/network.md#subnet). Подробнее см. в разделе [Концепции](../concepts/security-groups.md#groups).

        * **Проверки состояния балансировщика** — правило, разрешающее проверки состояния ресурсов от [{{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md) или [{{ alb-name }}](../../application-load-balancer/concepts/backend-group.md#health-checks).

  1. Нажмите кнопку **Сохранить**.

  1. Повторно нажмите **Сохранить**.

- CLI

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
     | enp9bmjge93bvnlb4061 | default-sg-enp509crtqufsuhm9kbr | Default security group for network | enp509crtqufsuhm9kbr |
     | enp9rs9u4h6juk9rq3k5 | sg-1                            |                                    | enp509crtqufsuhm9kbr |
     | enp9d8m73d1cgh2rm179 | sg-2                            |                                    | enp509crtqufsuhm9kbr |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     ```

  1. Добавьте правило с помощью команды `update-rules` и параметра `--add-rule`:

     ```
     yc vpc security-group update-rules <имя или идентификатор группы> --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
     ```
     Результат:
     ```
     done (12s)
     id: enp9rs9i4h9juk9rq3k5
     folder_id: b1gau98l79li5n96eabd
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9q9fsuhm9kbr
     status: ACTIVE
     rules:
       - id: enp68o6cdi872ftdu4vp
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

- Terraform

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации Terraform и добавьте блок `ingress` или `egress` в описании группы безопасности:

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

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/vpc_security_group).

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

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group get <имя группы безопасности>
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
       security_group_binding = <идентификатор группы безопасности>
       direction              = "ingress"
       description            = "<описание правила>"
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

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group_rule` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/resources/vpc_security_group_rule).

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

     Проверить изменение группы безопасности можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group get <имя группы безопасности>
     ```

{% endlist %}

