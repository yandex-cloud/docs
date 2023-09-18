# Удалить правило из группы безопасности

{% list tabs %}

- Консоль управления

  Чтобы удалить правило из группы безопасности:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы, в которой требуется удалить правило, и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** нажмите значок ![image](../../_assets/options.svg) в строке правила, которое требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  Чтобы удалить правило из группы:

  1. Узнайте имя или идентификатор группы, которую требуется изменить:

     ```
     yc vpc security-groups list
     ```
     Результат:
     ```
     +----------------------+---------------------------------+------------------------------------+----------------------+
     |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     | enp9bmjge93bvnlb4061 | default-sg-enp509crtqufsu9m9kbr | Default security group for network | enp509crtqufsuhm9kbr |
     | enp9rs9u4h6juk9rq3k5 | sg-1                            |                                    | enp509crtqufsuhm9kbr |
     | enp9d8m73d1cgh2rm179 | sg-2                            |                                    | enp509crtqufsuhm9kbr |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     ```
  1. Получите список правил в группе безопасности, указав ее имя или идентификатор:

     ```
     yc vpc security-groups get <имя или идентификатор группы>
     ```
     Результат:
     ```
     id: enp8rs9i4h6juk9rl3k5
     folder_id: b1gaus8l79li5979eabd
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9qufsuhm9kbr
     status: ACTIVE
     rules:
       - id: enpbbmv8icie959gcm84
         description: SSH
         direction: INGRESS
         ports:
           from_port: "22"
           to_port: "22"
         protocol_name: TCP
         protocol_number: "6"
         cidr_blocks:
           v4_cidr_blocks:
             - 0.0.0.0/0
     ...
     ```

  1. Чтобы удалить правило, укажите в команде его идентификатор:

     ```
     yc vpc security-group update-rules <имя или идентификатор группы> --delete-rule-id <идентификатор правила>
     ```
     Результат:
     ```
     done (12s)
     id: enp8rs9i4h6juk9rq3k5
     folder_id: b1gaus8l79li5n96eabd
     created_at: "2022-06-24T15:46:31Z"
     name: sg-1
     network_id: enp559cr9qufsuhm9kbr
     status: ACTIVE
     rules:
     ...
     ```

- API

  Чтобы удалить правило, воспользуйтесь методом REST API [updateRules](../api-ref/SecurityGroup/updateRules.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/UpdateRules](../api-ref/grpc/security_group_service.md#UpdateRules).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить правило из группы безопасности, созданное с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите блок `ingress` или `egress` в описании группы безопасности:

     {% cut "Пример описания группы безопасности с правилами в конфигурации {{ TF }}" %}

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

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

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
     yc vpc security-group get <имя группы безопасности>
     ```

{% endlist %}
