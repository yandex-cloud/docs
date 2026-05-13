# Аутентифицировать в Cloud Registry

Перед началом работы с Cloud Registry необходимо [настроить Docker](installation.md) и аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../../iam/concepts/access-control/roles.md) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Docker CLI** или **Yandex Managed Service for Kubernetes** минимально необходимая роль на [реестр](../../concepts/registry.md) `cloud-registry.artifacts.puller`.

Назначьте нужную роль пользователю Yandex Cloud. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [Управление доступом в Yandex Cloud Registry](../../security/index.md).

## Способы аутентификации {#method}

Вы можете аутентифицироваться:

* [Как пользователь](#user):
  * С помощью IAM-токена. Время жизни — не больше 12 часов.
  * С помощью OAuth-токена. Время жизни — 1 год.
  * С помощью API-ключа и сервисного аккаунта. [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.


## Аутентифицироваться как пользователь {#user}

{% list tabs group=registry_auth %}

- С помощью IAM-токена {#iam-token}

  {% note info %}

  У IAM-токена короткое [время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен.
  1. Выполните команду:

      ```bash
      echo <IAM-токен> | docker login \
        --username iam \
        --password-stdin \
        registry.yandexcloud.net
      ```

      Где:
      * `<IAM-токен>` — тело полученного ранее IAM-токена.
      * `--username` — тип токена: значение `iam` указывает на то, что для аутентификации используется IAM-токен.
      * `registry.yandexcloud.net` — эндпоинт, к которому будет обращаться [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

- С помощью OAuth-токена {#oauth-token}

  {% note info %}

  Срок жизни OAuth-токена — 1 год. После этого необходимо [получить новый OAuth-токен](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и повторить процедуру аутентификации.

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. Если у вас еще нет OAuth-токена, получите его по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
  1. Выполните команду:

     ```bash
     echo <OAuth-токен> | docker login \
       --username oauth \
       --password-stdin \
      registry.yandexcloud.net
     ```

      Где:
      * `<OAuth-токен>` — тело полученного ранее OAuth-токена.
      * `--username` — тип токена: значение `oauth` указывает на то, что для аутентификации используется OAuth-токен.
      * `registry.yandexcloud.net` — эндпоинт, к которому будет обращаться [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

- С помощью API-ключа {#api-key}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
  1. Выполните команду:

      ```bash
      echo <API-ключ> | docker login \
        --username api_key \
        --password-stdin \
        registry.yandexcloud.net
      ```

      Где:
      * `<API-ключ>` — тело созданного ранее API-ключа.
      * `--username` — тип токена: значение `api_key` указывает на то, что для аутентификации используется API-ключ.
      * `registry.yandexcloud.net` — эндпоинт, к которому будет обращаться [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

{% endlist %}

При выполнении команды вы можете получить сообщение об ошибке: `docker login is not supported with yc credential helper`. В этом случае отключите Docker credential helper.