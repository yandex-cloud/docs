# Создать SAML-приложение в {{ org-full-name }} для интеграции с Selectel

[Selectel](https://selectel.ru/) — это провайдер облачной инфраструктуры и услуг дата-центров, предоставляющий выделенные серверы, облачные платформы и сервисы хранения данных. Selectel поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Selectel с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне Selectel.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Selectel:

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
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `selectel-app`.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):
            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Selectel с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне Selectel и на стороне {{ org-name }}.

### Настройте SAML-приложение на стороне Selectel {#setup-sp}

{% note info %}

Создать федерацию удостоверений в Selectel может [владелец аккаунта](https://docs.selectel.ru/access-control/user-types/#account-owner) или пользователь с ролью **iam_admin**.

{% endnote %}

Чтобы настроить аутентификацию по стандарту SAML на стороне Selectel, вам потребуется создать и настроить [федерацию удостоверений](https://docs.selectel.ru/access-control/federations/about-federations/). Для этого:

1. Войдите в свой аккаунт Selectel, в верхней панели выберите **Аккаунт**.
1. В левой панели в блоке **Управление доступом** выберите раздел **Федерации**.
1. Нажмите кнопку **Добавить федерацию**.

Далее настройте связь между Selectel и {{ org-name }}:

1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значения полей **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** и **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**.
1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите на кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** и сохраните файл на своем устройстве.
1. Вернитесь в Selectel, после чего в меню **Создание федерации**:
    1. В поле **Имя** задайте имя федерации.
    1. (Опционально) В поле **Описание** задайте описание федерации.
    1. Вставьте скопированные значения в поля **IdP Issuer** и **Ссылка на страницу входа IdP**.
    1. В поле **Время жизни сессии** задайте время жизни сессии, в течение которой будет аутентифицирован пользователь без необходимости повторной аутентификации, или оставьте значение по умолчанию (24 часа).
    1. (Опционально) Чтобы запросы аутентификации подписывались, отметьте чекбокс **Подписывать запросы аутентификации**.
    1. (Опционально) Чтобы пользователи проходили принудительную аутентификацию после истечения сессии в Selectel, отметьте чекбокс **Принудительная аутентификация в IdP**.
    1. Нажмите кнопку **Создать федерацию**.
    1. В поле **Имя сертификата** задайте имя сертификата.
    1. Откройте сохраненный ранее файл сертификата в любом текстовом редакторе, скопируйте его содержимое и вставьте в поле **Сертификат**.
    1. Нажмите кнопку **Добавить**, затем кнопку **Завершить добавление федерации**.
    1. На странице созданной федерации скопируйте значение поля **Идентификатор**.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите адрес `https://api.selectel.ru/v1/federations/saml/<federation_id>`, где `federation_id` — идентификатор федерации, который вы скопировали в конце прошлого этапа.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://api.selectel.ru/v1/auth/federations/<federation_id>/saml/acs`.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### (Опционально) Настройте проверку цифровой подписи {#signature-verification}

Если при настройке федерации вы отметили чекбокс **Подписывать запросы аутентификации**, необходимо настроить проверку цифровой подписи:

1. [Скачайте сертификат Selectel](https://docs.selectel.ru/access-control/federations/certificates/#download-certificate-for-request-verification).
1. В SAML-приложении в правом верхнем углу нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне активируйте опцию **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}**.
1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.
1. Выберите способ добавления сертификата:
    * Чтобы добавить сертификат в виде файла, нажмите **{{ ui-key.yacloud_components.fileinput.button_attach-file }}** и укажите путь к нему.
    * Чтобы вставить скопированное содержимое сертификата, выберите способ **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}** и вставьте содержимое.
1. Нажмите **{{ ui-key.yacloud.common.add }}**, затем нажмите **{{ ui-key.yacloud.common.save }}**.

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Selectel с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md). Также необходимо явно добавить пользователей в Selectel.

#### Добавьте пользователей в SAML-приложение {#add-users-idp}

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужного пользователя или группу пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

#### Добавьте пользователей в Selectel {#add-users-sp}

Перед тем как добавить пользователя в Selectel, скопируйте его ID из сервиса {{ org-name }}:

1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. На панели слева выберите ![person](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**. Найдите в списке пользователя, которого хотите добавить в Selectel.
1. Скопируйте значение в столбце **{{ ui-key.yacloud_org.entity.user.caption.username }}**.

После чего добавьте пользователя в аккаунт Selectel:

1. Вернитесь в Selectel, после чего в верхней панели выберите **Аккаунт**.
1. Перейдите в раздел **Пользователи**.
1. В правом верхнем углу нажмите кнопку **Добавить пользователя**.
1. В блоке **Данные пользователя**:
    1. В поле **Способ входа** выберите **Федерация (<имя_федерации>)**.
    1. В поле **External ID** вставьте скопированный ID.
    1. В поле **Почта** введите адрес электронной почты пользователя. На указанную почту пользователю придет письмо с инструкциями для завершения аутентификации.
    1. (Опционально) Введите описание пользователя.
1. В блоке **Настройки доступа** настройте разрешение для пользователя. Для этого:
    1. Выберите область доступа: **Аккаунт** или **Проекты**. Для области доступа **Проекты** выберите нужные проекты в поле **Проект**.
    1. Назначьте пользователю роль. Для назначения пользователю роли `member` и выше на балансе аккаунта должно быть минимум 100 ₽.
    1. (Опционально) Добавьте еще одно разрешение, нажав на кнопку **Добавить разрешение**.
1. (Опционально) В поле **Группа** назначьте пользователю группу.
1. (Опционально) В поле **Уведомления** выберите категории уведомлений, которые будут приходить пользователю на почту.
1. Нажмите кнопку **Добавить пользователя**.

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Selectel, выполните аутентификацию в Selectel от имени одного из добавленных в приложение пользователей. Для этого:

1. Откройте письмо о предоставлении доступа к аккаунту Selectel. В письме находятся ссылка для аутентификации по SSO и ID федерации.
1. Перейдите по ссылке из письма, после чего откроется страница аутентификации.
1. В поле **ID федерации** введите ID федерации.
1. Нажмите кнопку **Войти**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. После успешной аутентификации на стороне {{ org-name }} вы будете перенаправлены на страницу входа в Selectel. Введите свое полное имя в поле **ФИО**.
1. Нажмите кнопку **Войти**.
1. Убедитесь, что вы аутентифицировались в Selectel.
