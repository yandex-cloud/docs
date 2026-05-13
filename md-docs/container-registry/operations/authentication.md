# Аутентифицироваться в Container Registry

Перед началом работы с Container Registry необходимо [настроить Docker](configure-docker.md) и аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../iam/concepts/access-control/roles.md) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Docker CLI** или **Yandex Managed Service for Kubernetes** минимально необходимая роль на [реестр](../concepts/registry.md) или [репозиторий](../concepts/repository.md) — `container-registry.images.puller`.

Назначьте нужную роль пользователю Yandex Cloud. Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [Управление доступом в Container Registry](../security/index.md).


## Способы аутентификации {#method}

Вы можете аутентифицироваться:

* [Как пользователь](#user):
  * С помощью OAuth-токена (срок жизни — год).
  * С помощью IAM-токена (срок жизни — не более 12 часов).

* [С помощью хранилища учетных данных Docker Credential helper](#cred-helper).

## Аутентифицироваться как пользователь {#user}

{% list tabs group=registry_auth %}

- С помощью OAuth-токена {#oauth-token}

  {% note info %}

  Срок жизни OAuth-токена — 1 год. После этого необходимо [получить новый OAuth-токен](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и повторить процедуру аутентификации.

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](configure-docker.md) его.
  1. Если у вас еще нет OAuth-токена, получите его по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
  1. Выполните команду:

     ```bash
     echo <OAuth-токен>|docker login \
       --username oauth \
       --password-stdin \
      cr.yandex
     ```

      Где:
      * `<OAuth-токен>` — тело полученного ранее OAuth-токена.
      * `--username` — тип токена: значение `oauth` указывает на то, что для аутентификации используется OAuth-токен.
      * `cr.yandex` — эндпоинт, к которому будет обращаться [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

- С помощью IAM-токена {#iam-token}

  {% note info %}

  У IAM-токена короткое [время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

  {% endnote %}

  1. Если у вас не установлен Docker, [установите](configure-docker.md) его.
  1. [Получите IAM-токен](../../iam/operations/iam-token/create.md).
  1. Выполните команду:

      ```bash
      echo <IAM-токен>|docker login \
        --username iam \
        --password-stdin \
        cr.yandex
      ```

      Где:
      * `<IAM-токен>` — тело полученного ранее IAM-токена.
      * `--username` — тип токена: значение `iam` указывает на то, что для аутентификации используется IAM-токен.
      * `cr.yandex` — эндпоинт, к которому будет обращаться [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

{% endlist %}

При выполнении команды вы можете получить сообщение об ошибке: `docker login is not supported with yc credential helper`.

В этом случае [отключите Docker Credential helper](#ch-not-use). Подробнее см. в разделе [Решение проблем в Container Registry](../error/index.md).

## Аутентифицироваться с помощью Docker Credential helper {#cred-helper}

Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Это безопаснее, чем хранить их в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

В состав [Yandex Cloud CLI](../../cli/quickstart.md) входит утилита `docker-credential-yc`, которая выступает в роли Docker Credential helper для Yandex Cloud. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами Yandex Cloud, не выполняя команду `docker login`.

### Настройка Credential helper {#ch-setting}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
   "cr.yandex": "yc"
   ```

1. Docker готов к использованию, например, для [загрузки Docker-образов](docker-image/docker-image-push.md).

### Дополнительные опции Credential helper {#ch-feature}

#### Использовать Credential helper для другого профиля Yandex Cloud CLI {#ch-profile}

Вы можете использовать Credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc container registry configure-docker --profile <имя_профиля>
```

Подробнее об управлении профилями читайте в [пошаговых инструкциях Yandex Cloud CLI](../../cli/operations/index.md#profile).

#### Не использовать Credential helper {#ch-not-use}

Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `cr.yandex`.