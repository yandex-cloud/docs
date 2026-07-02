[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Настройка единого входа в Managed Service for GitLab по стандарту SAML

# Создать SAML-приложение в Yandex Identity Hub для интеграции с Managed Service for GitLab

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Yandex Managed Service for GitLab с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Managed Service for GitLab.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в Managed Service for GitLab:

1. [Создайте инстанс GitLab](#create-mgl-instance).
1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте инстанс GitLab {#create-mgl-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать [инстанс GitLab](../../../managed-gitlab/concepts/index.md#instance).
   1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
   1. Нажмите кнопку **Создать инстанс**.
   1. В верхней части страницы:

      1. Введите имя инстанса. Оно должно быть уникальным в рамках Yandex Cloud.

   1. В блоке **Конфигурация**:

      1. Выберите [тип инстанса](../../../managed-gitlab/concepts/index.md#config). После создания инстанса можно [изменить его тип](../../../managed-gitlab/operations/instance/instance-update.md) на более производительный.
      1. Укажите [зону доступности](../../../overview/concepts/geo-scope.md). После создания инстанса изменить его зону доступности невозможно.
      1. Укажите [подсеть](../../../vpc/concepts/network.md#subnet), в которой будет размещен инстанс.
      1. Выберите [группу безопасности](../../../vpc/concepts/security-groups.md) или создайте новую:

         1. Нажмите кнопку **Создать группу**.
         1. Введите имя и описание группы безопасности. Правила для группы безопасности вы сможете добавить позже в сервисе **Virtual Private Cloud**.
         1. Нажмите кнопку **Создать**.

      1. Выберите размер [диска](../../../compute/concepts/disk.md). После создания инстанса размер его диска [можно увеличить](../../../managed-gitlab/operations/instance/instance-update.md).
      1. Укажите [доменное имя инстанса](../../../compute/concepts/network.md#hostname) — для него будут автоматически созданы нужные DNS-записи в домене `.gitlab.yandexcloud.net`.

      1. Задайте срок хранения автоматических резервных копий (в днях).

   1. В блоке **Данные администратора** укажите:
      * **Электронная почта** — адрес электронной почты администратора инстанса GitLab. На этот адрес придет письмо со ссылкой для создания пароля.
      * **Логин** — логин администратора.
   1. Нажмите кнопку **Создать**.
   1. Дождитесь, когда инстанс будет готов к работе: его статус на панели Managed Service for GitLab сменится на **Running**. Это может занять некоторое время.

{% endlist %}

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
      1. В поле **Имя** задайте имя создаваемого приложения: `managed-gitlab-app`.

      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **Добавить метку**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
   1. Сохраните значения полей **Login URL**, **Issuer / IdP EntityID** и **Цифровой отпечаток (fingerprint)**, они понадобятся на следующем шаге.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Настройте аутентификацию на стороне GitLab с помощью OmniAuth {#setup-sp}

Чтобы интегрировать провайдер аутентификации для GitLab через OmniAuth, добавьте провайдер аутентификации:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
1. Нажмите на созданный инстанс и выберите вкладку **OmniAuth**.
1. Нажмите кнопку **Настроить**.
1. Чтобы добавить провайдера аутентификации, нажмите кнопку **Add**.
1. Выберите тип `SAML` и укажите параметры провайдера аутентификации:

   * **Label** — название провайдера аутентификации. Может быть любым, например `Identity Hub`.
   * **Assertion consumer service URL** — HTTPS-эндпоинт инстанса GitLab. Чтобы сформировать этот URL, добавьте `/users/auth/saml/callback` к адресу вашего инстанса GitLab, например `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
   * **IDP certificate fingerprint** — SHA1-отпечаток открытого ключа сертификата. Используйте значение из поля **Цифровой отпечаток (fingerprint)**, полученное при создании приложения в Yandex Identity Hub.
   * **IDP SSO target URL** — URL провайдера идентификации. Используйте значение из поля **Login URL**.
   * **Issuer** — уникальный идентификатор приложения, в котором будет происходить аутентификация пользователя, например `https://example.gitlab.yandexcloud.net`.
   * **Name identifier format** — формат идентификатора имени, выберите значение `Persistent`.
   * **Allow single sign on** — разрешить использование SSO. Установите значение `true`. Если установить `false`, аутентифицироваться смогут только пользователи, уже созданные на стороне GitLab.
   * **Auto link users by email** — установить соответствие между именем пользователя в OmniAuth и в GitLab, если к ним привязан один адрес электронной почты. Установите значение `true`.
   * **Block auto-created users** — переводить автоматически созданные учетные записи в состояние [Pending approval](https://docs.gitlab.com/ee/administration/moderate_users.html#users-pending-approval) до их одобрения администратором. Установите значение `false`.
   * **External provider** — установить для провайдера свойство _внешний_. Пользователи, аутентифицированные через данный провайдер, будут считаться [внешними](https://docs.gitlab.com/ee/user/admin_area/external_users.html) и не будут иметь доступа к [внутренним проектам](https://docs.gitlab.com/ee/user/public_access.html#internal-projects-and-groups). Установите значение `false`.
   * **Auto link LDAP user** — создавать LDAP-сущность для автоматически созданных учетных записей. Применимо только для инстансов, к которым подключен LDAP-провайдер. Установите значение `false`.

1. Нажмите кнопку **Создать**.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** вставьте адрес эндпоинта, который вы вводили в поле **Issuer** при настройке OmniAuth.
      1. В поле **ACS URL** вставьте адрес эндпоинта, который вы вводили в поле **Assertion consumer service URL** при настройке OmniAuth, например `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
      1. Нажмите **Сохранить**.

{% endlist %}

#### Настройте атрибуты пользователей {#user-attributes}

{% note warning %}

Для интеграции с GitLab необходимо, чтобы у пользователей был атрибут `email`.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
    1. Перейдите на вкладку **Атрибуты**.
    1. Нажмите на строку с атрибутом `emailaddress` и в открывшемся окне:

        1. В поле **Имя атрибута** измените значение на `email`.
        1. Нажмите **Обновить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в GitLab с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

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

Чтобы убедиться в корректной работе SAML-приложения и интеграции с GitLab, выполните аутентификацию в GitLab от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего инстанса GitLab (например, `https://example.gitlab.yandexcloud.net`).
1. Если вы прошли аутентификацию в GitLab, выйдите из профиля.
1. На странице аутентификации GitLab нажмите на название созданного провайдера аутентификации, например `Identity Hub`.
1. На странице аутентификации Yandex Cloud укажите почту и пароль пользователя. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в GitLab.