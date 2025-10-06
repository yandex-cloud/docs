# Создать SAML-приложение в {{ org-full-name }} для интеграции с Grafana Cloud

{% include [note-preview](../../../_includes/note-preview.md) %}

[Grafana Cloud](https://grafana.com/products/cloud/) — это управляемая облачная платформа для мониторинга и наблюдаемости (observability), которая включает в себя Grafana, Prometheus, Loki и другие инструменты визуализации и анализа данных. Grafana Cloud поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Grafana Cloud с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне Grafana Cloud.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Grafana Cloud:

1. [Создайте аккаунт в Grafana Cloud](#grafana-account).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate)

## Создайте аккаунт в Grafana Cloud {#grafana-account}

Если у вас нет аккаунта в Grafana Cloud, создайте его:

1. Перейдите на [страницу регистрации Grafana Cloud](https://grafana.com/auth/sign-up/).
1. Заполните регистрационную форму:
    - Укажите ваш email-адрес.
    - Создайте надежный пароль.
1. Нажмите **Create my account**.
1. Подтвердите регистрацию, следуя инструкциям в письме, отправленном на указанный email.
1. Выберите имя организации (это будет частью URL вашего экземпляра). Например `your-org`.
1. После входа в систему убедитесь, что у вас есть права администратора для настройки SAML в Grafana Cloud.

{% note info %}

Для настройки SAML в Grafana Cloud требуются права администратора организации. Если у вас нет необходимых прав, обратитесь к администратору вашей организации в Grafana Cloud.

{% endnote %}

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `grafana-cloud-app`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Grafana Cloud с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне Grafana Cloud и на стороне {{ org-name }}.

### Настройте SAML-приложение на стороне Grafana Cloud {#setup-sp}

1. Чтобы настроить аутентификацию по стандарту SAML на стороне Grafana Cloud, в левой панели выберите раздел **Administration** и в нем подраздел **Authentication**.
1. В основном окне выберите **SAML**.

Далее следуйте шагам, описанным ниже:

#### Общие настройки {#general-settings}

Убедитесь, что активирована опция **Allow signup** — автоматическое создание пользователей на стороне Grafana Cloud при авторизации через SSO. Если опция неактивна, авторизоваться смогут только пользователи, уже созданные на стороне Grafana Cloud.

#### Подпись запросов {#sign-requests}

Настройте сертификат для подписи исходящих запросов.

{% note tip %}

В данный момент {{ org-full-name }} не поддерживает проверку подписи запросов, поэтому рекомендуем оставить опцию **Sign requests** отключенной.

{% endnote %}

#### Подключение Grafana к IdP {#conect-idp}

Настройте связь между Grafana Cloud и {{ org-name }}:

1. В блоке **Configure IdP using Grafana metadata** скопируйте и сохраните адреса эндпоинтов для получения метаданных (*Metadata URL*) и отправки запросов на аутентификацию пользователей (*Assertion Consumer Service URL*). В дальнейшем вам понадобится второй из этих адресов при настройке интеграции на стороне {{ org-name }}.
1. Настройте адрес эндпоинта для получения метаданных из {{ org-name }}:

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**.
    1. Вернитесь в Grafana Cloud и  в блоке **Finish configuring Grafana using IdP data** вставьте скопированный адрес в поле **Metadata URL**.

#### Сопоставление аттрибутов пользователей {#user-mapping}

Настройте соответствие между полями объектов пользователей в Grafana Cloud и {{ org-name }}:

1. В блоке **Assertion attributes mappings** укажите:

    - в поле **Name attribute**: `fullname`;
    - в поле **Login attribute**: `login`;
    - в поле **Email attribute**: `emailaddress`.

1. Если необходимо, чтобы пользователи в Grafana Cloud при входе получали одну из базовых ролей (Viewer, Editor, Admin), добавьте атрибут групп пользователей. Для этого в поле **Role attribute** укажите `groups`.

    {% note info %}

    Если не настроить сопоставление ролей, все пользователи будут входить с ролью по умолчанию — `Viewer`.

    {% endnote %}

    Далее, в блоке **Role mapping** укажите названия групп, пользователи которых получат соответствующие роли. Например:

    - В поле **Viewer**: `grafana-viewer`;
    - В поле **Editor**: `grafana-editor`;
    - В поле **Admin**: `grafana-admin`.

    Группы необходимо будет создать при настройке приложения на стороне {{ org-name }}.

1. Ниже, в поле **Name identifier format** выберите `Email address`.

    Имена аттрибутов пользователей в {{ org-name }} можно посмотреть и настроить в вашем приложении на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.

1. Сохраните настройки, нажав кнопку **Save and enable**.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** вставьте адрес эндпоинта, который вы скопировали на третьем шаге настройки интеграции в Grafana Cloud в поле **Metadata URL**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** вставьте адрес эндпоинта, который вы скопировали на третьем шаге настройки интеграции в Grafana Cloud в поле **Assertion Consumer Service URL**.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте аттрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с Grafana Cloud необходимо, чтобы у пользователей был аттрибут `login`.

{% endnote %}

Если у пользователей нет аттрибута `login`, добавьте его:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. В правом верхнем углу страницы нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** введите `login`.
        1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** выберите `SubjectClaims.preferred_username`.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Если вы настроили сопоставление ролей на стороне Grafana Cloud, добавьте атрибут групп пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Подробнее о настройке аттрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Grafana Cloud с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили сопоставление ролей на стороне Grafana Cloud, [создайте](../../../organization/operations/create-group.md) нужные [группы](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Задайте название, например, `grafana-viewer`.
        1. Нажмите **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.  
            1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. В открывшемся окне выберите нужных пользователей.
            1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

    Аналогично создайте группы `grafana-editor` и `grafana-admin`.

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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Grafana Cloud, выполните аутентификацию в Grafana Cloud от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Grafana Cloud (например, `https://your-org.grafana.net`).
1. Если вы были авторизованы в Grafana Cloud, выйдите из профиля.
1. На странице авторизации Grafana Cloud нажмите **Sign in with SAML**.
1. На странице авторизации {{ yandex-cloud }} укажите имеил и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы авторизовались в Grafana Cloud.
1. Если вы настроили сопоставление ролей, перейдите в профиль пользователя в Grafana Cloud и убедитесь, что в блоке **Organization** отображается соответствующая роль.  
