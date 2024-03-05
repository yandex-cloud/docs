# Изменить имя и описание

После создания группы безопасности вы можете изменить ее имя и описание, а также [добавить](security-group-add-rule.md) или [удалить](security-group-delete-rule.md) правила.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить имя или описание группы:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется изменить группу безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке группы, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в имя и описание группы и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
  Чтобы изменить группу безопасности, выполните команду:

  ```
  yc vpc security-group update <идентификатор_группы> --new-name test-sg-renamed
  ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}
 
  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

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

     Более подробную информацию о параметрах ресурса `yandex_vpc_security_group` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_security_group).

     {% note info %}

     Для управления [группой безопасности по умолчанию](../../vpc/concepts/security-groups#default-security-group) используйте ресурс [vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group).

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
     yc vpc security-group get <имя_группы_безопасности>
     ```

- API {#api}

  Чтобы изменить имя или описание группы, воспользуйтесь методом REST API [update](../api-ref/SecurityGroup/update.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Update](../api-ref/grpc/security_group_service.md#Update) и передайте в запросе:

  * Идентификатор изменяемой группы безопасности в параметре `securityGroupId`.

    {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Новое имя группы безопасности в параметре `name`.
  * Новое описание группы безопасности в параметре `description`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
