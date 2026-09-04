[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Time > Настройка единого входа в Time по стандарту OIDC

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с Time

[Time](https://time-messenger.ru/) — корпоративный мессенджер с поддержкой единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Time с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Time.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в Time:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **OIDC (OpenID Connect)**.
        1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
           
           [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../organization/concepts/applications/oidc.md#oidc-application-types).
        1. В поле **Имя** задайте имя создаваемого приложения: `time-oidc-app`.
        1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) Добавьте описание и [метки](../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию Time с созданным OIDC-приложением в Yandex Identity Hub, выполните настройки на стороне Yandex Identity Hub и на стороне Time.

### Получите учетные данные и создайте секрет приложения {#get-credentials-secret}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `time-oidc-app`.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение параметра **ClientID**.
    1. Создайте секрет приложения (действие доступно только для приложений [типа](../../../organization/concepts/applications/oidc.md#oidc-application-types) `Web Application`).
       
       Для этого в блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
       
       1. (Опционально) Добавьте произвольное описание создаваемого секрета.
       1. Нажмите **Создать**.
       
           В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
       
           {% note warning %}
       
           После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
       
           {% endnote %}
       
       Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
       
       Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

{% endlist %}

### Настройте OIDC-аутентификацию на стороне Time {#setup-sp}

1. Войдите в системную консоль Time по адресу `https://<имя_инстанса>.time-messenger.ru/admin_console/authentication/openid`, где `<имя_инстанса>` — имя вашего инстанса Time.
1. В разделе **Аутентификация**:
   1. Выберите **OpenID Connect**.
   1. В списке **Выберите провайдера** укажите **Подключение OpenID (Другое)**.
   1. (Опционально) В поле **Название кнопки** укажите текст, который будет отображаться на кнопке входа на странице авторизации, например `Используя OIDC`.
   1. (Опционально) Выберите цвет кнопки входа на странице авторизации.
   1. В поле **Ссылка на поставщика** укажите адрес провайдера OpenID Connect — `https://auth.yandex.cloud`.
   1. В поле **ID клиента** укажите значение **ClientID**, скопированное из Yandex Identity Hub.
   1. В поле **Клиентский ключ** укажите секрет приложения, сгенерированный в Yandex Identity Hub.
1. Сохраните настройки.

### Настройте Redirect URI в Yandex Identity Hub {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `time-oidc-app`.
    1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
        1. В поле **Redirect URI** укажите адрес обратного вызова `https://<имя_инстанса>.time-messenger.ru/signup/openid/complete`, где `<имя_инстанса>` — имя вашего инстанса Time (поддомена на `time-messenger.ru`).
        1. В блоке **Безопасность OAuth/OIDC** отключите опцию **Требовать PKCE**, чтобы приложение Yandex Identity Hub при обмене данными не требовало от внешнего приложения использовать расширение безопасности [PKCE](*pkce_info).
           
           [*pkce_info]: PKCE — это расширение безопасности, применяемое в стандарте OAuth 2.0 с целью минимизировать риски перехвата аутентификационных данных. Подробнее читайте в разделе [PKCE](../../../organization/concepts/applications/oidc.md#pkce).
        1. Нажмите **Сохранить**.

{% endlist %}

## Добавьте пользователей {#add-users}

Для аутентификации в Time, добавьте в OIDC-приложение Yandex Identity Hub нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

Чтобы добавить пользователей в OIDC-приложение:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `time-oidc-app`.
    1. Перейдите на вкладку **Пользователи и группы**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
    1. В открывшемся окне выберите нужных пользователей.
    1. Нажмите **Добавить**.

{% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы OIDC-приложения и интеграции с Time, выполните вход в Time под учетной записью одного из добавленных пользователей. Для этого:

1. В браузере откройте страницу входа вашего инстанса Time: `https://<имя_инстанса>.time-messenger.ru`.
1. Выберите вход через OpenID Connect.
1. Аутентифицируйтесь в Yandex Cloud под учетной записью пользователя из вашей организации.
1. Убедитесь, что после успешной аутентификации вы вошли в Time.