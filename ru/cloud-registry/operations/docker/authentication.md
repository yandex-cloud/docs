# Аутентифицировать в {{ cloud-registry-name }}

Перед началом работы с {{ cloud-registry-name }} необходимо [настроить Docker](installation.md) и аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../../iam/concepts/access-control/roles.md) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Docker CLI** или **{{ managed-k8s-full-name }}** минимально необходимая роль на [реестр](../../concepts/registry.md) `cloud-registry.artifacts.puller`.

Назначьте нужную роль пользователю {{ yandex-cloud }}. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [{#T}](../../security/index.md).

## Способы аутентификации {#method}

Вы можете аутентифицироваться:

* [Как пользователь](#user):
  * С помощью OAuth-токена (срок жизни — год).
  * С помощью IAM-токена (срок жизни — не более {{ iam-token-lifetime }}).


## Аутентифицироваться как пользователь {#user}

{% list tabs group=registry_auth %}

- С помощью OAuth-токена {#oauth-token}

  {% note info %}

  {% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
  1. Выполните команду:

     ```bash
     echo <OAuth-токен>|docker login \
       --username oauth \
       --password-stdin \
      {{ cloud-registry }}
     ```

      Где:
      * `<OAuth-токен>` — тело полученного ранее OAuth-токена.
      * `--username` — тип токена: значение `oauth` указывает на то, что для аутентификации используется OAuth-токен.
      * `{{ cloud-registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

- С помощью IAM-токена {#iam-token}

  {% note info %}

  {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. [Получите IAM-токен](../../../iam/operations/iam-token/create.md).
  1. Выполните команду:

      ```bash
      echo <IAM-токен>|docker login \
        --username iam \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Где:
      * `<IAM-токен>` — тело полученного ранее IAM-токена.
      * `--username` — тип токена: значение `iam` указывает на то, что для аутентификации используется IAM-токен.
      * `{{ cloud-registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

{% endlist %}

При выполнении команды вы можете получить сообщение об ошибке: `docker login is not supported with yc credential helper`. В этом случае отключите Docker credential helper.

