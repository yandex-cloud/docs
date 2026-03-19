# Создать SAML-приложение в {{ org-full-name }} для интеграции с Cloud.ru

[Cloud.ru](https://cloud.ru/) — российский провайдер облачных услуг, предоставляющий IaaS- и PaaS-сервисы, инструменты для AI/ML-разработки, а также решения для публичных, частных и гибридных облаков с поддержкой миграции и эксплуатации ИТ-инфраструктуры.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Cloud.ru с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Cloud.ru.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Cloud.ru:

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
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `cloud-ru-saml-app`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Cloud.ru с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне Cloud.ru и на стороне {{ org-full-name }}.

### Настройте SAML-приложение на стороне Cloud.ru {#setup-sp}

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Настройте SAML-аутентификацию для Cloud.ru.

    1. Войдите в [консоль](https://console.cloud.ru/) Cloud.ru.
    1. Перейдите в раздел **Администрирование**, на вкладку **Федерации**.
    1. Нажмите **Создать федерацию** и выберите тип протокола **SAML**.
    1. Загрузите XML-файл метаданных, который вы получили в {{ org-full-name }} на предыдущем шаге.
    1. Заполните название и описание федерации.
    1. Задайте длительность сессии.
        
        {% note info %}

        Максимальное время жизни сессии SSO — от 30 минут до 7 дней. При отсутствии активности сессия автоматически завершается, после чего требуется повторная аутентификация.
        
        {% endnote %}
    
    1. Проверьте параметры раздела **Single Logout Service**, они должны загрузиться из XML-файла метаданных. Для параметра **Default URL Binding** укажите значение `Post`.
    1. Проверьте параметры раздела **Single Sign-On Service**, они должны загрузиться из XML-файла метаданных. Для параметра **Default URL Binding** укажите значение `Redirect`.
    1. Убедитесь, что сертификат подписи загрузился из XML-файла метаданных и имеет тип `Signing`.
    1. Нажмите на кнопку **Создать**.
    1. Скачайте предоставленный XML‑файл с метаданными Cloud.ru — они необходимы для завершения настройки в {{ org-full-name }}.
    1. Нажмите на кнопку **Готово**.
    1. В списке федераций найдите созданную федерацию и скопируйте её ID. Сохраните этот идентификатор — он понадобится в дальнейшем.

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите значение атрибута `entityID` элемента `EntityDescriptor` из XML‑файла с метаданными Cloud.ru.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите значение атрибута `Location` элемента `AssertionConsumerService` из XML‑файла с метаданными Cloud.ru.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в Cloud.ru с помощью SAML‑приложения {{ org-full-name }}, необходимо явно добавить их учётные записи как в само приложение, так и в федерацию Cloud.ru.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

#### Добавьте пользователей в SAML-приложение {{ org-full-name }} {#add-app-users}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите требуемого пользователя.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

#### Добавьте пользователей в федерацию Cloud.ru {#add-cloudru-users}

1. Войдите в [консоль](https://console.cloud.ru/) Cloud.ru.
1. Откройте раздел **Пользователи** и перейдите на вкладку **Федеративные пользователи**.
1. В правом верхнем углу нажмите **Добавить пользователя федерации**.
1. Выберите федерацию, в которую нужно включить пользователя.
1. Укажите email пользователя.
1. Выдайте пользователю необходимые права доступа к проектам и платформам.
1. Нажмите **Добавить**.

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы SAML‑приложения и его интеграцию с Cloud.ru, выполните аутентификацию в Cloud.ru под учётной записью одного из пользователей, добавленных в приложение.

Для этого:

1. В браузере откройте страницу входа в [консоль](https://console.cloud.ru/) Cloud.ru.
1. Если вы были авторизованы, выйдите из профиля.
1. На форме входа нажмите кнопку **SSO**.
1. В появившемся диалоге введите ID созданной вами федерации и нажмите **Войти**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя.
1. Убедитесь, что вы успешно аутентифицировались в Cloud.ru.
