{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
  1. Чтобы добавить атрибут групп пользователей, в правом верхнем углу страницы нажмите кнопку ![circles-3-plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** задайте имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите одно из значений:

          {% include [saml-app-group-assertion](./saml-app-group-assertion.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы добавить дополнительные атрибуты пользователей, в правом верхнем углу страницы нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** задайте имя атрибута, уникальное для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** выберите одно из значений:

          {% include [saml-app-assertion-list](./saml-app-assertion-list.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы изменить имеющийся атрибут, нажмите на строку с нужным атрибутом и в открывшемся окне:
  
      1. Измените имя и/или значение атрибута.

          {% include [saml-app-nameid-assertion](./saml-app-nameid-assertion.md) %}
      
      1. Нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить имеющийся атрибут пользователя или группы, в строке с этим атрибутом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление.

      {% note info %}

      Удалять можно любые атрибуты, кроме обязательного атрибута `NameID`.

      {% endnote %}

{% endlist %}

Убедитесь, что добавленные атрибуты также добавлены в настройки интеграции SAML-приложения на стороне поставщика услуг и корректно обрабатываются им.