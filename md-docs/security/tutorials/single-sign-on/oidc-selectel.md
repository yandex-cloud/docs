[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Настройка единого входа в Selectel по стандарту OIDC

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с Selectel


Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли входить в Selectel по стандарту OpenID Connect (OIDC), создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в Yandex Identity Hub и настройте интеграцию с Selectel.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы настроить единый вход в Selectel:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Проверьте работу единого входа](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. Нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **OIDC (OpenID Connect)**.
      1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
         
         [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../organization/concepts/applications/oidc.md#oidc-application-types).
      1. В поле **Имя** задайте имя приложения: `selectel-oidc`.
      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Откройте созданное OIDC-приложение.
  1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** разверните секцию **Дополнительные атрибуты** и скопируйте значение поля **ClientID**.
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

### Создайте федерацию в Selectel {#setup-sp}

{% note info %}

Создать федерацию в Selectel может [владелец аккаунта](https://docs.selectel.ru/access-control/user-types/#account-owner) или пользователь с ролью [`iam.admin`](https://docs.selectel.ru/access-control/role-reference/#iam-admin).

{% endnote %}

Чтобы настроить федерацию:

1. Войдите в [панель управления Selectel](https://my.selectel.ru/iam/federations).
1. В верхнем меню выберите **IAM** и перейдите в раздел **Федерации**.
1. Нажмите **Добавить федерацию** и выберите **OpenID Connect (OIDC)**.
1. В блоке **Настройки федерации**:
    1. В поле **Имя** задайте имя федерации, например `identity-hub-oidc`.
    1. (Опционально) В поле **Описание** задайте описание федерации.
    1. В поле **Время жизни сессии** задайте время жизни сессии или оставьте значение по умолчанию — 24 часа.
1. В блоке **Настройки IDP** укажите параметры интеграции:

    * **IdP Issuer** — `https://auth.yandex.cloud`.
    * **Client ID** — значение поля **ClientID**, скопированное на предыдущем этапе.
    * **Client secret** — секрет приложения, сохраненный на предыдущем этапе.
    * **Auth URL** — `https://auth.yandex.cloud/oauth/authorize`.
    * **Token URL** — `https://auth.yandex.cloud/oauth/token`.
    * **JWKS URI** — `https://auth.yandex.cloud/oauth/jwks/keys`.

1. Отключите опцию **Автосоздание пользователей**, если она включена.
1. Нажмите **Создать федерацию**.
1. На странице созданной федерации скопируйте ее идентификатор из поля **ID**.

### Настройте приложение в Yandex Identity Hub {#setup-idp}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Вернитесь в [Yandex Identity Hub](https://center.yandex.cloud/organization), выберите раздел **Приложения** и откройте приложение `selectel-oidc`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
      1. В поле **Redirect URI** укажите адрес:

          ```text
          https://api.selectel.ru/v1/auth/federations/oidc/<идентификатор_федерации>/callback
          ```

          Где `<идентификатор_федерации>` — идентификатор федерации, созданной в Selectel на предыдущем этапе.
      1. В блоке **Безопасность OAuth/OIDC** в поле **Authentication methods** оставьте выбранными оба способа передачи секрета: `Client secret basic` и `Client secret post`.
      1. В блоке **Безопасность OAuth/OIDC** отключите опцию **Требовать PKCE**.

          {% note alert %}

          Для интеграции с Selectel приложение Yandex Identity Hub не должно требовать использования расширения безопасности [PKCE](../../../organization/concepts/applications/oidc.md#pkce) при обмене данными.

          {% endnote %}

      1. В поле **Scopes** выберите атрибуты `openid`, `email` и `profile`.
      1. Нажмите **Сохранить**.

{% endlist %}

### Добавьте пользователей {#add-users}

Добавьте пользователей в OIDC-приложение Yandex Identity Hub и в федерацию Selectel.

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь с [ролью](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) `organization-manager.oauthApplications.userAdmin` или выше.

{% endnote %}

#### Добавьте пользователей в OIDC-приложение {#add-users-idp}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

Чтобы добавить пользователей:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Откройте приложение `selectel-oidc` в [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. Перейдите на вкладку **Пользователи и группы**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
  1. В открывшемся окне выберите пользователя или [группу пользователей](../../../organization/concepts/groups.md).
  1. Нажмите **Добавить**.

{% endlist %}

#### Добавьте пользователей в Selectel {#add-users-sp}

Чтобы добавить пользователя в федерацию Selectel:

1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) в Yandex Identity Hub.
1. В [панели управления Selectel](https://my.selectel.ru/iam/users) в верхнем меню выберите **IAM** и перейдите в раздел **Пользователи панели**.
1. Нажмите **Добавить пользователя панели**.
1. В блоке **Данные пользователя**:
    1. В поле **Способ входа** выберите **Федерация (<имя_федерации>)**.
    1. В поле **External ID** укажите ID пользователя, полученный на первом шаге.
    1. В поле **Почта** укажите адрес электронной почты пользователя.
1. В блоке **Настройки доступа** выберите область доступа и назначьте пользователю необходимые [разрешения](https://docs.selectel.ru/access-control/permissions/).
1. Нажмите **Добавить пользователя**.

## Проверьте работу единого входа {#validate}

Чтобы проверить интеграцию, выполните вход в Selectel от имени пользователя, добавленного в OIDC-приложение:

1. Откройте [страницу входа в Selectel](https://my.selectel.ru/login/).
1. Если вы уже вошли в Selectel, выйдите из учетной записи.
1. Нажмите **Войти с помощью SSO**.
1. Введите идентификатор созданной федерации Selectel и нажмите **Войти по SSO**.
1. На странице аутентификации Yandex Cloud войдите в учетную запись пользователя. Пользователь должен быть добавлен в OIDC-приложение или состоять в группе, добавленной в приложение.
1. Если при первом входе Selectel запросит ФИО, укажите его и нажмите **Войти по SSO**.
1. Убедитесь, что вы вошли в Selectel.