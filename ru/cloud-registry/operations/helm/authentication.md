---
title: Аутентифицироваться в {{ cloud-registry-full-name }} для Helm
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ cloud-registry-name }} для работы с Helm-чартами.
---

# Аутентифицироваться в {{ cloud-registry-name }}

Перед началом работы с Helm-чартами в {{ cloud-registry-name }} необходимо [установить и настроить Helm](installation.md)

## Способы аутентификации {#method}

## Аутентифицироваться как пользователь {#user}

1. Настройте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

   {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}

1. Выполните команду `helm registry login`, используя настроенные переменные окружения:

   ```bash
   echo "$REGISTRY_PASSWORD" | helm registry login {{ cloud-registry }} \
     -u "$REGISTRY_USERNAME" \
     --password-stdin
   ```

   Где:
   * `$REGISTRY_USERNAME` — переменная окружения, содержащая тип токена (`iam`, `oauth` или `api_key`).
   * `$REGISTRY_PASSWORD` — переменная окружения, содержащая тело токена для аутентификации.
   * `{{ cloud-registry }}` — эндпоинт, к которому будет обращаться Helm при работе с реестром.

   Результат:

   ```text
   Login succeeded
   ```

При выполнении команды вы можете получить сообщение об ошибке, связанной с credential helper. В этом случае [отключите Credential helper](#ch-not-use) или используйте его для аутентификации.

## Аутентифицироваться с помощью Docker Credential helper {#cred-helper}

Helm использует тот же механизм хранения учетных данных, что и Docker — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers). Это безопаснее, чем хранить учетные данные в конфигурационном файле. После настройки Credential helper для Docker, Helm автоматически будет использовать его для аутентификации.

### Настройка Credential helper {#ch-setting}

{% include [cli-install](../../../_includes/cli-install.md) %}

1. Сконфигурируйте Docker для использования утилиты `yc`:

   ```bash
   yc cloud-registry configure-docker
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
   "{{ cloud-registry }}": "yc"
   ```

1. Helm готов к использованию, например, для [загрузки Helm-чартов](push.md).

### Дополнительные опции Credential helper {#ch-feature}

#### Использовать Credential helper для другого профиля {{ yandex-cloud }} CLI {#ch-profile}

Вы можете использовать Credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc cloud-registry configure-docker --profile <имя_профиля>
```

Подробнее об управлении профилями читайте в [пошаговых инструкциях {{ yandex-cloud }} CLI](../../../cli/operations/index.md#profile).

#### Не использовать Credential helper {#ch-not-use}

Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `{{ cloud-registry }}`.
