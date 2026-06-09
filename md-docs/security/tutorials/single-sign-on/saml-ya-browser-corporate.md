# Создать SAML-приложение в {{ org-full-name }} для интеграции с консолью управления Яндекс Браузера для организаций

[Яндекс Браузер для организаций](https://browser.yandex.ru/corp/) — это корпоративный браузер, основанный на последней версии стандартного браузера и доработанный с учетом потребностей бизнеса и акцентом на информационную безопасность. Для централизованного администрирования браузера используется [консоль управления](https://browser.yandex.ru/corp/builds). Консоль управления поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в консоли управления Яндекс Браузера для организаций с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Яндекс Браузера для организаций.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в консоли управления Яндекс Браузера для организаций:

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
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `browser-cloud`.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):
            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы интегрировать Яндекс Браузер для организаций с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне {{ org-full-name }} и на стороне Яндекс Браузера для организаций.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите `browser.yandex.ru`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес в формате `https://<домен_консоли>/corp/api/sso/saml/callback` (например, `https://browser.yandex.ru/corp/api/sso/saml/callback`).
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** выберите значение `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с консолью управления Яндекс Браузера для организаций необходимо настроить атрибуты `firstName` и `lastName`.

{% endnote %}

Настройте атрибуты пользователей для интеграции с Яндекс Браузером для организаций:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Отредактируйте атрибуты пользователей:

        1. Атрибут `givenname` замените на `firstName`.
        1. Атрибут `surname` замените на `lastName`.
        1. Атрибуты `fullname` и `emailaddress` не понадобятся — их можно удалить.

{% endlist %}

Подробнее о настройке атрибутов в разделе [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

#### Соберите данные для настройки Яндекс Браузера для организаций {#collect-idp-data}

Для настройки SSO в Яндекс Браузере для организаций вам потребуются следующие данные из вашего SAML-приложения:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** в поле **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** скопируйте URL-адрес точки входа (Login URL).
    1. В блоке **{{ ui-key.yacloud_org.application.overview.oauth_service_section_title }}** в поле **{{ ui-key.yacloud_org.application.overview.saml_field_sp_entity }}** скопируйте уникальный идентификатор поставщика услуг.
    1. В блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите на кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** и сохраните сертификат подписи токенов формата X.509 на своем устройстве.

{% endlist %}

Эти данные потребуются для настройки SSO на стороне Яндекс Браузера для организаций.

### Настройте SAML-аутентификацию на стороне Яндекс Браузера для организаций {#setup-sp}

{% note info %}

Настройку SAML-аутентификации в Яндекс Браузере для организаций может проводить пользователь с правами администратора организации.

{% endnote %}

Чтобы настроить SAML-аутентификацию на стороне Яндекс Браузера для организаций:

1. Войдите в [консоль управления](https://browser.yandex.ru/corp/builds) Яндекс Браузера для организаций.
1. Перейдите в раздел настроек **SSO**.
1. Укажите данные:
    * **Домен** — [домен](../../../organization/concepts/domains.md) в {{ org-full-name }}.
    * **SP Entity ID** — уникальный идентификатор поставщика услуг, полученный на предыдущем шаге.
    * **Single sign-on service URL** — URL-адрес точки входа, полученный на предыдущем шаге.
    * **Signing certificate** — укажите **сертификат подписи токенов** формата X.509, сохраненный ранее.
1. Сохраните настройки.
1. Нажмите **Скачать сертификат**.
1. (Опционально) Настройте проверку подписи:
   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
   1. Нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
   1. Включите опцию **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}** и нажмите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.add-cert-action }}**.
   1. В открывшемся окне прикрепите файл сертификата, который был скачан в консоли управления Яндекс браузера.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
1. В консоли управления Яндекс Браузера для организаций включите опцию **Аутентификация по SSO/SAML**.
1. Дождитесь подтверждения домена. Чтобы проверить статус, перейдите в раздел настроек **SSO**.

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в консоли управления Яндекс Браузера для организаций с помощью SAML-приложения {{ org-full-name }}, необходимо явно добавить в ваше SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md). Также нужно добавить нужных пользователей в качестве администраторов в консоли управления Яндекс Браузера для организаций.

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

Добавьте администраторов:

1. Войдите в [консоль управления](https://browser.yandex.ru/corp/builds) Яндекс Браузера для организаций.
1. Перейдите в раздел настроек **Администраторы**.
1. Нажмите кнопку **Добавить**.
1. Укажите адрес электронной почты одного из пользователей, добавленных в приложение.
1. Повторите предыдущие шаги для всех пользователей, которым необходим доступ в консоль.

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с консолью управления Яндекс Браузера для организаций, выполните аутентификацию от имени одного из добавленных администраторов. Для этого:

1. В браузере перейдите на страницу входа в консоль управления Яндекс Браузера для организаций.
1. Если вы были авторизованы ранее, выйдите из профиля.
1. На странице аутентификации нажмите **Войти через SSO**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение. Также он должен быть одним из администраторов консоли управления.
1. Убедитесь, что вы аутентифицировались в консоли управления Яндекс Браузера.