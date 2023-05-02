# Изменить имя и описание

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

После создания группы безопасности вы можете изменить ее имя и описание, а также [добавить](security-group-add-rule.md) или [удалить](security-group-delete-rule.md) правила.

{% list tabs %}

- Консоль управления

  Чтобы изменить имя или описание группы:

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

- API

  Чтобы изменить имя или описание группы, воспользуйтесь методом REST API [update](../api-ref/SecurityGroup/update.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Update](../api-ref/grpc/security_group_service.md#Update).

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
 
  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените параметры `name` и `description` в описании группы безопасности:

     ```hcl
     ...
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "${yandex_vpc_network.lab-net.id}"
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/vpc_security_group).

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
