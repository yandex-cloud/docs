# Изменить имя и описание

После создания [группы безопасности](../concepts/security-groups.md) вы можете изменить ее имя и описание, а также [добавить](security-group-add-rule.md) или [удалить](security-group-delete-rule.md) правила.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить имя или описание группы:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется изменить группу безопасности.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке группы, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите изменения в имя и описание группы и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
  Чтобы изменить группу безопасности, выполните команду:

  ```
  yc vpc security-group update <идентификатор_группы> --new-name test-sg-renamed
  ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
 
  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

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

     Для управления [группой безопасности по умолчанию](../concepts/security-groups.md#default-security-group) используйте ресурс [vpc_default_security_group]({{ tf-provider-resources-link }}/vpc_default_security_group).

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

  Чтобы изменить имя или описание группы, воспользуйтесь методом REST API [update](../api-ref/SecurityGroup/update.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Update](../api-ref/grpc/SecurityGroup/update.md) и передайте в запросе:

  * Идентификатор изменяемой группы безопасности в параметре `securityGroupId`.

    Чтобы узнать идентификатор группы безопасности, воспользуйтесь методом REST API [list](../api-ref/SecurityGroup/list.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/List](../api-ref/grpc/SecurityGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

  * Новое имя группы безопасности в параметре `name`.
  * Новое описание группы безопасности в параметре `description`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}