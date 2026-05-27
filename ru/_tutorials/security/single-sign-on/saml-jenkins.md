# Создать SAML-приложение в {{ org-full-name }} для интеграции с Jenkins

[Jenkins](https://www.jenkins.io/) — программная система с открытым исходным кодом на Java, предназначенная для обеспечения процесса непрерывной интеграции программного обеспечения.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Jenkins с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Jenkins.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

{% note info %}

Для интеграции с помощью SAML для вашего экземпляра Jenkins должен быть настроен корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Jenkins:

1. [Создайте приложение в {{ org-full-name }}](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в {{ org-full-name }} {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `jenkins-saml`.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
   1. Сохраните значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**, оно понадобится на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Установите плагин SAML в Jenkins {#install-saml-plugin}

Чтобы настроить аутентификацию в Jenkins с помощью SAML, установите плагин SAML:

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Plugins**.
1. Перейдите на вкладку **Available** и в строке поиска введите `SAML`.
1. Найдите плагин [**SAML Plugin**](https://plugins.jenkins.io/saml) и установите его, нажав **Install**.
1. Дождитесь завершения установки и перезапустите Jenkins, если это потребуется.

После установки плагина в разделе **Manage Jenkins** > **Security** появится новый вариант **Security Realm** – `SAML 2.0`.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** вставьте любое значение, например `<адрес_инстанса_jenkins>/`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** вставьте значение `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** вставьте значение `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте аутентификацию на стороне Jenkins {#setup-sp}

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Security**.
1. В разделе **Security Realm** выберите `SAML 2.0`.
1. В поле **IdP Metadata URL** введите адрес файла с метаданными, скопированный ранее.
1. В поле **Display Name Attribute** введите `fullname`.
1. В поле **Username Attribute** введите `preferred_username`.
1. В поле **Email Attribute** введите `emailaddress`.
1. Включите опцию **Advanced Configuration** и в поле **SP Entity ID** введите значение, которое вы указали в поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** на стороне {{ org-full-name }}, например `<адрес_инстанса_jenkins>/`.
1. Нажмите **Save**.

### Настройте атрибуты пользователей {#user-attributes}

Добавьте пользователям атрибут `preferred_username`, который будет использоваться в качестве имени пользователя при аутентификации в Jenkins. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

        1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** введите `preferred_username`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите `SubjectClaims.preferred_username`.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Jenkins с помощью SAML-приложения {{ org-full-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
      1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
      1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **{{ ui-key.yacloud.common.add }}**.

   {% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Jenkins, выполните аутентификацию в Jenkins от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Jenkins.
1. Вы будете перенаправлены на страницу аутентификации {{ yandex-cloud }}. Укажите почту и пароль пользователя, которого вы добавили в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Jenkins.