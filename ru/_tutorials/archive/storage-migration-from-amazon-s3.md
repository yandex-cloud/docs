# Миграция данных из Amazon S3 в {{ objstorage-full-name }} с помощью rclone

В этом практическом руководстве вы перенесете содержимое бакета Amazon S3 в бакет [{{ objstorage-full-name }}](../../storage/) с помощью [rclone](../../storage/tools/rclone.md) и переведете приложение на новое хранилище.

{{ objstorage-name }} совместим с [Amazon S3 API](../../storage/s3/index.md), поэтому переносить данные можно любой утилитой, которая умеет работать сразу с двумя S3-совместимыми хранилищами. [Rclone](https://rclone.org/) для этого удобен тем, что описывает оба хранилища как отдельные подключения и копирует объекты напрямую между ними, не сохраняя их на диск целиком.

Особенности переноса с помощью rclone:

* Копируются текущие версии объектов. Предыдущие [версии](../../storage/concepts/versioning.md), [метки](../../storage/concepts/tags.md) и [ACL](../../storage/concepts/acl.md) объектов не переносятся.
* Пользовательские метаданные и заголовок `Content-Type` сохраняются.
* Повторный запуск копирует только то, что изменилось, поэтому перенос можно выполнять в несколько заходов и держать бакеты синхронными до момента переключения приложения.
* Работает на Linux, Windows и macOS.

Чтобы перенести данные:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Подготовьте доступ к бакету в Amazon S3](#prepare-source).
1. [Установите rclone](#install-rclone).
1. [Настройте подключения к хранилищам](#configure-rclone).
1. [Перенесите данные](#migrate).
1. [Проверьте результат](#check).
1. [Переключите приложение на {{ objstorage-name }}](#switch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета входит плата за хранение данных в бакете и операции с ними ([тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).

Входящий трафик из интернета в {{ objstorage-name }} не тарифицируется, но исходящий трафик из хранилища-источника может тарифицироваться его провайдером — уточните тарифы Amazon S3 до начала переноса.

## Создайте бакет {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Укажите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Создайте бакет, указав имя в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming):

  ```bash
  yc storage bucket create --name <имя_бакета>
  ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
  1. Создайте бакет:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }} \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```text
      make_bucket: migration-bucket
      ```

{% endlist %}

Имя бакета в {{ objstorage-name }} не обязано совпадать с именем бакета в Amazon S3, но если оно совпадает, приложению при переключении достаточно поменять только эндпоинт и ключи доступа.

{% note info %}

Если в бакете-источнике объекты лежат в разных классах хранения, задайте бакету-приемнику [класс хранилища по умолчанию](../../storage/concepts/storage-class.md#default-storage-class) при создании в консоли управления. Rclone не переносит класс хранения объекта — все объекты будут записаны в класс, заданный для бакета или в настройках подключения.

{% endnote %}

## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будут записываться данные в {{ objstorage-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `sa-s3-migration`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../storage/security/index.md#storage-editor) `storage.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create --name sa-s3-migration
      ```

      Результат:

      ```yaml
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: sa-s3-migration
      ```

  1. Назначьте сервисному аккаунту [роль](../../storage/security/index.md#storage-editor) `storage.editor` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <имя_каталога> \
        --service-account-name sa-s3-migration \
        --role storage.editor
      ```

- API {#api}

  1. Создайте сервисный аккаунт `sa-s3-migration`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роль](../../storage/security/index.md#storage-editor) `storage.editor`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

{% note info %}

{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}

{% endnote %}

## Создайте статический ключ доступа {#create-static-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `sa-s3-migration`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните полученные идентификатор и секретный ключ — они понадобятся при настройке rclone.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

  1. Выполните команду:

      ```bash
      yc iam access-key create \
        --service-account-name sa-s3-migration
      ```

      Результат:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся при настройке rclone.

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

  Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся при настройке rclone.

{% endlist %}

## Подготовьте доступ к бакету в Amazon S3 {#prepare-source}

Для переноса достаточно доступа на чтение. Подготовьте на стороне Amazon S3 ключ доступа, которому разрешены:

* `s3:ListBucket` — на бакет-источник;
* `s3:GetObject` — на объекты бакета-источника.

Также запишите регион бакета-источника: он понадобится в настройках подключения.

{% note tip %}

Для переноса заведите отдельный ключ доступа и удалите его после миграции. Так вы не будете использовать в утилите ключ, от которого зависят рабочие приложения.

{% endnote %}

## Установите rclone {#install-rclone}

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Установите последнюю версию rclone:

      ```bash
      sudo -v ; curl https://rclone.org/install.sh | sudo bash
      ```

      Подробнее о команде смотрите в [документации rclone](https://rclone.org/install/).

  1. Убедитесь, что утилита установлена:

      ```bash
      rclone version
      ```

- Windows {#windows}

  1. Скачайте с сайта производителя [архив с утилитой rclone](https://rclone.org/downloads/) и распакуйте его в удобную папку на локальном компьютере.
  1. Добавьте папку с утилитой в переменную `PATH`, чтобы вызывать ее из любого места в командной строке.
  1. Убедитесь, что утилита установлена:

      ```bash
      rclone version
      ```

{% endlist %}

{% note info %}

Переносить данные удобнее не с локального компьютера, а с [виртуальной машины](../../compute/concepts/vm.md) в {{ yandex-cloud }}: трафик до {{ objstorage-name }} останется внутри облака, а канал до Amazon S3 будет стабильнее домашнего или офисного.

{% endnote %}

## Настройте подключения к хранилищам {#configure-rclone}

Rclone хранит подключения в файле `rclone.conf`. Подключения можно создать в диалоговом режиме командой `rclone config` или добавить в файл вручную — во втором случае проще завести сразу два подключения.

1. Узнайте расположение файла конфигурации:

    ```bash
    rclone config file
    ```

1. Добавьте в файл два подключения:

    ```ini
    [aws-s3]
    type = s3
    provider = AWS
    access_key_id = <идентификатор_ключа_Amazon_S3>
    secret_access_key = <секретный_ключ_Amazon_S3>
    region = <регион_бакета_в_Amazon_S3>

    [yc-s3]
    type = s3
    provider = AWS
    access_key_id = <идентификатор_статического_ключа>
    secret_access_key = <секретный_ключ>
    region = {{ region-id }}
    endpoint = https://{{ s3-storage-host }}
    ```

    Где:

    * `[aws-s3]` и `[yc-s3]` — имена подключений, вы будете указывать их в командах.
    * `access_key_id` и `secret_access_key` — идентификатор и значение ключа доступа: для `[yc-s3]` это статический ключ сервисного аккаунта, созданный на предыдущем шаге.
    * `region` — регион хранилища. Для {{ objstorage-name }} укажите `{{ region-id }}`.
    * `endpoint` — [эндпоинт](../../storage/s3/index.md) {{ objstorage-name }}. Для Amazon S3 эндпоинт не указывается, rclone определит его по региону.

    Чтобы объекты записывались в бакет-приемник не в стандартном, а в другом [классе хранилища](../../storage/concepts/storage-class.md), добавьте в секцию `[yc-s3]` параметр `storage_class` со значением `COLD`, `ICE` или `INTELLIGENT_TIERING`.

1. Проверьте оба подключения:

    ```bash
    rclone lsd aws-s3:
    rclone lsd yc-s3:
    ```

    Команды выведут списки бакетов, доступных каждому из ключей.

## Перенесите данные {#migrate}

1. Оцените, сколько данных предстоит перенести:

    ```bash
    rclone size aws-s3:<имя_бакета_источника>
    ```

    Результат:

    ```text
    Total objects: 12.480k (12480)
    Total size: 41.284 GiB (44328052293 Byte)
    ```

1. Скопируйте данные:

    ```bash
    rclone copy \
      aws-s3:<имя_бакета_источника> \
      yc-s3:<имя_бакета_приемника> \
      --progress \
      --transfers 16 \
      --checkers 32
    ```

    Где:

    * `copy` — команда копирования: объекты, которых нет в бакете-приемнике или которые в нем отличаются, будут скопированы, лишние объекты не удаляются.
    * `--progress` — выводит ход переноса в терминал.
    * `--transfers` — количество объектов, копируемых одновременно. Значение по умолчанию — `4`.
    * `--checkers` — количество параллельных проверок при сравнении бакетов. Значение по умолчанию — `8`.

    Полезные дополнительные параметры:

    * `--bwlimit <скорость>` — ограничивает полосу, например `20M`. Пригодится, если канал общий с рабочими сервисами.
    * `--s3-chunk-size <размер>` — размер части при [составной загрузке](../../storage/concepts/multipart.md) крупных объектов. Увеличение размера ускоряет перенос больших файлов, но требует больше оперативной памяти: rclone держит в памяти до `--transfers` × `--s3-upload-concurrency` частей.
    * `--exclude <шаблон>` и `--include <шаблон>` — переносят не весь бакет, а часть объектов.
    * `--dry-run` — показывает, что будет перенесено, не копируя данные.

    Перенос можно прервать и запустить заново: уже скопированные объекты повторно не передаются.

1. Если приложение продолжает писать в бакет-источник, перед переключением выполните финальную синхронизацию:

    ```bash
    rclone sync \
      aws-s3:<имя_бакета_источника> \
      yc-s3:<имя_бакета_приемника> \
      --progress
    ```

    {% note warning %}

    Команда `sync` приводит бакет-приемник в точное соответствие с источником и удаляет из него объекты, которых нет в источнике. Если в бакет-приемник уже пишут другие процессы, используйте `copy`.

    {% endnote %}

## Проверьте результат {#check}

1. Сравните бакеты:

    ```bash
    rclone check \
      aws-s3:<имя_бакета_источника> \
      yc-s3:<имя_бакета_приемника> \
      --one-way \
      --size-only
    ```

    Где:

    * `--one-way` — проверяет, что все объекты источника есть в приемнике, и не учитывает объекты, которые есть только в приемнике.
    * `--size-only` — сравнивает объекты по размеру. Сравнение по контрольным суммам не подходит для объектов, загруженных [составной загрузкой](../../storage/concepts/multipart.md): у таких объектов `ETag` вычисляется по частям, и его значение зависит от размера части, а он у хранилищ может отличаться.

1. Сравните итоговый объем и количество объектов:

    ```bash
    rclone size yc-s3:<имя_бакета_приемника>
    ```

1. Убедитесь, что объекты видны в {{ objstorage-name }}:

    ```bash
    yc storage bucket stats <имя_бакета>
    ```

## Переключите приложение на {{ objstorage-name }} {#switch}

Чтобы приложение начало работать с новым хранилищем:

1. Замените в конфигурации приложения эндпоинт на `https://{{ s3-storage-host }}`, а регион — на `{{ region-id }}`.
1. Замените ключи доступа Amazon S3 на статический ключ сервисного аккаунта. Храните ключ в [{{ lockbox-full-name }}](../../lockbox/), а не в коде и не в переменных окружения на диске.
1. Если приложение обращалось к объектам по прямым ссылкам, замените в них хост на [адрес бакета](../../storage/concepts/bucket.md#bucket-url).
1. Проверьте, что приложение не использует методы S3 API, которых нет в {{ objstorage-name }}. Перечень поддерживаемых методов приведен в разделе [{#T}](../../storage/s3/index.md).
1. Настройте на бакете-приемнике то, что не переносится вместе с данными: [права доступа](../../storage/operations/buckets/iam-access.md), [политику доступа](../../storage/concepts/policy.md), [версионирование](../../storage/operations/buckets/versioning.md), [жизненные циклы](../../storage/operations/buckets/lifecycles.md) и [конфигурацию CORS](../../storage/operations/buckets/cors.md).

Бакет-источник имеет смысл сохранить до тех пор, пока вы не убедитесь, что приложение стабильно работает с новым хранилищем.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите объекты](../../storage/operations/objects/delete-all.md) из бакета.
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
1. Удалите ключ доступа, созданный для миграции на стороне Amazon S3.
