---
title: "Аутентифицироваться в {{ container-registry-full-name }}"
description: "Перед началом работы с {{ container-registry-name }}, необходимо аутентифицироваться для соответствующего интерфейса." 
---

# Аутентифицироваться в {{ container-registry-name }}

Перед началом работы с {{ container-registry-name }}, необходимо аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../iam/concepts/access-control/roles.md) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Docker CLI** или **{{ managed-k8s-full-name }}** минимально необходимая роль на [реестр](../concepts/registry.md) или [репозиторий](../concepts/repository.md) — `container-registry.images.puller`.

Назначьте нужную роль пользователю {{ yandex-cloud }} или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md). Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [{#T}](../security/index.md).

## Способы аутентификации {#method}

Вы можете аутентифицироваться:


* Как пользователь:
  * [С помощью OAuth-токена](#user-oauth) (срок жизни **год**).
  * [С помощью {{ iam-full-name }}-токена](#user-iam) (срок жизни не больше **{{ iam-token-lifetime }}**).



* [С помощью хранилища учетных данных Docker Credential helper](#cred-helper).

Команда для аутентификации выглядит следующим образом:

```bash
docker login \
  --username <тип_токена> \
  --password <токен> \
  {{ registry }}
```

Где:
* `--username` — тип токена. Допустимые значения: `oauth`, `iam` или `json_key`.
* `--password` — тело токена.
* `{{ registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

## Аутентифицироваться как пользователь {#user}


### Аутентификация с помощью OAuth-токена {#user-oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
1. Выполните команду:

   ```bash
   docker login \
     --username oauth \
     --password <OAuth-токен> \
     {{ registry }}
   ```


### Аутентификация с помощью {{ iam-name }}-токена {#user-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Получите {{ iam-name }}-токен](../../iam/operations/iam-token/create.md).
1. Выполните команду:

   ```bash
   docker login \
     --username iam \
     --password <IAM-токен> \
     {{ registry }}
   ```

## Аутентифицироваться с помощью Docker Credential helper {#cred-helper}

Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Это безопаснее, чем хранить их в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

В состав {{ yandex-cloud }} CLI входит утилита `docker-credential-yc`, которая выступает в роли Docker Credential helper для {{ yandex-cloud }}. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`. Этот способ аутентификации поддерживает использование от имени пользователя и от имени сервисного аккаунта.

### Настройка Credential helper {#ch-setting}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Сконфигурируйте Docker для использования `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Результат:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Настройки сохраняются в профиле текущего пользователя.

   {% note warning %}

   Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Проверьте, что Docker сконфигурирован.

   В конфигурационном файле `${HOME}/.docker/config.json` должна появиться строка:

   ```json
   "{{ registry }}": "yc"
   ```

1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md).

### Дополнительные опции Credential helper {#ch-feature}

#### Использовать Credential helper для другого профиля {{ yandex-cloud }} CLI {#ch-profile}

Вы можете использовать Credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc container registry configure-docker --profile <имя_профиля>
```

Подробнее об управлении профилями читайте в [пошаговых инструкциях {{ yandex-cloud }} CLI](../../cli/operations/index.md#profile).

#### Не использовать Credential helper {#ch-not-use}

Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `{{ registry }}`.