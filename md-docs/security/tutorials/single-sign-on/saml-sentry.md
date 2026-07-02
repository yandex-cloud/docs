[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Настройка единого входа в Sentry по стандарту SAML

# Создать SAML-приложение в Yandex Identity Hub для интеграции с Sentry

[Sentry](https://sentry.io/) — это платформа для мониторинга и отслеживания ошибок в реальном времени в приложениях, позволяющая разработчикам оперативно обнаруживать, диагностировать и исправлять сбои и проблемы с производительностью.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Sentry с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Sentry.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

{% note info %}

Для интеграции с помощью SAML для вашего экземпляра Sentry должен быть настроен публичный домен и корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Sentry:

1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
      1. В поле **Имя** задайте имя создаваемого приложения: `sentry-app`.

      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **Добавить метку**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
   1. Сохраните значение поля **Metadata URL**, оно понадобится на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Найдите слаг организации {#get-org-slug}

Для настройки эндпоинтов вам понадобится слаг организации (Organization Slug), по умолчанию имеет значение `sentry`. Чтобы найти слаг вашей организации:

1. Войдите в Sentry.
1. В меню слева нажмите кнопку **Settings**.
1. Во вкладке **Organization** выберите пункт **General Settings**.
1. Скопируйте значение поля **Organization Slug**.

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** вставьте значение `<адрес_инстанса_sentry>/saml/metadata/<слаг_организации>/`.
      1. В поле **ACS URL** вставьте значение `<адрес_инстанса_sentry>/saml/acs/<слаг_организации>/`.
      1. (Опционально) В поле **SP Logout URL** вставьте значение `<адрес_инстанса_sentry>/saml/sls/<слаг_организации>/`.
      1. Нажмите **Сохранить**.

{% endlist %}

### Настройте аутентификацию на стороне Sentry {#setup-sp}

1. Войдите в Sentry под пользователем с правами владельца организации.
1. В меню слева нажмите кнопку **Settings**.
1. Во вкладке **Organization** выберите пункт **Auth**.
1. В списке провайдеров выберите **SAML2**.
1. Нажмите **Configure**.
1. В поле **Metadata URL** введите адрес файла с метаданными, скопированный ранее.
1. Нажмите **Get metadata**.
1. В разделе **Map Identity Provider Attributes** заполните поля:
   * В поле **IdP User ID** введите `fullname`.
   * В поле **User Email** введите `emailaddress`.
   * (Опционально) В поле **First Name** введите `givenname`.
   * (Опционально) В поле **Last Name** введите `surname`.
1. Нажмите **Save Settings**.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Sentry с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Добавьте пользователей в приложение:

   {% list tabs group=instructions %}

   - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
      1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
      1. Перейдите на вкладку **Пользователи и группы**.
      1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите **Добавить**.

   {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Sentry, выполните аутентификацию в Sentry от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Sentry.
1. На странице аутентификации нажмите **Login with SAML2**.
1. На странице аутентификации Yandex Cloud укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Sentry.