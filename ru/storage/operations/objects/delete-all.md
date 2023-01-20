# Удаление всех объектов из бакета

Чтобы очистить бакет и не [платить](../../pricing.md) за хранение:

{% list tabs %}

- AWS CLI

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Создайте переменную с именем бакета:
  
     ```bash
     BUCKET_NAME=<имя_бакета>
     ```
     
  1. Удалите все версии объектов из бакета:
    
     ```bash
     aws s3api delete-objects \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
       --delete \
         "$(aws s3api list-object-versions \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           --query '{Objects: Versions[].{Key: Key, VersionId: VersionId}}' \
           --max-items 1000)"
     ```
         
     Результат:
         
     ```json
     {
         "Deleted": [
             {
                 "Key": "object_000",
                 "VersionId": "0005CDD3521954A6"
             },
             {
                 "Key": "object_001",
                 "VersionId": "0005CDD3523B6ADB"
             },
             ...
         ]
     }
     ```
         
     С помощью этой команды можно удалить до 1000 версий объектов: это связано с ограничением операции `aws s3api delete-objects`. Если в бакете больше версий, повторите команду несколько раз.
  
  1. Если для бакета включено [версионирование](../../concepts/versioning.md), удалите все delete-маркеры:
       
     ```bash
     aws s3api delete-objects \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
       --delete \
         "$(aws s3api list-object-versions \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           --query '{Objects: DeleteMarkers[].{Key: Key, VersionId: VersionId}}' \
           --max-items 1000)"
     ```
       
     Результат:
       
     ```json
     {
         "Deleted": [
             {
                 "Key": "object_034",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD35274A467"
             },
             {
                 "Key": "object_057",
                 "DeleteMarker": true,
                 "DeleteMarkerVersionId": "0005CDD3528B1BC3"
             },
             ...
         ]
     }
     ```
     
     С помощью этой команды можно удалить до 1000 delete-маркеров: это связано с ограничением операции `aws s3api delete-objects`. Если в бакете больше версий, повторите команду несколько раз.
   
  1. Удалите частично загруженные объекты:
    
     ```bash
     aws s3api list-multipart-uploads \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
     | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
     | while read -r line; do
       eval 
         "aws s3api abort-multipart-upload \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           $line";
     done
     ```
       
  1. Получите список частей объектов, оставшихся в бакете:
    
     ```bash
     aws s3api list-multipart-uploads \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket $BUCKET_NAME \
     | jq -r '.Uploads[] | "--key \"\(.Key)\" --upload-id \(.UploadId)"' \
     | while read -r line; do
       eval 
         "aws s3api list-parts \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket $BUCKET_NAME \
           $line";
     done
     ```
       
     В списке могут оказаться части объектов, загрузка которых началась до выполнения предыдущего шага и закончилась после него. Если список не пуст, повторите шаги 4–5.
     
- Python 3 (boto3)

  Выполните следующий код:

  ```python
  import boto3

  bucket_name = '<имя_бакета>'
  s3 = boto3.resource('s3',
      endpoint_url='https://{{ s3-storage-host }}',
      aws_access_key_id='<идентификатор_ключа>',
      aws_secret_access_key='<секретный_ключ>')
  bucket = s3.Bucket(bucket_name)

  # Deleting all versions (works for non-versioned buckets too).
  bucket.object_versions.delete()

  # Aborting all multipart uploads, which also deletes all parts.
  for multipart_upload in bucket.multipart_uploads.iterator():
      # Part uploads that are currently in progress may or may not succeed,
      # so it might be necessary to abort a multipart upload multiple times.
      while len(list(multipart_upload.parts.all())) > 0:
          multipart_upload.abort()
  ```

{% endlist %}
