[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Пошаговые инструкции](index.md) > Серверы > Загрузить свой образ ОС

# Загрузить собственный образ операционной системы

Вы можете добавить [собственный образ](../concepts/images.md#user-images) операционной системы или программного продукта, чтобы иметь возможность самостоятельно установить его на сервер. Для этого нужно сначала загрузить файл образа в [бакет](../../storage/concepts/bucket.md) сервиса Yandex Object Storage.

## Загрузите файл образа в Object Storage {#upload-file}

{% note alert %}

Размер загружаемого в Object Storage файла образа не может превышать 50 ГБ.

{% endnote %}

[Загрузите](image-upload.md#upload-file) ISO-образ в [Yandex Object Storage](../../storage/index.md) и получите ссылку на загруженный объект:

1. Создайте бакет Object Storage:

    {% note info %}

    Чтобы создать [бакет](../../storage/concepts/bucket.md), у вас должна быть _минимальная_ [роль](../../storage/security/index.md#storage-editor) `storage.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).

    {% endnote %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
      1. Перейдите в сервис **Object Storage**.
      1. Справа сверху нажмите **Создать бакет**.
      1. На странице создания бакета:

          1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
          1. При необходимости задайте ограничение на максимальный размер бакета или включите опцию **Без ограничения**.
          1. Значения остальных параметров оставьте без изменения и нажмите **Создать бакет**.

    - Yandex Cloud CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Создайте бакет в каталоге по умолчанию:

          ```bash
          yc storage bucket create --name <имя_бакета>
          ```

          Где `--name` — имя бакета. Обязательный параметр. Подробнее в [Правилах именования бакетов](../../storage/concepts/bucket.md#naming).

          Результат:

          ```text
          name: <имя_бакета>
          folder_id: b1gt6g8ht345********
          anonymous_access_flags: {}
          default_storage_class: STANDARD
          versioning: VERSIONING_DISABLED
          created_at: "2025-08-06T07:29:40.418079Z"
          resource_id: e3e9neva43dl********
          ```

          Подробнее о команде `yc storage bucket create` в [Справочнике Yandex Cloud CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

    {% endlist %}

1. Загрузите скачанный файл с образом в созданный бакет:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      {% note info %}

      Через консоль управления нельзя загрузить объекты размером более 5 ГБ. Подробнее в разделе [Квоты и лимиты в Object Storage](../../storage/concepts/limits.md). Для загрузки больших объектов используйте другие [инструменты](../../storage/tools/index.md).

      {% endnote %}

      1. В [консоли управления](https://console.yandex.cloud) Перейдите в сервис **Object Storage** и перейдите в бакет, в который нужно загрузить образ.
      1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **Объекты** и в правом верхнем углу экрана нажмите кнопку ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить**.
      1. В открывшемся окне выберите файл с образом и нажмите **Открыть**.
      1. В окне загрузки объектов нажмите **Загрузить** и дождитесь завершения загрузки.
      1. Обновите страницу.

    - Yandex Cloud CLI {#cli}

      1. Выполните команду:

          ```bash
          yc storage s3api put-object \
            --body <путь_к_локальному_файлу> \
            --bucket <имя_бакета> \
            --key <путь_к_объекту>
          ```

          Где:

          * `--body` — путь к файлу, который нужно загрузить в бакет. Например: `./ubuntu.iso`.
          * `--bucket` — имя вашего бакета.
          * `--key` — [ключ](../../storage/concepts/object.md#key), по которому объект будет храниться в бакете. Например: `Ubuntu-2404.iso`.

          Результат:

          ```text
          etag: '"87740887a5159e2685500c02********"'
          request_id: 300dceee********
          ```
      Подробнее о команде `yc storage s3api put-object` в [Справочнике Yandex Cloud CLI](../../cli/cli-ref/storage/cli-ref/s3api/put-object.md).

    {% endlist %}

1. Получите ссылку на загруженный в бакет образ:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
      1. Перейдите в сервис **Object Storage** и выберите нужный бакет.
      1. Нажмите на имя объекта с загруженным ISO-образом.
      1. В правом верхнем углу экрана нажмите кнопку ![link](../../_assets/storage/link.svg) **Получить ссылку**.
      1. Нажмите **Получить ссылку**.
      1. Скопируйте полученную ссылку.

    {% endlist %}

## Создайте образ в BareMetal {#create-image}

Создайте новый образ по ссылке, полученной в Object Storage:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать образ.
  1. Перейдите в сервис **BareMetal**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/layers.svg) **Загрузочные образы**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте описание образа.
  1. Вставьте ссылку на образ, полученную в Object Storage.
  1. Нажмите кнопку **Загрузить**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Посмотрите описание команды для загрузки образа:

      ```bash
      yc baremetal boot-image create --help
      ```

   1. Загрузите образ:

      ```bash
      yc baremetal boot-image create \
        --name demo-boot-image \
        --description "Boot image for BareMetal" \
        --uri "<ссылка_на_образ>" \
        --labels <ключ_метки>=<значение_метки>
      ```

      Где:
      * `--name` — имя образа. Требования к имени:
        
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

      * `--description` — описание образа. Необязательный параметр.
      * `--uri` — ссылка на образ, полученная в Object Storage.
      * `--labels` — метки образа. Необязательный параметр.

- API {#api}

  Чтобы создать образ в BareMetal, воспользуйтесь методом REST API [create](../api-ref/Image/create.md) для ресурса [Image](../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../api-ref/grpc/Image/create.md).
  
  Выполните запрос:
  
  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
         "folderId": "b1g07hj5r6i4********",
         "name": "baremetal-ubuntu",
         "description": "New OS Baremetal Image",
         "uri": "https://storage.yandexcloud.net/bm-test-backet/new-server-amd64.iso",
         "labels": {
           "key": "ubuntu"
         }
        }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/images"
  ```
  
  Где:
  
  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `folderId` — идентификатор каталога.
  * `name` — имя образа. Требования к имени:
  
    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.
  
  * `description` — описание образа. Необязательный параметр.
  * `uri` — ссылка на образ, полученная в Object Storage.
  * `labels` — метки образа. Необязательный параметр.
    
  Результат:
  
  ```bash
  {
  "done": false,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreateImageMetadata",
    "imageId": "ly5kr5tjsple********"
  },
  "id": "ly5iwrc2uvuf********",
  "description": "User image create",
  "createdAt": "2025-12-07T20:31:52.845955Z",
  "createdBy": "ajeb9l33h6mu********",
  "modifiedAt": "2025-12-07T20:31:52.845955Z"
  }
  ```
  
    Отслеживайте статус операции по полю `done`.

{% endlist %}

## Удалите образ из Object Storage {#delete-image}

После создания образа можно [удалить файл образа](../../storage/operations/objects/delete.md) из сервиса Object Storage. Также можно [удалить бакет](../../storage/operations/buckets/delete.md), если в нем не осталось объектов.