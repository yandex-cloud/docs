# Удаление частично загруженного объекта

Объект может быть загружен не полностью при использовании [составной загрузки](../../concepts/multipart.md).

{% note info %}

Для автоматического удаления частично загруженных объектов в Object Storage настройте правило [жизненных циклов](../buckets/lifecycles.md).

{% endnote %}

Чтобы удалить частично загруженный объект вручную:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. В строке с нужным бакетом в колонке **Кол-во объектов** наведите указатель на желтое поле с количеством частично загруженных объектов.
  1. В открывшемся окне нажмите **Показать список**.
  1. Отметьте незавершенные загрузки, которые нужно удалить.
  1. Нажмите кнопку **Удалить**.
  1. Подтвердите удаление.

  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список незавершенных составных загрузок:

      1. Посмотрите описание команды CLI для получения списка незавершенных составных загрузок в бакете:

          ```bash
          yc storage s3api list-multipart-uploads --help
          ```

      1. Получите список бакетов в каталоге по умолчанию:
         
         ```bash
         yc storage bucket list
         ```
         
         Результат:
         
         ```text
         +------------------+----------------------+-------------+-----------------------+---------------------+
         |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
         +------------------+----------------------+-------------+-----------------------+---------------------+
         | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
         +------------------+----------------------+-------------+-----------------------+---------------------+
         ```
      1. Выполните команду, указав имя нужного бакета:

          ```bash
          yc storage s3api list-multipart-uploads \
            --bucket <имя_бакета>
          ```

          Результат:

          ```yaml
          bucket: first-bucket
          max_uploads: "1000"
          uploads:
            - key: video.mp4
              upload_id: 000629B7********
              initiator:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              owner:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              storage_class: STANDARD
              initiated_at: "2024-12-20T18:05:07.312Z"
            - key: video1.mp4
              upload_id: 000629B7********
              initiator:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              owner:
                id: ajeol2afu1js********
                display_name: ajeol2afu1js********
              storage_class: STANDARD
              initiated_at: "2024-12-20T18:20:15.747Z"
          request_id: 75dbac97********
          ```

          Сохраните значение идентификатора составной загрузки (`uploads.upload_id`) частично загруженного объекта, который вы хотите удалить. Это значение понадобится на следующем шаге.

          Подробнее о команде `yc storage s3api list-multipart-uploads` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/s3api/list-multipart-uploads.md).

  1. Удалите частично загруженный объект:

      1. Посмотрите описание команды CLI для удаления частично загруженного объекта:

          ```bash
          yc storage s3api abort-multipart-upload --help
          ```
      1. Выполните команду:

          ```bash
          yc storage s3api abort-multipart-upload \
            --bucket <имя_бакета> \
            --key <ключ_объекта> \
            --upload-id <идентификатор_составной_загрузки>
          ```

          Где:

          * `--bucket` — имя бакета, в котором вы хотите удалить частично загруженный объект.
          * `--key` — [ключ](../../concepts/object.md#key) объекта, который нужно удалить.
          * `--upload-id` — значение идентификатора составной загрузки, полученное на предыдущем шаге.

          Результат:

          ```text
          request_id: 573ea6e2********
          ```

          Подробнее о команде `yc storage s3api abort-multipart-upload` читайте в [справочнике CLI](../../../cli/cli-ref/storage/cli-ref/s3api/abort-multipart-upload.md).

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Получите список незавершенных составных загрузок:

      1. Получите список доступных бакетов:

          ```bash
          aws s3api list-buckets \
            --endpoint-url=https://storage.yandexcloud.net 
          ```

          Результат:

          ```json
          {
            "Buckets": [
              {
                "Name": "new-bucket",
                "CreationDate": "2024-12-20T17:48:17+00:00"
              },
              {
                "Name": "first-bucket",
                "CreationDate": "2023-12-28T12:20:49.538000+00:00"
              }
            ],
            "Owner": {
              "DisplayName": "",
              "ID": ""
            }
          }
          ```

      1. Выполните команду, указав имя нужного бакета:

          ```bash
          aws s3api list-multipart-uploads \
            --endpoint-url=https://storage.yandexcloud.net \
            --bucket <имя_бакета>
          ```

          Результат:

          ```json
          {
            "Uploads": [
              {
                "UploadId": "000629C2********",
                "Key": "video.mp4",
                "Initiated": "2024-12-21T07:40:03.562000+00:00",
                "StorageClass": "STANDARD",
                "Owner": {
                  "DisplayName": "ajegtlf2q28a********",
                  "ID": "ajegtlf2q28a********"
                },
                "Initiator": {
                  "ID": "ajegtlf2q28a********",
                  "DisplayName": "ajegtlf2q28a********"
                }
              },
              {
                "UploadId": "000629C2********",
                "Key": "video1.mp4",
                "Initiated": "2024-12-21T07:42:39.492000+00:00",
                "StorageClass": "STANDARD",
                "Owner": {
                  "DisplayName": "ajegtlf2q28a********",
                  "ID": "ajegtlf2q28a********"
                },
                "Initiator": {
                  "ID": "ajegtlf2q28a********",
                  "DisplayName": "ajegtlf2q28a********"
                }
              }
            ],
            "RequestCharged": null
          }
          ```

          Сохраните значение идентификатора составной загрузки (`Uploads.UploadId`) частично загруженного объекта, который вы хотите удалить. Это значение понадобится на следующем шаге.

  1. Удалите частично загруженный объект:

      ```bash
      aws s3api abort-multipart-upload \
        --endpoint-url=https://storage.yandexcloud.net \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --upload-id <идентификатор_составной_загрузки>
      ```

      Где:

      * `--bucket` — имя бакета, в котором вы хотите удалить частично загруженный объект.
      * `--key` — [ключ](../../concepts/object.md#key) объекта, который нужно удалить.
      * `--upload-id` — значение идентификатора составной загрузки, полученное на предыдущем шаге.

- API {#api}

  Чтобы получить список составных загрузок, воспользуйтесь методом S3 API [listUploads](../../s3/api-ref/multipart/listuploads.md).

  Чтобы удалить частично загруженный объект, воспользуйтесь методом S3 API [abortUpload](../../s3/api-ref/multipart/abortupload.md).

{% endlist %}