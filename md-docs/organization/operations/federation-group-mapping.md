# Настроить сопоставление групп федеративных пользователей

Чтобы настроить права доступа пользователей к ресурсам Yandex Cloud с помощью [сопоставления групп](../concepts/add-federation.md#group-mapping):

1. [Создайте группы пользователей](#create-group) в Yandex Identity Hub.
1. [Настройте права доступа](#access) этих групп к ресурсам Yandex Cloud.
1. Создайте группы пользователей в вашем [поставщике удостоверений](../concepts/add-federation.md#federation-usage) и добавьте в них пользователей.

    {% note info %}

    Вы можете использовать существующие группы пользователей.

    {% endnote %}

1. Задайте сопоставление групп пользователей в настройках SAML-атрибутов поставщика удостоверений. Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

    Инструкции по настройке сопоставления групп некоторых поставщиков удостоверений:

   * [Keycloak](../tutorials/federations/group-mapping/keycloak.md).
   * [Microsoft Active Directory Federation Services](../tutorials/federations/group-mapping/adfs.md).
   * [Microsoft Entra ID](../tutorials/federations/group-mapping/entra-id.md).
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU).

1. Задайте сопоставление групп пользователей в настройках федерации:

    {% note info %}
    
    Чтобы настроить сопоставление [групп пользователей](../concepts/user-pools.md) на стороне Yandex Cloud, [назначьте](../../iam/operations/roles/grant.md#resource) пользователю одну из следующих [ролей](../../iam/concepts/access-control/roles.md):
    
    * [`organization-manager.federations.editor`](../security/index.md#organization-manager-federations-editor);
    * [`organization-manager.federations.admin`](../security/index.md#organization-manager-federations-admin);
    * [`organization-manager.editor`](../security/index.md#organization-manager-editor);
    * [`organization-manager.admin`](../security/index.md#organization-manager-admin);
    
    Роль должна быть назначена на те группы, для которых настраивается сопоставление.
    
    {% endnote %}

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.

      1. Нажмите на строку с нужной федерацией и перейдите на вкладку **IdP-группы**.

      1. Включите опцию **Маппинг групп в IdP**.

      1. Нажмите кнопку **Добавить группу** и задайте сопоставление:

          * **Имя группы** — укажите имя группы поставщика удостоверений.
          * **IAM-группа** — выберите группу Yandex Identity Hub из списка.

      1. Повторите предыдущий шаг для всех сопоставляемых групп.

      1. Нажмите кнопку **Сохранить**.

    - Terraform{#tf}

      [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

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
          * `internal_group_id` — имя группы Yandex Identity Hub.
          * `external_group_id` — имя группы поставщика удостоверений.

          Более подробную информацию о параметрах ресурса `yandex_organizationmanager_group_mapping_item` см. в [документации провайдера](../../terraform/resources/organizationmanager_group_mapping_item.md).
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
          
             В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
          1. Примените изменения конфигурации:
          
             ```bash
             terraform apply
             ```
          
          1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

          Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization).

    {% endlist %}