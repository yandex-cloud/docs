---
title: Аутентифицироваться в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете аутентифицироваться для нужного интерфейса.
---

# Аутентифицироваться в {{ cloud-registry-name }}

Перед началом работы с {{ cloud-registry-name }} необходимо [настроить Docker](installation.md) и аутентифицироваться для соответствующего интерфейса:
* Для консоли управления минимально необходимая [роль](../../../iam/concepts/access-control/roles.md) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для Docker CLI или {{ managed-k8s-full-name }} минимально необходимая роль на [реестр](../../concepts/registry.md) — `cloud-registry.artifacts.puller`.

Назначьте нужную роль пользователю {{ yandex-cloud }}. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [{#T}](../../security/index.md).

## Способы аутентификации {#method}

Вы можете аутентифицироваться:

* [Как пользователь](#user):
  * С помощью IAM-токена. Время жизни — не более {{ iam-token-lifetime }}.
  * С помощью API-ключа и сервисного аккаунта. [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.

* [С помощью хранилища учетных данных Docker credential helper](#cred-helper).

## Аутентифицироваться как пользователь {#user}

{% list tabs group=registry_auth %}

- С помощью IAM-токена {#iam-token}

  {% note info %}

  {% include [iam-token-note](../../../_includes/iam/iam-token-note.md) %}

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. [Получите](../../../iam/operations/iam-token/create.md) IAM-токен.
  1. Выполните команду:

      ```bash
      echo <IAM-токен> | docker login \
        --username iam \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Где:
      * `<IAM-токен>` — тело полученного ранее IAM-токена.
      * `--username` — тип токена: значение `iam` указывает, что для аутентификации используется IAM-токен.
      * `{{ cloud-registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром Docker-образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

- С помощью API-ключа {#api-key}

  1. Если у вас не установлен Docker, [установите](installation.md) его.
  1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
  1. Выполните команду:

      ```bash
      echo <API-ключ> | docker login \
        --username api_key \
        --password-stdin \
        {{ cloud-registry }}
      ```

      Где:
      * `<API-ключ>` — тело созданного ранее API-ключа.
      * `--username` — тип токена: значение `api_key` указывает, что для аутентификации используется API-ключ.
      * `{{ cloud-registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

{% endlist %}

Если при выполнении команды вы получили сообщение об ошибке `docker login is not supported with yc credential helper`, [отключите Docker credential helper](#ch-not-use).

## Аутентифицироваться с помощью Docker credential helper {#cred-helper}

Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Такой способ безопаснее, чем хранение учетных данных в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

В состав [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) входит утилита `docker-credential-yc`, которая выступает в роли Docker credential helper для {{ yandex-cloud }}. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`.

### Настройка credential helper {#ch-setting}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Сконфигурируйте Docker для использования `docker-credential-yc`:

   ```bash
   yc cloud-registry configure-docker
   ```

   Результат:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Настройки сохраняются в профиле текущего пользователя.

   {% include [credential-helper](../../../_includes/credential-helper.md) %}

1. Проверьте, что Docker сконфигурирован.

   В конфигурационном файле `${HOME}/.docker/config.json` должна появиться строка:

   ```json
   "{{ cloud-registry }}": "yc"
   ```

1. Docker готов к использованию, например, для [загрузки Docker-образов](push.md).

### Дополнительные опции credential helper {#ch-feature}

#### Использовать credential helper для другого профиля {{ yandex-cloud }} CLI {#ch-profile}

Вы можете использовать credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc cloud-registry configure-docker --profile <имя_профиля>
```

Подробнее об управлении профилями читайте в [пошаговых инструкциях {{ yandex-cloud }} CLI](../../../cli/operations/index.md#profile).

#### Не использовать credential helper {#ch-not-use}

Чтобы не использовать credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку с доменом `{{ cloud-registry }}`.
