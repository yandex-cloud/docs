# Получение списка бакетов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  
  На открывшейся странице отобразится полный список [бакетов](../../concepts/bucket.md).

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [бакетов](../../concepts/bucket.md):

     ```bash
     yc storage bucket --help
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

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы получить список [бакетов](../../concepts/bucket.md), выполните команду:

      ```bash
      aws s3api list-buckets \
        --endpoint-url=https://{{ s3-storage-host }}
      ```

      Где `--endpoint-url` — эндпоинт {{ objstorage-name }}.

      Результат:

      ```json
      {
          "Buckets": [
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:38.836000+00:00"
              },
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:45.365000+00:00"
              }
          ],
          "Owner": {
              "DisplayName": "",
              "ID": ""
          },
          "Prefix": null
      }
      ```

- API {#api}

  Чтобы получить список [бакетов](../../concepts/bucket.md), воспользуйтесь методом REST API [list](../../api-ref/Bucket/list.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/List](../../api-ref/grpc/Bucket/list.md) или методом S3 API [listBuckets](../../s3/api-ref/bucket/list.md).

{% endlist %}