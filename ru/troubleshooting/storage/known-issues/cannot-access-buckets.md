# Устранение ошибки доступа к бакетам S3 из кластера {{ dataproc-name }} 1.4


## Описание проблемы {#issue-description}

При попытке получить доступ к бакетам S3 из кластера {{ dataproc-name }} 1.4 появляется сообщение об ошибке:
```
ls: doesBucketExist on yc-mdb-examples: com.amazonaws.AmazonClientException: 
No AWS Credentials provided by ComputeMetadataCredentialsProvider : com.amazonaws.AmazonServiceException: Bad Request (Service: null; Status Code: 400; Error Code: null; Request ID: null)
```
При этом у хостов кластера есть сетевой доступ к S3.

## Решение {#issue-resolution}

Необходимо создать новый кластер с версией {{ dataproc-name }} 2.0 или выше — в ней указанная ошибка не возникает и подключение к бакету происходит корректно.

{% note tip %}

Для подключения нужно использовать логин `ubuntu`, а не `root`.

{% endnote %}
