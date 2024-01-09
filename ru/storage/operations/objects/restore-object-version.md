# Восстановление версии объекта в версионируемом бакете

Для восстановления версий объектов бакет должен быть [версионируемым](../../concepts/versioning.md). Восстановить можно только те версии, которые были загружены при включенном версионировании. Чтобы включить версионирование, воспользуйтесь [инструкцией](../buckets/versioning.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note warning %}

  На восстановление версии объекта через консоль управления отводится 25 секунд. Большие версии могут не успеть восстановиться за это время. Если восстановление закончилось ошибкой, используйте другие инструменты, например AWS CLI или [API](../../../glossary/rest-api.md).

  {% endnote %}

  Чтобы восстановить версию объекта:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный объект.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. В списке бакетов нажмите на строку с нужным бакетом.
  1. В списке объектов в строке с нужным объектом нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.file.button_version-history }}**.
  1. В списке версий в строке с нужной версией нажмите **{{ ui-key.yacloud.storage.file.action_file-restore }}**. Выбранная версия будет восстановлена и отображена как текущая.

- AWS CLI {#cli}

  Чтобы восстановить версию объекта с помощью [AWS CLI](../../tools/aws-cli.md):

  1. Получите идентификатор нужной версии объекта:

     ```bash
     aws s3api list-object-versions \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <имя_бакета> \
       --prefix <префикс_ключа_объекта>
     ```

     В результате отобразится список версий всех объектов, ключи которых начинаются с указанного префикса. Идентификаторы версий содержатся в параметрах `VersionId`.

     {% cut "Пример получения списка версий" %}

     Команда:

     ```bash
     aws s3api list-object-versions \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket my-bucket \
       --prefix index.html
     ```

     Результат:

     ```bash
     {
        "Versions": [
            {
                "LastModified": "2015-11-10T00:20:11.000Z",
                "VersionId": "Rb_l2T8UHDkFEwCgJjhlgPOZ********",
                "ETag": "\"0622528de826c0df5db1258a********\"",
                "StorageClass": "STANDARD",
                "Key": "index.html",
                "Owner": {
                    "DisplayName": "my-username",
                    "ID": "7009a8971cd660687538875e7c86c5b672fe116bd438f46db45460dd********"
                },
                "IsLatest": true,
                "Size": 38
            },
            {
                "LastModified": "2015-11-09T23:26:41.000Z",
                "VersionId": "rasWWGpgk9E4s0LyTJgusGeR********",
                "ETag": "\"06225825b8028de826c0df5d********\"",
                "StorageClass": "STANDARD",
                "Key": "index.html",
                "Owner": {
                    "DisplayName": "my-username",
                    "ID": "7009a8971cd660687538875e7c86c5b672fe116bd438f46db45460dd********"
                },
                "IsLatest": false,
                "Size": 38
            }
        ]
     }
     ```

     {% endcut %}

     Чтобы выбрать только один объект:

     1. Установите и инициализируйте [jq](https://stedolan.github.io/jq/download/).
     1. Отфильтруйте результат:

        ```bash
        aws s3api list-object-versions \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <имя_бакета> \
          --prefix <префикс_ключа_объекта> \
        | jq '.Versions | map(select(.Key == "<ключ_объекта>"))'
        ```

     Подробнее о команде читайте в ее описании в [документации Amazon](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/list-object-versions.html).

  1. Скопируйте версию объекта в тот же бакет с тем же ключом, чтобы она стала текущей версией объекта:

     ```bash
     aws s3api copy-object \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <имя_бакета> \
       --copy-source <имя_бакета>/<ключ_объекта>?versionId=<идентификатор_версии> \
       --key <ключ_объекта>
     ```

     Где:

     * `--bucket` – имя бакета.
     * `--copy-source` – исходный объект для копирования с указанием идентификатора нужной версии.
     * `--key` – ключ целевого объекта. Чтобы восстановить версию объекта, ключи целевого и исходного объектов должны совпадать.

     Результат:

     ```bash
     {
       "CopyObjectResult": {
         "LastModified": "<дата_и_время_последнего_изменения_объекта>",
         "ETag": "\"589c8b79c230a6ecd5a7e1d040a9a030\""
       },
       "VersionId": "<идентификатор_восстановленной_версии_объекта>"
     }
     ```

     Подробнее о команде читайте в ее описании в [документации Amazon](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/copy-object.html).

- API {#api}

  Чтобы восстановить версию объекта:

  1. Получите идентификатор нужной версии объекта с помощью метода S3 API [listObjectVersions](../../s3/api-ref/bucket/listObjectVersions.md).
  1. Скопируйте версию объекта в тот же бакет с тем же ключом с помощью метода S3 API [copy](../../s3/api-ref/object/copy.md).

{% endlist %}
