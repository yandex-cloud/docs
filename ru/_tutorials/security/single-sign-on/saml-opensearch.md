# Создать SAML-приложение в {{ org-full-name }} для интеграции с {{ mos-name }}

[{{ OS }}](https://opensearch.org/) — это легко масштабируемая система поисковых и аналитических инструментов с открытым исходным кодом. {{ OS }} включает в себя пользовательский интерфейс визуализации данных [{{ OS }} Dashboards](https://docs.opensearch.org/latest/dashboards/). [{{ mos-full-name }}](../../../managed-opensearch/) — сервис для управления кластерами OpenSearch в инфраструктуре Yandex Cloud. {{ mos-name }} поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в {{ mos-name }} с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне кластера {{ OS }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Перед началом работы {#before-you-begin}

Убедитесь, что вы можете [подключиться к {{ OS }} Dashboards](../../../managed-opensearch/operations/connect/clients.md#dashboards) с использованием реквизитов пользователя `admin`. О том, как создать и настроить кластер {{ OS }}, см. в разделе [Создание кластера {{ OS }}](../../../managed-opensearch/operations/cluster-create.md).

В этом практическом руководстве предполагается, что веб-интерфейс {{ OS }} Dashboards доступен по URL:

```url
https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
```

Чтобы дать доступ пользователям вашей организации в {{ mos-name }}:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `opensearch-app`.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):
            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию {{ mos-name }} с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне кластера {{ OS }} и на стороне {{ org-name }}.

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите созданное ранее SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение параметра `Issuer / IdP EntityID`, которое необходимо задать на стороне кластера {{ OS }}.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Настройте SSO для кластера {{ OS }}.

    {% note tip %}

    Далее приведены инструкции для консоли управления, но можно [использовать и другие доступные интерфейсы {{ yandex-cloud }}](../../../managed-opensearch/operations/saml-authentication.md#configuration-sso).

    {% endnote %}

    Чтобы настроить источник аутентификации {{ org-name }}:

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.opensearch.auth.section_auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Укажите нужные значения настроек:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}** — идентификатор провайдера. Введите сохраненное ранее значение параметра `Issuer / IdP EntityID`.

        * **idp_metadata_file** — выберите и загрузите ранее скачанный файл с метаданными.

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}** — идентификатор поставщика услуг.
        
            Этот идентификатор должен совпадать с URL для подключения к {{ OS }} Dashboards:

            ```url
            https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
            ```

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}** — URL для подключения к {{ OS }} Dashboards.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}** — атрибут, в котором хранится перечень ролей. Укажите значение `groups`.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}** — оставьте поле пустым.

        * **{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}** — оставьте значение `0`.

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_save }}**. Дождитесь, когда статус кластера изменится на `Running`. Применение настроек может занять несколько минут.

1. Настройте сопоставление ролей в {{ OS }}.

    Чтобы группы пользователей {{ org-name }} сопоставлялись с ролями {{ OS }} при аутентификации:

    1. Подключитесь к {{ OS }} Dashboards от имени пользователя `admin`.
    1. В меню слева выберите **{{ OS }} Plugins** → **Security**.
    1. На панели слева выберите **Roles**.
    1. Настройте сопоставления ролей:
        1. Нажмите на имя нужной роли. В данном руководстве это роль `kibana_user`.
        1. Перейдите на вкладку **Mapped users**.
        1. Нажмите кнопку **Manage mapping**.
        1. В блоке **Backend roles** введите имя [группы пользователей](../../../organization/concepts/groups.md) {{ org-name }}, которой будет сопоставлена роль в {{ OS }}, например, `opensearch-users`.
        1. Нажмите кнопку **Map**.
    
    Теперь пользователи вашей организации, добавленные в группу `opensearch-users`, будут получать роль `kibana_user` при успешной аутентификации в {{ OS }} Dashboards.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите URL для подключения к {{ OS }} Dashboards.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите ACS URL.

        ACS URL имеет вид:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
        ```
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Добавьте атрибут групп пользователей {#group-attribute}

Необходимо, чтобы пользователи в {{ OS }} при входе получали одну из базовых ролей. Чтобы это выполнялось, источник аутентификации {{ org-name }} должен передавать в SAML-ответе список групп пользователей, которым в {{ OS }} будут сопоставлены роли. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** оставьте значение `groups`.
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в {{ OS }} Dashboards с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и группы пользователей.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили сопоставление ролей на стороне {{ mos-name }}, [создайте](../../../organization/operations/create-group.md) нужные группы:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Задайте название, например, `opensearch-users`. Название группы должно точно соответствовать имени группы пользователей, указанному при сопоставлении с ролью {{ OS }}.
        1. Нажмите **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.  
            1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. В открывшемся окне выберите нужных пользователей.
            1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с {{ mos-name }}, выполните аутентификацию в {{ OS }} Dashboards от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра {{ OS }} Dashboards.
1. Если вы были авторизованы в {{ OS }} Dashboards, выйдите из профиля.
1. На странице аутентификации {{ OS }} Dashboards нажмите **Log in with single sign-on**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в {{ OS }} Dashboards.
1. Если вы настроили сопоставление ролей, то:
     1. Нажмите на иконку пользователя в {{ OS }} Dashboards.
     1. Перейдите в **View roles and identities**.
     1. Убедитесь, что в блоке **Roles** отображается роль `kibana_user`, а в блоке **Backend roles** — роль `opensearch-users`.