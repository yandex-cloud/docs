[Документация Yandex Cloud](../../../../index.md) > [Yandex Identity Hub](../../../index.md) > [Практические руководства](../../index.md) > [Настройка единого входа в приложения (SSO)](../index.md) > LibreChat > OpenID Connect

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с LibreChat

[LibreChat](https://www.librechat.ai/) — это бесплатная платформа с открытым исходным кодом для удобной работы с [большими языковыми моделями](../../../../glossary/llm.md), AI-агентами и [MCP-серверами](../../../../glossary/mcp.md), которую можно развернуть в собственной инфраструктуре. LibreChat поддерживает аутентификацию [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../concepts/organization.md) могли аутентифицироваться в LibreChat с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../concepts/applications/oidc.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне LibreChat.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы предоставить пользователям вашей организации доступ в LibreChat:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Добавьте пользователей](#add-users).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **OIDC (OpenID Connect)**.
        1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
           
           [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../concepts/applications/oidc.md#oidc-application-types).
        1. В поле **Имя** задайте имя создаваемого приложения: `librechat-oidc-app`.
        1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) Добавьте описание и [метки](../../../../resource-manager/concepts/labels.md) приложения.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию LibreChat с созданным OIDC-приложением в Yandex Identity Hub, выполните настройки на стороне Yandex Identity Hub и на стороне LibreChat.

### Получите учетные данные и создайте секрет приложения {#get-credentials-secret}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `librechat-oidc-app`.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение поля **ClientID**.
    1. Создайте секрет приложения (действие доступно только для приложений [типа](../../../concepts/applications/oidc.md#oidc-application-types) `Web Application`).
       
       Для этого в блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
       
       1. (Опционально) Добавьте произвольное описание создаваемого секрета.
       1. Нажмите **Создать**.
       
           В окне отобразится сгенерированный [секрет приложения](../../../concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
       
           {% note warning %}
       
           После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
       
           {% endnote %}
       
       Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
       
       Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../../_assets/console-icons/trash-bin.svg) **Удалить**.

{% endlist %}

### Задайте дополнительные настройки OIDC-приложения в Yandex Identity Hub {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `librechat-oidc-app`.
    1. Справа сверху нажмите ![pencil](../../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:

        1. В поле **Redirect URI** укажите значение `https://<адрес_сервера>/oauth/openid/callback`, где `<адрес_сервера>` — публичный IP-адрес или доменное имя, на котором развернут ваш экземпляр LibreChat.

            {% note info %}

            В настройках OIDC-приложения на стороне Yandex Identity Hub значение `Redirect URI` можно добавить только со схемой `https://`, поэтому ваш экземпляр LibreChat должен быть доступен по протоколу `https`.

            {% endnote %}

        1. В блоке **Scopes** включите опцию **groups (группы пользователя в организации)**.
        1. Нажмите **Сохранить**.

{% endlist %}

### Настройте OIDC-аутентификацию на стороне LibreChat {#setup-sp}

1. На хосте, на котором развернут ваш экземпляр LibreChat, в среде его выполнения задайте следующие переменные окружения, определяющие параметры интеграции LibreChat с OIDC-приложением:

    * Переменные, содержащие основные настройки интеграции:

        Имя переменной | Значение
        --- | ---
        `OPENID_CLIENT_ID` | Значение поля **ClientID**, полученное [ранее](#get-credentials-secret) в свойствах OIDC-приложения на стороне Yandex Cloud.
        `OPENID_CLIENT_SECRET` | Секрет OIDC-приложения, сгенерированный [ранее](#get-credentials-secret).
        `OPENID_ISSUER` | `"https://auth.yandex.cloud/"`
        `OPENID_SESSION_SECRET` | Дополнительный секрет, используемый для защиты сессий.</br></br>Самостоятельно сгенерируйте надежный секрет длиной не менее 32 символов.
        `OPENID_SCOPE` | `"openid profile email groups"`
        `OPENID_CALLBACK_URL` | `"/oauth/openid/callback"`
        `OPENID_USERNAME_CLAIM` | `"preferred_username"`
        `OPENID_NAME_CLAIM` | `"name"`
        `OPENID_EMAIL_CLAIM` | `"email"`
        `OPENID_USE_PKCE` | `true`
        `OPENID_BUTTON_LABEL` | `"Login with Yandex Identity Hub"`
        `OPENID_AUTO_REDIRECT` | `false`
    * Переменные, содержащие дополнительные настройки для синхронизации групп пользователей:

        Имя переменной | Значение
        --- | ---
        `OPENID_ROLE_SYNC_ENABLED` | `true`
        `OPENID_ROLE_SYNC_API_ENABLED` | `false`
        `OPENID_ROLE_SYNC_SOURCE` | `"id"`
        `OPENID_ROLE_SYNC_CLAIM` | `"groups"`
        `OPENID_ROLE_SYNC_ROLE_PRIORITY` | Список имен групп в Yandex Identity Hub, с которыми будет выполняться синхронизация.</br></br>Например: `"librechat-admins,librechat-users"`.
        `OPENID_ROLE_SYNC_FALLBACK_ROLE` | Группа пользователей, которая будет использоваться по умолчанию.</br></br>Например: `"librechat-users"`.
1. Перезапустите экземпляр LibreChat в среде выполнения с заданными переменными окружения.

## Добавьте пользователей {#add-users}

Чтобы разрешить пользователям аутентифицироваться в LibreChat:

1. [Создайте](../../../operations/create-group.md) в Yandex Identity Hub [группу пользователей](../../../concepts/groups.md) с одним из имен, указанных [ранее](#setup-sp) в переменной окружения `OPENID_ROLE_SYNC_ROLE_PRIORITY`. Например: `librechat-users`.
1. [Добавьте](../../../operations/add-member-group.md) нужного пользователя в группу `librechat-users`.
1. Добавьте группу пользователей `librechat-users` в OIDC-приложение Yandex Identity Hub:

    {% note info %}
    
    Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.
    
    {% endnote %}

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![shapes-4](../../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите приложение `librechat-oidc-app`.
        1. Перейдите на вкладку **Пользователи и группы**.
        1. Нажмите ![person-plus](../../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
        1. В открывшемся окне перейдите на вкладку **Группы** и выберите группу пользователей `librechat-users`.
        1. Нажмите **Добавить**.

    {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы OIDC-приложения и интеграции с LibreChat, выполните вход в LibreChat с учетной записью пользователя, добавленного в группу `librechat-users`. Для этого:

1. В окне браузера откройте страницу входа в ваш экземпляр LibreChat.
1. Выберите вход через Yandex Identity Hub.
1. Аутентифицируйтесь в Yandex Cloud с учетной записью пользователя вашей организации.
1. Убедитесь, что в результате успешной аутентификации вы вошли в LibreChat и что авторизованный пользователь относится в LibreChat к той же группе, что и в Yandex Identity Hub — `librechat-users`.