# Настроить сопоставление групп федеративных пользователей

Чтобы настроить права доступа пользователей к ресурсам {{ yandex-cloud }} с помощью [сопоставления групп](../concepts/add-federation.md#group-mapping):

1. [Создайте группы пользователей](#create-group) в {{ org-full-name }}.
1. [Настройте права доступа](#access) этих групп к ресурсам {{ yandex-cloud }}.
1. Создайте группы пользователей в вашем [поставщике удостоверений](../concepts/add-federation.md#federation-usage) и добавьте в них пользователей.

    {% note info %}

    Вы можете использовать существующие группы пользователей.

    {% endnote %}

1. Задайте сопоставление групп пользователей в настройках SAML-атрибутов поставщика удостоверений. Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

    Инструкции по настройке сопоставления групп некоторых поставщиков удостоверений:

   * [{{ keycloak }}](../tutorials/federations/group-mapping/keycloak.md).
   * [{{ microsoft-idp.adfs-full }}](../tutorials/federations/group-mapping/adfs.md).
   * [{{ microsoft-idp.entra-id-full }}](../tutorials/federations/group-mapping/entra-id.md).
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU).

1. Задайте сопоставление групп пользователей в настройках федерации:

    {% note info %}
    
    Чтобы настроить сопоставление [групп пользователей](../concepts/user-pools.md) на стороне {{ yandex-cloud }}, [назначьте](../../iam/operations/roles/grant.md#resource) пользователю одну из следующих [ролей](../../iam/concepts/access-control/roles.md):
    
    * [`organization-manager.federations.editor`](../security/index.md#organization-manager-federations-editor);
    * [`organization-manager.federations.admin`](../security/index.md#organization-manager-federations-admin);
    * [`organization-manager.editor`](../security/index.md#organization-manager-editor);
    * [`organization-manager.admin`](../security/index.md#organization-manager-admin);
    
    Роль должна быть назначена на те группы, для которых настраивается сопоставление.
    
    {% endnote %}

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

      1. Нажмите на строку с нужной федерацией и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.

      1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** и задайте сопоставление:

          * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** — укажите имя группы поставщика удостоверений.
          * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** — выберите группу {{ org-full-name }} из списка.

      1. Повторите предыдущий шаг для всех сопоставляемых групп.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.save-changes }}**.

    - {{ TF }}{#tf}

      [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

          ```hcl
          # Включение сопоставления групп федеративных пользователей

          resource "yandex_organizationmanager_group_mapping" "my_group_map" {
           federation_id = "<идентификатор_федерации>"
           enabled       = true
          }

          # Настройка сопоставления групп федеративных пользователей

          resource "yandex_organizationmanager_group_mapping_item" "group_mapping_item" {
            federation_id     = "<идентификатор_федерации>"
            internal_group_id = "<группа_Cloud_Organization>"
            external_group_id = "<группа_поставщика_удостоверений>"

          depends_on = [yandex_organizationmanager_group_mapping.my_group_map]
          }

          resource "yandex_organizationmanager_group_mapping_item" "group_mapping_item-2" {
            federation_id     = "<идентификатор_федерации>"
            internal_group_id = "<группа_Cloud_Organization>"
            external_group_id = "<группа_поставщика_удостоверений"

          depends_on = [yandex_organizationmanager_group_mapping.my_group_map]
          }
          ```

          Где:
          * `federation_id` — идентификатор федерации.
          * `internal_group_id` — имя группы {{ org-full-name }}.
          * `external_group_id` — имя группы поставщика удостоверений.

          Более подробную информацию о параметрах ресурса `yandex_organizationmanager_group_mapping_item` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_group_mapping_item).
      1. Создайте ресурсы:

          1. В терминале перейдите в директорию с конфигурационным файлом.
          1. Проверьте корректность конфигурации с помощью команды:
          
             ```bash
             terraform validate
             ```
          
             Если конфигурация является корректной, появится сообщение:
          
             ```bash
             Success! The configuration is valid.
             ```
          
          1. Выполните команду:
          
             ```bash
             terraform plan
             ```
          
             В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
          1. Примените изменения конфигурации:
          
             ```bash
             terraform apply
             ```
          
          1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

          {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

    {% endlist %}