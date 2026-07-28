---
title: Изменение класса хранилища объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете изменить класс хранилища уже загруженного объекта в {{ objstorage-name }}.
---

# Изменение класса хранилища объекта

[Класс хранилища](../../concepts/storage-class.md) задается для каждого [объекта](../../concepts/object.md) отдельно в момент загрузки. Если при загрузке класс не указан, объект сохраняется в хранилище, которое задано в [настройках бакета](../../concepts/bucket.md#bucket-settings).

У уже загруженного объекта класс хранилища не редактируется отдельной операцией: {{ objstorage-name }} назначает класс только при записи объекта. Чтобы перевести объект в другое хранилище, его копируют с указанием нужного класса — под тем же ключом или под новым.

{% include [changing-storage-class](../../../_includes/storage/changing-storage-class.md) %}

Значения, которые можно указать в качестве класса хранилища, перечислены в разделе [{#T}](../../concepts/storage-class.md#storage-class-identifiers).

{% note info %}

В консоли управления класс хранилища выбирается только при [загрузке объекта](upload.md). Для уже загруженных объектов воспользуйтесь {{ yandex-cloud }} CLI, AWS CLI, API или [жизненными циклами](#lifecycles).

{% endnote %}

## Изменить класс хранилища одного объекта {#single-object}

Копирование под тем же ключом заменяет объект: в неверсионируемом бакете исходный объект удаляется, в [версионируемом](../../concepts/versioning.md) создается новая версия, а прежняя сохраняется и продолжает тарифицироваться.

{% note warning %}

Минимальное тарифицируемое время хранения объекта в ледяном хранилище — 12 месяцев. Если вы переведете в другой класс объект, который пролежал в `ICE` меньше 12 месяцев, при удалении исходного объекта будет списан остаток [стоимости хранения](../../pricing.md#prices).

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для копирования объекта:

      ```bash
      yc storage s3api copy-object --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Выполните команду:

      ```bash
      yc storage s3api copy-object \
        --copy-source <имя_бакета>/<ключ_объекта> \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --storage-class COLD \
        --metadata-directive COPY
      ```

      Где:

      * `--copy-source` — имя бакета и [ключ](../../concepts/object.md#key) объекта, класс хранилища которого вы меняете.
      * `--bucket` — имя бакета, в который будет записан объект.
      * `--key` — ключ, под которым объект будет сохранен. Чтобы изменить класс хранилища на месте, укажите тот же ключ, что и в `--copy-source`.
      * `--storage-class` — новый класс хранилища.
      * `--metadata-directive` — режим копирования метаданных. Со значением `COPY` метаданные объекта сохраняются. Класс хранилища при этом не копируется и берется из `--storage-class`.

      Результат:

      ```text
      copy_object_result:
        etag: '"d41d8cd98f00b204e9800998********"'
        last_modified_at: "2024-10-08T14:21:41.628Z"
      request_id: 61523025********
      copy_source_version_id: "null"
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api copy-object \
        --copy-source <имя_бакета>/<ключ_объекта> \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --storage-class COLD \
        --metadata-directive COPY
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--copy-source` — имя бакета и ключ объекта, класс хранилища которого вы меняете.
      * `--bucket` — имя бакета, в который будет записан объект.
      * `--key` — ключ, под которым объект будет сохранен.
      * `--storage-class` — новый класс хранилища.
      * `--metadata-directive` — режим копирования метаданных.

      Результат:

      ```json
      {
          "CopyObjectResult": {
              "ETag": "\"d41d8cd98f00b204e9800998********\"",
              "LastModified": "2024-10-08T14:21:41+00:00"
          }
      }
      ```

- API {#api}

  Чтобы изменить класс хранилища объекта, воспользуйтесь методом S3 API [copy](../../s3/api-ref/object/copy.md) и передайте в запросе заголовок `X-Amz-Storage-Class` с новым классом хранилища.

  Объекты размером больше 5 ГБ копируются по частям методом [copyPart](../../s3/api-ref/multipart/copypart.md). Класс хранилища для такого объекта задается при [инициализации составной загрузки](../../s3/api-ref/multipart/startupload.md).

{% endlist %}

## Изменить класс хранилища нескольких объектов {#multiple-objects}

{% include [work-with-multiple-objects](../../../_includes/storage/work-with-multiple-objects.md) %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для копирования объектов:

      ```bash
      yc storage s3 cp --help
      ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}
  1. Выполните команду:

      ```bash
      yc storage s3 cp \
        s3://<имя_бакета>/<префикс>/ \
        s3://<имя_бакета>/<префикс>/ \
        --recursive \
        --storage-class COLD
      ```

      Где:

      * `--recursive` — обрабатывает все объекты с указанным префиксом.
      * `--storage-class` — новый класс хранилища.

      Чтобы отфильтровать объекты, добавьте параметры `--exclude` и `--include`:

      ```bash
      yc storage s3 cp \
        s3://<имя_бакета>/<префикс>/ \
        s3://<имя_бакета>/<префикс>/ \
        --recursive \
        --exclude "*" \
        --include "*.log" \
        --storage-class COLD
      ```

      {% include [s3-cp-filter-order](../../../_includes/storage/s3-cp-filter-order.md) %}

      Результат:

      ```text
      copy: s3://my-bucket/logs/object-1.log to s3://my-bucket/logs/object-1.log
      copy: s3://my-bucket/logs/object-2.log to s3://my-bucket/logs/object-2.log
      ```

      Подробнее о настройке команды в разделе [{#T}](copy.md#yc-s3-cp-config).

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp s3://<имя_бакета>/<префикс>/ s3://<имя_бакета>/<префикс>/ \
        --recursive \
        --storage-class COLD
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `--recursive` — обрабатывает все объекты с указанным префиксом.
      * `--storage-class` — новый класс хранилища.

      Подробнее о команде `aws s3 cp` читайте в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

{% endlist %}

## Изменить класс хранилища по расписанию {#lifecycles}

Если объекты нужно переводить в более «холодное» хранилище по мере их устаревания, не выполняйте копирование вручную — настройте [жизненные циклы объектов](../../concepts/lifecycles.md). Правило с действием `Transition` меняет класс хранилища объектов, которые пролежали в бакете заданное количество дней или пережили заданное количество новых версий.

Правила жизненного цикла срабатывают ежедневно в 00:00 UTC, поэтому класс хранилища изменится не сразу после настройки правила. Если класс нужно изменить немедленно, скопируйте объекты с новым классом, как описано выше.

Подробнее о настройке смотрите в разделе [{#T}](../buckets/lifecycles.md), о формате правил — в разделе [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

## Проверить класс хранилища объекта {#check}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc storage s3api head-object \
    --bucket <имя_бакета> \
    --key <ключ_объекта>
  ```

  Результат:

  ```text
  etag: '"d41d8cd98f00b204e9800998********"'
  request_id: 6428ce25********
  accept_ranges: bytes
  content_type: application/octet-stream
  last_modified_at: "2024-10-08T12:36:36Z"
  storage_class: COLD
  ```

  У объекта в стандартном хранилище класс в ответе не выводится.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api list-objects \
        --bucket <имя_бакета> \
        --query 'Contents[].[Key,StorageClass]'
      ```

      Результат:

      ```json
      [
          [
              "logs/object-1.log",
              "COLD"
          ],
          [
              "logs/object-2.log",
              "COLD"
          ]
      ]
      ```

- API {#api}

  Чтобы узнать класс хранилища одного объекта, воспользуйтесь методом S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md): класс возвращается в заголовке `X-Amz-Storage-Class`. Если объект сохранен в стандартном хранилище, заголовка в ответе не будет.

  Чтобы узнать классы хранилища сразу всех объектов бакета, воспользуйтесь методом S3 API [listObjects](../../s3/api-ref/bucket/listobjects.md): класс каждого объекта возвращается в элементе `StorageClass`.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/storage-class.md)
* [{#T}](copy.md)
* [{#T}](upload.md)
* [{#T}](../buckets/lifecycles.md)
