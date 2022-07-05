# Изменить группу безопасности и правила

Функция находится на [стадии Preview](../../overview/concepts/launch-stages.md).

После создания группы безопасности вы можете изменить ее имя и описание, а также добавить или удалить правила.

Если вы добавили или удалили правила, не нужно перезагружать ВМ. Правила применятся сразу ко всем ресурсам, которым назначена группа.

## Изменить имя и описание {#update-name-and-description}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**. 
  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. Внесите изменения в имя и описание группы и нажмите кнопку **Сохранить**.

- CLI
  
  Чтобы изменить группу безопасности, выполните команду:

  ```
  yc vpc security-group update <идентификатор группы> --new-name test-sg-renamed
  ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
 
  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации Terraform и измените параметры `name` и `description` в описании группы безопасности:

     ```hcl
     ...
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "${yandex_vpc_network.lab-net.id}"
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/vpc_security_group).

     {% note info %}

	 Для управления [группой безопасности по умолчанию](../../vpc/concepts/security-groups#default-security-group) используйте ресурс [vpc_default_security_group]({{ tf-provider-link }}/vpc_default_security_group).

     {% endnote %}

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

## Добавить новое правило {#add-rule}

{% list tabs %}

- Консоль управления

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
        1. **CIDR** — правило будет применено к диапазону IP-адресов. В поле **CIDR блоки** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **Добавить CIDR**.
        1. **Группа безопасности** — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности. 
  1. Нажмите кнопку **Сохранить**. 

- CLI

  Чтобы добавить новое правило в существующую группу, укажите в команде ее идентификатор или имя и опишите новое правило:

  ```
  yc vpc security-group update-rules --name=test-sg-cli --add-rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24,10.10.0.0/24]"
  ```

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

## Удалить правило {#remove-rule}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **Группы безопасности**. 
  1. Выберите группу, которую требуется изменить.
  1. В блоке **Правила** нажмите значок ![image](../../_assets/options.svg) в строке правила, которое требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  Чтобы удалить правило из группы, укажите в команде его идентификатор:

  ```
  yc vpc security-group update-rules --name=test-sg-cli --delete-rule-id <идентификатор правила>
  ```

- Terraform

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить правило из группы безопасности, созданное с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите блок `ingress` или `egress` в описании группы безопасности:

     {% cut "Пример описания группы безопасности с правилами в конфигурации Terraform" %}

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
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.

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
