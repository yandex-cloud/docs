# Аутентифицироваться в {{ container-registry-name }}

Перед тем как начать работу с {{ container-registry-name }}, необходимо пройти аутентификацию для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая роль на каталог — `viewer`.
* Для **Docker CLI** минимально необходимая роль на [реестр](../concepts/registry.md) или [репозиторий](../concepts/repository.md) — `container-registry.images.puller`.

Подробнее про роли читайте в разделе [{#T}](../security/index.md).

Вы можете аутентифицироваться как пользователь или как сервисный аккаунт. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

## Способы аутентификации {#method}

Вы можете аутентифицироваться:

{% if product == "yandex-cloud" %}

* Как пользователь:
  * [С помощью OAuth-токена](#oauth) (срок жизни **год**).
  * [С помощью IAM-токена](#iam) (срок жизни не больше **{{ iam-token-lifetime }}**).

{% endif %}

{% if product == "cloud-il" %}

* Как пользователь [с помощью IAM-токена](#iam) (срок жизни не больше **{{ iam-token-lifetime }}**).

{% endif %}

* Как сервисный аккаунт:
  * [С помощью авторизованных ключей](#sa-json) (неограниченный срок жизни).
  * [C помощью IAM-токена](#sa-iam) (срок жизни не больше **{{ iam-token-lifetime }}**).
* [С помощью хранилища учетных данных Docker Credential helper](#cred-helper).

Команда для аутентификации выглядит следующим образом:

```
docker login \
  --username <тип токена> \
  --password <токен> \
  {{ registry }}
```

Где:

* `<тип токена>` — допустимые значения: {% if product == "yandex-cloud" %}`oauth`, {% endif %}`iam` или `json_key`.
* `<токен>` — сам токен.
* `{{ registry }}` — адрес для аутентификации. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

## Аутентифицироваться как пользователь {#user}

{% if product == "yandex-cloud" %}

### Аутентификация с помощью OAuth-токена {#oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
1. Выполните команду:

   ```
   docker login \
     --username oauth \
     --password <OAuth-токен> \
     {{ registry }}
   ```

{% endif %}

### Аутентификация с помощью IAM-токена {#iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Получите IAM-токен]{% if product == "yandex-cloud" %}(../../iam/operations/iam-token/create.md){% endif %}{% if product == "cloud-il" %}(../../iam/operations/iam-token/create-for-federation.md){% endif %}.
1. Выполните команду:

   ```
   docker login \
     --username iam \
     --password <IAM-токен> \
     {{ registry }}
   ```

## Аутентифицироваться как сервисный аккаунт {#sa}

### Аутентификация с помощью авторизованных ключей {#sa-json}

{% note info %}

Срок жизни авторизованных ключей неограничен, но вы всегда можете получить новые авторизованные ключи и повторить процедуру аутентификации, если что-то пошло не так.

{% endnote %}

Используя [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), ваши программы могут получать доступ к ресурсам {{ yandex-cloud }}. Получите файл с авторизованными ключами для вашего сервисного аккаунта, используя CLI.
1. Получите [авторизованные ключи](../../iam/concepts/users/service-accounts.md#sa-key) для вашего сервисного аккаунта:

   ```bash
   yc iam key create --service-account-name default-sa -o key.json
   ```

   Результат:

   ```bash
   id: aje8a87g4e...
   service_account_id: aje3932acd...
   created_at: "2019-05-31T16:56:47Z"
   key_algorithm: RSA_2048
   ```

1. Выполните команду:

   ```
   cat key.json | docker login \
     --username json_key \
     --password-stdin \
     {{ registry }}
   ```

   Где:

   * `cat key.json` записывает содержимое файла с ключом в поток вывода.
   * `--password-stdin` позволяет читать пароль из потока ввода.

   Результат:

   ```
   Login Succeeded
   ```

### Аутентификация с помощью IAM-токена {#sa-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
1. Выполните команду:

   ```
   docker login \
     --username iam \
     --password <IAM-токен> \
     {{ registry }}
   ```

## Аутентифицироваться с помощью Docker Credential helper {#cred-helper}

Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Это более безопасно, чем хранить их в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

В роли Docker Credential helper для {{ yandex-cloud }} выступает программа `docker-credential-yc`. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`. Этот способ аутентификации поддерживает использование от имени пользователя и от имени сервисного аккаунта. Для работы с `docker-credential-yc` вам понадобится интерфейс командной строки {{ yandex-cloud }}: [YC CLI](../../cli/quickstart.md).

Устанавливать `docker-credential-yc` отдельно не требуется, достаточно установить YC CLI и сконфигурировать Credential helper, как описано ниже.

### Настройка Credential helper {#ch-setting}

1. Если у вас еще нет профиля для YC CLI, [создайте его](../../cli/quickstart.md#initialize).
1. Сконфигурируйте Docker для использования `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Результат:

   ```bash
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Настройки сохраняются в профиле текущего пользователя.

   {% note warning %}

   Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Проверьте, что Docker сконфигурирован.

   В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

   ```json
   "{{ registry }}": "yc"
   ```

1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md). При этом выполнять команду`docker login` не надо.

### Дополнительные опции Credential helper {#ch-feature}

#### Использовать Credential helper для другого профиля YC CLI {#ch-profile}

Вы можете использовать Credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc container registry configure-docker --profile <имя профиля>
```

Подробнее об управлении профилями YC CLI читайте в [пошаговых инструкциях](../../cli/operations/index.md#profile).

#### Не использовать Credential helper {#ch-not-use}

Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `/home/<user>/.docker/config.json` из блока `credHelpers` строку домена `{{ registry }}`.