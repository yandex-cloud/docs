[Документация Yandex Cloud](../../index.md) > [Yandex Container Registry](../index.md) > [Практические руководства](index.md) > Миграция в Yandex Cloud Registry

# Миграция с Container Registry на Cloud Registry

{% note warning %}

С 13 октября 2026 года сервис Yandex Container Registry будет недоступен для новых пользователей.

Текущие пользователи могут создавать ресурсы до 10 ноября 2026 года. После сервис перейдет в режим read-only, а 14 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../sunset.md).

{% endnote %}

Миграцию можно запустить двумя способами:

* **По каталогу** — переносятся все реестры указанного [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
* **По облаку** — переносятся все реестры во всех каталогах указанного [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud).

Миграция запускается одновременно для всех реестров в каталоге или облаке. Запустить ее только для части реестров нельзя. Если в каталоге или облаке есть ненужные реестры, предварительно удалите их.

Идентификаторы реестров и адреса Docker-образов сохраняются, поэтому менять ссылки на Docker-образы после миграции не нужно.

Во время миграции переносятся все метаданные и данные из Container Registry в Cloud Registry:
* метаданные реестра;
* настройки прав доступа (права доступа на реестр и репозитории в реестре);
* политики доступа для IP-адресов;
* политики жизненного цикла;
* настройки сканирования;
* алиасы для реестров.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

1. В зависимости от выбранного способа миграции получите идентификатор каталога или облака и сохраните его в переменную:

    * Для миграции по каталогу — [получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md) и сохраните его в переменную `FOLDER_ID`:

        ```bash
        export FOLDER_ID="<идентификатор_каталога>"
        ```

    * Для миграции по облаку — [получите идентификатор облака](../../resource-manager/operations/cloud/get-id.md) и сохраните его в переменную `CLOUD_ID`:

        ```bash
        export CLOUD_ID="<идентификатор_облака>"
        ```

1. [Назначьте](../../iam/operations/roles/grant.md) на каталог или облако (в зависимости от выбранного способа миграции) следующие [роли](../../iam/concepts/access-control/roles.md):

    * `cloud-registry.registries.migrationRunner` — для [субъекта](../../iam/concepts/access-control/index.md#subject) ([пользователя](../../iam/concepts/users/accounts.md) или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md)), который будет запускать миграцию. Роль включает разрешения на запуск миграции (`cloud-registry.registries.startMigration`) и просмотр ее статуса (`cloud-registry.registries.getMigrationStatus`).

        Роль должен назначить владелец или администратор ресурса.

    * `cloud-registry.registries.migrationViewer` — для субъектов, которым нужно только отслеживать статус миграции.

    * `container-registry.images.puller` и `container-registry.images.pusher` — для субъектов, которые будут выполнять проверочные Docker pull и push. Роли миграции не дают доступ к Docker-образам.

    Подробнее о назначении ролей читайте в разделе [Назначение роли](../../iam/operations/roles/grant.md).

## Запустите миграцию {#start-migration}

Рекомендуем использовать параметр `--async` — команда вернет идентификатор операции и не будет ждать ее завершения.

{% list tabs group=migration_scope %}

- По каталогу {#folder}

    ```bash
    yc cloud-registry v1 migration start-folder "$FOLDER_ID" \
      --profile <имя_профиля> \
      --async \
      --format json
    ```

- По облаку {#cloud}

    ```bash
    yc cloud-registry v1 migration start-cloud "$CLOUD_ID" \
      --profile <имя_профиля> \
      --async \
      --format json
    ```

{% endlist %}

В ответе будет поле `id` — идентификатор операции.

{% note warning %}

Прежде чем запускать команду повторно, проверьте статус уже запущенной операции.

{% endnote %}

Чтобы получить статус операции, выполните команду:

```bash
yc cloud-registry v1 operation get <идентификатор_операции> --profile <имя_профиля>
```

Миграция завершилась, если завершилась операция. Перенос данных можно отслеживать на [дашборде миграции](#check-overall-status).

### Управление редиректами при запуске миграции {#disable-redirects-on-start}

По умолчанию после запуска миграции для реестров включаются редиректы: все запросы к `cr.yandex` перенаправляются в Cloud Registry. Это позволяет продолжать использовать прежний адрес без изменений в инфраструктуре.

Если такое поведение не подходит и вы хотите сразу разделить трафик — запросы к `cr.yandex` направлять в Container Registry, а запросы к `registry.yandexcloud.net` — в Cloud Registry, запустите миграцию с параметром `--disable-redirects`:

{% list tabs group=migration_scope %}

- По каталогу {#folder}

    ```bash
    yc cloud-registry v1 migration start-folder "$FOLDER_ID" \
      --profile <имя_профиля> \
      --disable-redirects \
      --async \
      --format json
    ```

- По облаку {#cloud}

    ```bash
    yc cloud-registry v1 migration start-cloud "$CLOUD_ID" \
      --profile <имя_профиля> \
      --disable-redirects \
      --async \
      --format json
    ```

{% endlist %}

При отключенных редиректах Container Registry и Cloud Registry работают как две независимые копии данных. В такой конфигурации в своей инфраструктуре сразу обновите ссылки с `cr.yandex` на `registry.yandexcloud.net`.

Редиректы можно включить или выключить и позже. Подробнее в разделе [Управляйте редиректами после миграции](#toggle-redirects).

## Посмотрите статус миграции {#check-overall-status}

Дашборд миграции показывает общий статус, счетчики реестров, репозиториев и тегов, а также объекты с ошибками и объекты, которые еще переносятся.

Чтобы открыть дашборд, выполните команду:

{% list tabs group=migration_scope %}

- По каталогу {#folder}

    ```bash
    yc cloud-registry v1 migration get-folder-migration-status-dashboard "$FOLDER_ID" \
      --profile <имя_профиля>
    ```

- По облаку {#cloud}

    ```bash
    yc cloud-registry v1 migration get-cloud-migration-status-dashboard "$CLOUD_ID" \
      --profile <имя_профиля>
    ```

{% endlist %}

Значения статусов:

| Статус | Значение |
|---|---|
| `CREATED` | Объект добавлен в очередь миграции |
| `SCHEDULED` | Миграция объекта запланирована |
| `IN_PROGRESS` | Данные переносятся |
| `COMPLETED` | Миграция завершена |
| `FAILED` | Миграция завершилась ошибкой |

Миграция завершена успешно, если:

* общий статус — `COMPLETED`;
* `failed` равен `0` для реестров, репозиториев и тегов;
* `completed` равен `total`.

Поведение запросов Docker pull и push зависит от статуса миграции:

* `CREATED` — запросы Docker pull идут в Container Registry. Запросы Docker push могут временно завершаться ошибкой `429 Too Many Requests` с заголовком `Retry-After` — повторите запрос через указанное время.
* `SCHEDULED` — все запросы Docker pull и push перенаправляются в Cloud Registry.

## Управляйте редиректами после миграции {#toggle-redirects}

Режим редиректов можно менять уже после запуска миграции: для отдельного реестра, для всех реестров каталога или для всех реестров облака. Используйте флаг `--enabled`:
* `true` — редиректы включены, запросы к `cr.yandex` идут в Cloud Registry;
* `false` — редиректы отключены, запросы к `cr.yandex` продолжают идти в Container Registry).

{% list tabs group=redirect_scope %}

- Реестр {#registry}

    ```bash
    yc cloud-registry v1 migration toggle-registry-redirects <идентификатор_реестра> \
      --profile <имя_профиля> \
      --enabled=<true_или_false>
    ```

- Каталог {#folder}

    ```bash
    yc cloud-registry v1 migration toggle-folder-redirects "$FOLDER_ID" \
      --profile <имя_профиля> \
      --enabled=<true_или_false>
    ```

- Облако {#cloud}

    ```bash
    yc cloud-registry v1 migration toggle-cloud-redirects "$CLOUD_ID" \
      --profile <имя_профиля> \
      --enabled=<true_или_false>
    ```

{% endlist %}

## Проверьте Docker pull и push {#check-docker-pull-push}

Если редиректы:
* включены, вы можете продолжать использовать прежний адрес Container Registry — `cr.yandex`.
* отключены, используйте адрес Cloud Registry — `registry.yandexcloud.net`.

Сохраните идентификатор реестра в переменную `REGISTRY_ID`:

```bash
export REGISTRY_ID="<идентификатор_реестра>"
```

Сохраните имя репозитория в переменную `REPOSITORY_NAME`:

```bash
export REPOSITORY_NAME="<имя_репозитория>"
```

Сохраните имя локального Docker-образа в переменную `LOCAL_IMAGE`:

```bash
export LOCAL_IMAGE="<имя_Docker-образа>"
```

Сохраните тег Docker-образа в переменную `TAG`:

```bash
export TAG="<тег>"
```

Проверьте, что команды Docker pull и push выполняются:

```bash
yc iam create-token --profile <имя_профиля> \
  | docker login --username iam --password-stdin cr.yandex

docker pull \
  "cr.yandex/$REGISTRY_ID/$REPOSITORY_NAME:$TAG"

docker tag "$LOCAL_IMAGE" \
  "cr.yandex/$REGISTRY_ID/migration-check:test"

docker push \
  "cr.yandex/$REGISTRY_ID/migration-check:test"
```

Хеш скачанного образа должен совпадать с хешем до миграции. Новый тег после выполнения команды Docker push должен отображаться в Cloud Registry.

## Если миграция завершилась ошибкой {#contact-support}

Если миграция завершилась ошибкой, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и приложите:

* идентификатор каталога или облака, для которого запускалась миграция;
* дашборд миграции в формате JSON;
* время ошибки и request ID, если он есть в выводе CLI.