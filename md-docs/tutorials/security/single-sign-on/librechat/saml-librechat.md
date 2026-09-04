[Документация Yandex Cloud](../../../../index.md) > [Практические руководства](../../../index.md) > [Безопасность](../../index.md) > Настройка единого входа в приложения (SSO) > LibreChat > SAML

# Создать SAML-приложение в Yandex Identity Hub для интеграции с LibreChat

[LibreChat](https://www.librechat.ai/) — это бесплатная платформа с открытым исходным кодом для удобной работы с [большими языковыми моделями](../../../../glossary/llm.md), AI-агентами и [MCP-серверами](../../../../glossary/mcp.md), которую можно развернуть в собственной инфраструктуре. LibreChat поддерживает стандарт [SAML](https://ru.wikipedia.org/wiki/SAML) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../../organization/concepts/organization.md) могли аутентифицироваться в LibreChat с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне LibreChat.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

{% note info %}

Для успешной интеграции по стандарту SAML доступ к вашему экземпляру LibreChat должен быть настроен по протоколу `https` с использованием корректного TLS-сертификата.

{% endnote %}

Чтобы предоставить пользователям вашей организации доступ в LibreChat:

1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:

      1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
      1. В поле **Имя** задайте имя создаваемого приложения: `librechat-saml-app`.
      1. (Опционально) Задайте описание и добавьте [метки](../../../../resource-manager/concepts/labels.md) приложения.
      1. Нажмите **Создать приложение**.
  1. На открывшейся странице вновь созданного приложения:
  
      1. В блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте и сохраните значение поля **Login URL**, оно понадобится при настройке интеграции на стороне LibreChat.
      1. В блоке **Сертификат приложения** нажмите кнопку **Скачать сертификат**, чтобы получить сертификат вашего SAML-приложения.

          Скопируйте полученный файл сертификата на сервер, на котором развернут ваш экземпляр LibreChat.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию LibreChat с созданным SAML-приложением, выполните настройки на стороне Yandex Identity Hub и на стороне LibreChat.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Настройте эндпоинты поставщика услуг. Для этого справа сверху нажмите ![pencil](../../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:

      1. В поле **SP EntityID** укажите любое значение, например адрес вашего экземпляра LibreChat: `https://librechat.example.com`.
      1. В поле **ACS URL** укажите адрес `https://<адрес_экземпляра_LibreChat>/oauth/saml/callback`.
      1. Нажмите **Сохранить**.
  1. Настройте сопоставление для атрибута `username`, который будет использоваться в качестве имени пользователя при аутентификации в LibreChat. Для этого:

      1. Перейдите на вкладку **Атрибуты**.
      1. В правом верхнем углу страницы нажмите ![plus](../../../../_assets/console-icons/plus.svg) **Добавить атрибут** и в открывшемся окне:

          1. В поле **Имя атрибута** введите `username`.
          1. В поле **Значение** выберите `SubjectClaims.preferred_username`.
          1. Нажмите **Добавить**.

      Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../../organization/operations/applications/saml-create.md#setup-attributes).

{% endlist %}

### Настройте аутентификацию на стороне LibreChat {#setup-sp}

На хосте, на котором развернут ваш экземпляр LibreChat, в среде его выполнения задайте следующие переменные окружения, определяющие параметры интеграции LibreChat с SAML-приложением:

Имя переменной | Значение
--- | ---
`SAML_ENTRY_POINT` | Значение `Login URL`, сохраненное [ранее](#create-app).
`SAML_ISSUER` | Значение `SP EntityID`, заданное [ранее](#setup-idp) на стороне Yandex Identity Hub.</br></br>Например: `https://librechat.example.com`.
`SAML_CERT` | Локальный путь к файлу сертификата SAML-приложения, сохраненному [ранее](#create-app), в среде выполнения вашего экземпляра LibreChat.</br></br>Например: `"/app/saml-certs/librechat-saml-app.cer"`.
`SAML_CALLBACK_URL` | `"https://<адрес_экземпляра_LibreChat>/oauth/saml/callback"`
`SAML_SESSION_SECRET` | Дополнительный секрет, используемый для защиты сессий.</br></br>Самостоятельно сгенерируйте надежный секрет длиной не менее 32 символов.
`SAML_EMAIL_CLAIM` | `"emailaddress"`
`SAML_USERNAME_CLAIM` | `"username"`
`SAML_GIVEN_NAME_CLAIM` | `"givenname"`
`SAML_FAMILY_NAME_CLAIM` | `"surname"`
`SAML_NAME_CLAIM` | `"fullname"`
`SAML_BUTTON_LABEL` | `"Login with Yandex Identity Hub"`

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в LibreChat с помощью SAML-приложения Yandex Identity Hub, добавьте в SAML-приложение нужных пользователей и/или [группы пользователей](../../../../organization/concepts/groups.md):

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
  1. Перейдите на вкладку **Пользователи и группы**.
  1. Нажмите ![person-plus](../../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
  1. В открывшемся окне выберите нужного пользователя или группу пользователей.
  1. Нажмите **Добавить**.

{% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с LibreChat, выполните аутентификацию в LibreChat от имени одного из добавленных в приложение пользователей. Для этого:

1. В окне браузера откройте страницу входа в ваш экземпляр LibreChat.
1. Выберите вход через Yandex Identity Hub.
1. Аутентифицируйтесь в Yandex Cloud с учетной записью пользователя вашей организации, добавленного в SAML-приложение.
1. Убедитесь, что вы успешно аутентифицировались в LibreChat.