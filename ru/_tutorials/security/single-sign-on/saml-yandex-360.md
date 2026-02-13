# Создать SAML-приложение в {{ org-full-name }} для интеграции с {{ yandex-360 }}

[Яндекс 360](https://360.yandex.ru/) — это облачная платформа для бизнеса, предоставляющая набор инструментов для корпоративной электронной почты, совместной работы и управления документами. {{ yandex-360 }} поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в {{ yandex-360 }} с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }} и настройте его на стороне {{ org-name }} и на стороне {{ yandex-360 }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в {{ yandex-360 }}:

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
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `yandex360`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию {{ yandex-360 }} с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне {{ org-name }} и на стороне {{ yandex-360 }}.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите `https://yandex.ru/`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://passport.yandex.ru/auth/sso/commit`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с {{ yandex-360 }} необходимо настроить атрибуты `User.EmailAddress`, `User.Firstname` и `User.Surname`.

{% endnote %}

Настройте атрибуты пользователей для интеграции с {{ yandex-360 }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Отредактируйте атрибуты пользователей:

        1. Атрибут `emailaddress` замените на `User.EmailAddress`. Для этого:
            1. Кликните на строку с атрибутом `emailaddress`.
            1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** введите `User.EmailAddress`.
            1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** оставьте текущее значение `SubjectClaims.email`.
            1. Нажмите **{{ ui-key.yacloud.common.save }}**.

        1. Атрибут `givenname` замените на `User.Firstname`:
        1. Атрибут `surname` замените на `User.Surname`:
        1. Атрибут `fullname` не понадобится — его можно удалить.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

#### Соберите данные для настройки {{ yandex-360 }} {#collect-idp-data}

Для настройки SSO в {{ yandex-360 }} вам потребуются следующие данные из вашего SAML-приложения:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте следующие данные:

        * **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** — издатель поставщика удостоверений (IdP Entity ID).
        * **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** — URL-адрес точки входа (Login URL).

    1. В блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите на кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** и сохраните сертификат подписи токенов формата X.509 на своем устройстве.

{% endlist %}

Эти данные потребуются для настройки SSO на стороне {{ yandex-360 }}.

### Настройте SAML-аутентификацию на стороне {{ yandex-360 }} {#setup-sp}

{% note info %}

Настройку SAML-аутентификации в {{ yandex-360 }} может проводить пользователь с правами администратора организации.

{% endnote %}

Чтобы настроить SAML-аутентификацию на стороне {{ yandex-360 }}:

1. Войдите в [консоль Яндекс 360 для бизнеса](https://admin.yandex.ru/).
1. Перейдите в раздел настроек единого входа (SSO).
1. Укажите данные, полученные на предыдущем шаге:
    * **IdP Entity ID** — издатель поставщика удостоверений.
    * **Login URL** — URL-адрес точки входа.
    * Загрузите **сертификат подписи токенов** формата X.509.
1. Сохраните настройки.

{% note warning %}

Проверьте, что домен из почтового атрибута `User.EmailAddress` в SAML response совпадает с основным доменом или одним из доменов-алиасов вашей организации {{ yandex-360 }}.

{% endnote %}

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в {{ yandex-360 }} с помощью SAML-приложения {{ org-name }}, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

Добавьте пользователей в приложение:

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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с {{ yandex-360 }}, выполните аутентификацию в {{ yandex-360 }} от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите на страницу входа в {{ yandex-360 }}.
1. Если вы были авторизованы в {{ yandex-360 }}, выйдите из профиля.
1. На странице аутентификации выберите вход через Single Sign-On (SSO).
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в {{ yandex-360 }}.

### Решение проблем с настройкой {#troubleshooting}

Если в процессе настройки поставщика удостоверений заданы неверные значения, то при попытке входа через SSO вы увидите сообщение «Авторизация не удалась» и код ошибки:

#### email.not_in_response {#email-not-in-response}

Указывайте имена атрибутов в формате `User.Firstname`, `User.Surname`, `User.EmailAddress`. Если задать другой формат, например `Firstname`, аутентифицироваться не получится.

#### request_your_admin {#request-your-admin}

Ошибка появляется, если администратор каталога пользователей вашей организации ограничил для аккаунта доступ к {{ yandex-360 }}. За подробной информацией обратитесь к специалистам технической поддержки вашей организации.

#### samlresponse.invalid {#samlresponse-invalid}

Ошибка возникает, если неверно указаны URL-адрес точки входа, издатель поставщика удостоверений или сертификат подписи токенов. Также она может возникнуть в течение 14 дней до истечения сертификата подписи токенов или после его истечения. Проверьте корректность настроек SSO в {{ yandex-360 }}.

#### unsupportable_domain {#unsupportable-domain}

Проверьте, что домен из почтового атрибута `User.EmailAddress` в [SAML](https://ru.wikipedia.org/wiki/SAML) response такой же, как и основной домен или один из доменов-алиасов организации {{ yandex-360 }}.
