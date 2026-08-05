# Создать SAML-приложение в {{ org-full-name }} для интеграции с Time

[Time](https://time-messenger.ru/) — корпоративный мессенджер с поддержкой единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Time с помощью технологии единого входа по стандарту SAML, создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Time.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в Time:

1. [Сгенерируйте ключ и сертификат](#generate-key-cert).
1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Сгенерируйте ключ и сертификат {#generate-key-cert}

Для шифрования и подписи SAML-ответов Time нужен сертификат и закрытый ключ поставщика услуг (SP). Сгенерируйте его с помощью утилиты `openssl`:

```bash
openssl req -x509 -newkey rsa:2048 \
  -keyout private.key \
  -out certificate.crt \
  -days 365 -nodes \
  -subj "/CN=<имя_инстанса>.time‑messenger.ru"
```

Где `<имя_инстанса>` — имя инстанса Time (поддомена на `time‑messenger.ru`).

В результате будут созданы два файла: `private.key` — закрытый ключ и `certificate.crt` — сертификат. Сохраните их — они понадобятся при настройке SAML в Time.

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `time‑saml‑app`.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** и сохраните сертификат созданного приложения `time‑saml‑app.cer` — он понадобится при настройке SAML в Time.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Time с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне {{ org-full-name }} и на стороне Time.

### Настройте эндпоинты и загрузите сертификат поставщика услуг {#sp-endpoints}

Укажите данные вашего инстанса Time. Чтобы узнать значения эндпоинтов, перейдите в системную консоль Time по адресу `https://<имя_инстанса>.time‑messenger.ru/admin_console/authentication/saml` и скопируйте значения полей `Entity ID` и `ACS URL` из настроек SAML.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите SAML-приложение `time‑saml‑app`.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
        1. В блоке **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.section-service-provider_83p1J }}**:
            1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите `Entity ID` — уникальный идентификатор поставщика услуг.
            1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите `ACS URL` — адрес, на который поставщик услуг будет отправлять запросы для аутентификации пользователя.
            1. (Опционально) При необходимости добавьте еще `ACS URL`, нажав **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}**.
            1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** добавьте адрес, по которому поставщик удостоверений отправляет SAML-ответ после успешного выхода пользователя из системы.
            1. В поле **{{ ui-key.yacloud_org.application.overview.saml_field_security_mode }}** выберите, для каких частей SAML-ответа будет сформирована подпись:

                * `Assertions` — подписываются только утверждения о пользователе (идентификатор, атрибуты, время аутентификации).
                * `Response` — подписывается весь SAML-ответ целиком.
                * `Assertions and Response` — подписываются и утверждения, и весь ответ.
        1. (Опционально) Чтобы принимать только запросы, подписанные одним из добавленных сертификатов, включите **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}** и добавьте сертификат с помощью кнопки **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. Чтобы SAML-ответ был зашифрован с помощью выбранного сертификата, включите опцию **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}** и добавьте ранее созданный сертификат с помощью кнопки **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. В списке **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_data_algo }}** выберите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha256 }}**.
        1. В списке **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_key_algo }}** выберите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha1 }}**.
        1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте атрибуты пользователей {#user-attributes}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите SAML-приложение `time‑saml‑app`.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
    1. Добавьте атрибут для передачи имени пользователя. Справа сверху нажмите **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:
        * В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** введите `username`.
        * В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите значение `SubjectClaims.preferred_username`.

        {% include [attribute-transformation](../../../_includes/tutorials/attribute-transformation.md) %}

        * Нажмите **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.action_add_transformation_bc8Cd }}** и выберите тип трансформации `ExtractBefore`, в поле **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_substring_siBpY }}** укажите `@`. Она извлечет часть адреса электронной почты до символа `@`. Это значение будет использоваться как имя пользователя в Time.
        * Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Настройте SAML-аутентификацию на стороне Time {#setup-sp}

1. Войдите в системную консоль Time по адресу `https://<имя_инстанса>.time‑messenger.ru/admin_console/authentication/saml`.
1. В разделе **Аутентификация**:
   1. Включите опцию **Включить вход через SAML 2.0**.
   1. В поле **URL метаданных провайдера идентификации** укажите адрес, по которому Time отправляет запрос на получение метаданных.

      {% cut "Как узнать адрес файла с метаданными приложения" %}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите SAML-приложение `time‑saml‑app`.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**.

      {% endcut %}

   1. В поле **SAML SSO URL** укажите адрес, на который Time отправляет SAML-запрос для запуска последовательности входа.

      {% cut "Как узнать адрес для запросов аутентификации" %}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите SAML-приложение `time‑saml‑app`.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**.

      {% endcut %}

   1. В поле **URL-адрес издателя поставщика учетных записей** укажите адрес, который используется для SAML-запросов.

      {% cut "Как узнать адрес издателя поставщика учетных записей" %}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите SAML-приложение `time‑saml‑app`.
      1. В блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**.

      {% endcut %}

   1. В блоке **Публичный сертификат удостоверяющего центра** загрузите файл сертификата приложения `time‑saml‑app.cer`.
   1. Включите опцию **Проверка подписи**.
   1. В поле **Адрес входа через поставщика услуг** укажите адрес вида: `https://<имя_инстанса>.time‑messenger.ru/login/sso/saml`. Продублируйте этот адрес в поле **Идентификатор поставщика услуг**.
   1. Включите опцию **Включить шифрование**.
   1. В блоке **Закрытый ключ поставщика услуг** загрузите файл закрытого ключа `private.key`.
   1. В блоке **Публичный сертификат поставщика услуг** загрузите файл сертификата `certificate.crt`.
   1. В списке **Алгоритм подписи** выберите алгоритм `RSAwithSHA512` для подписания запроса.
   1. В списке **Алгоритм канонизации** выберите `Exclusive XML Canonicalization 1.0 (пропустить комментарии)`.
   1. В поле **Атрибут электронной почты** укажите `emailaddress`.
   1. В поле **Атрибут имени пользователя** укажите `username`.
   1. (Опционально) В поле **Атрибут имени** укажите `givenname` — атрибут для заполнения имени пользователя в Time.
   1. (Опционально) В поле **Атрибут фамилии** укажите `surname` — атрибут для заполнения фамилии пользователя в Time.
   1. (Опционально) В поле **Текст кнопки входа** укажите текст, который будет отображаться на кнопке входа на странице авторизации. По умолчанию — `Используя SAML`.
1. Нажмите **Сохранить**.

## Добавьте пользователей {#add-users}

Для аутентификации в Time, добавьте в SAML-приложение {{ org-full-name }} нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

Чтобы добавить пользователей в SAML-приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужных пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Time, выполните вход в Time под учетной записью одного из добавленных пользователей. Для этого:

1. В браузере откройте страницу входа вашего инстанса Time: `https://<имя_инстанса>.time‑messenger.ru`.
1. Выберите вход **Используя SAML**.
1. Аутентифицируйтесь в {{ yandex-cloud }} с учетной записью пользователя из вашей организации.
1. Убедитесь, что после успешной аутентификации вы вошли в Time.
