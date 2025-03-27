# Настроить сопоставление групп федеративных пользователей

Чтобы настроить права доступа пользователей к ресурсам {{ yandex-cloud }} с помощью [сопоставления групп](../concepts/add-federation.md#group-mapping):

1. [Создайте группы пользователей](#create-group) в {{ org-name }}.
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

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

      1. Нажмите на строку с нужной федерацией и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.

      1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** и задайте сопоставление:

          * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** — укажите имя группы поставщика удостоверений.
          * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** — выберите группу {{ org-name }} из списка.

      1. Повторите предыдущий шаг для всех сопоставляемых групп.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.save-changes }}**.

    - {{ TF }}{#tf}

      {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

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
            external_group_id = "<группа_поставщика_удостоверений"

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
          * `internal_group_id` — имя группы {{ org-name }}.
          * `external_group_id` — имя группы поставщика удостоверений.

          Более подробную информацию о параметрах ресурса `yandex_organizationmanager_group_mapping_item` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_group_mapping_item).
      1. Создайте ресурсы:

          {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

          {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [{{ org-full-name }}]({{ link-org-cloud-center }}).

    {% endlist %}