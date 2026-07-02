[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Jenkins > Настройка единого входа в Jenkins по стандарту OIDC

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с Jenkins

[Jenkins](https://www.jenkins.io/) — программная система с открытым исходным кодом на Java, предназначенная для обеспечения процесса непрерывной интеграции программного обеспечения.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Jenkins с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Jenkins.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

{% note info %}

Для интеграции с помощью OIDC для вашего экземпляра Jenkins должен быть настроен публичный домен и корректный SSL-сертификат.

{% endnote %}

Чтобы дать доступ пользователям вашей организации в Jenkins:

1. [Создайте приложение в Yandex Identity Hub](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
   1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **OIDC (OpenID Connect)**.
      1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
         
         [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../organization/concepts/applications/oidc.md#oidc-application-types).
      1. В поле **Имя** задайте имя создаваемого приложения: `jenkins-oidc`.
      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

         1. Нажмите **Добавить метку**.
         1. Введите метку в формате `ключ: значение`.
         1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
   1. В открывшемся окне на вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте и сохраните значение параметров `ClientID` и `OpenID Configuration`.
   1. Создайте [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret):

      Создайте секрет приложения (действие доступно только для приложений [типа](../../../organization/concepts/applications/oidc.md#oidc-application-types) `Web Application`):
      
      1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
      
          1. (Опционально) Добавьте произвольное описание создаваемого секрета.
          1. Нажмите **Создать**.
      
      В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
      
      {% note warning %}
      
      После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
      
      {% endnote %}
      
      Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
      
      Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Установите плагин OIDC в Jenkins {#install-oidc-plugin}

Чтобы настроить аутентификацию в Jenkins с помощью OIDC, установите плагин OIDC:

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Plugins**.
1. Перейдите на вкладку **Available** и в строке поиска введите `OpenId Connect Authentication`.
1. Найдите плагин [**OpenId Connect Authentication**](https://plugins.jenkins.io/oic-auth) и установите его, нажав **Install**.
1. Дождитесь завершения установки и перезапустите Jenkins, если это потребуется.

После установки плагина в разделе **Manage Jenkins** > **Security** появится новый вариант **Security Realm** – `Login with Openid Connect`.

### Настройте OIDC-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
      1. В поле **Redirect URI** укажите эндпоинт аутентификации для тестового приложения `<адрес_инстанса_jenkins>/securityRealm/finishLogin`.
      1. Нажмите **Сохранить**.

{% endlist %}

### Настройте аутентификацию на стороне Jenkins {#setup-sp}

1. Войдите в Jenkins под пользователем с правами администратора.
1. В меню слева выберите **Manage Jenkins** > **Security**.
1. В разделе **Security Realm** выберите `Login with Openid Connect`.
1. В поле **Client id** введите значение, скопированное при настройке OIDC-приложения в Yandex Identity Hub в поле **ClientID**.
1. В поле **Client secret** введите значение, скопированное при настройке OIDC-приложения в Yandex Identity Hub в блоке **Секреты приложения**.
1. В поле **Well-known configuration endpoint** введите URL, скопированный при настройке OIDC-приложения в Yandex Identity Hub в поле **OpenID Configuration**.
1. Нажмите **Advanced** и в поле **Override scopes** введите `openid email profile`.
1. Нажмите **User fields** и заполните поля:
   - **User name field name**: `preferred_username`
   - **Full name field name**: `name`
   - **Email field name**: `email`
1. Нажмите **Save**.

### Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Jenkins с помощью OIDC-приложения Yandex Identity Hub, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

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

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Jenkins, выполните аутентификацию в Jenkins от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра Jenkins.
1. Вы будете перенаправлены на страницу аутентификации Yandex Cloud. Укажите почту и пароль пользователя, которого вы добавили в приложение. Также у пользователя должна быть указана почта.
1. Убедитесь, что вы аутентифицировались в Jenkins.