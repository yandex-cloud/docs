# Действия

Действие                        | Метод S3 API | Описание
------------------------------- | ------------ | --------
`s3:AbortMultipartUpload`       | [abortUpload](../multipart/abortupload.md) | Дает право на прерывание составной загрузки.
`s3:DeleteBucketWebsite`        | [delete](../hosting/delete.md) | Дает право на удаление конфигурации сайта для бакета.
`s3:DeleteObject`               | [delete](../object/delete.md) | Дает право на удаление null-версии и добавляет delete-маркер на последнюю версию объекта.
`s3:DeleteObjectVersion`        | [delete](../object/delete.md) | Дает право на удаление указанной версии объекта.
`s3:GetBucketAcl`               | [bucketGetAcl](../acl/bucketget.md) | Дает право на чтение ACL бакета.
`s3:GetBucketCORS`              | [get](../cors/get.md) | Дает право на чтение информации о конфигурации CORS.
`s3:GetBucketLocation`          | [GetBucketLocation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLocation.html) | Дает право на чтение информации о зоне, в которой находится бакет.
`s3:GetBucketVersioning`        | [getBucketVersioning](../bucket/getBucketVersioning.md) | Дает право на чтение информации о состоянии управления версиями бакета.
`s3:GetBucketWebsite`           | [get](../hosting/get.md) | Дает право на чтение конфигурации сайта бакета.
`s3:GetEncryptionConfiguration` | [getBucketEncryption](../bucket/getbucketencryption.md) | Дает право на чтение конфигурации шифрования по умолчанию для бакета.
`s3:GetLifecycleConfiguration`  | [get](../lifecycles/get.md) | Дает право на чтение конфигурации жизненного цикла бакета.
`s3:GetObject`                  | [get](../object/get.md) | Дает право на чтение объектов.
`s3:GetObjectAcl`               | [objectGetAcl](../acl/objectget.md) | Дает право на чтение ACL объекта.
`s3:GetObjectVersion`           | [get](../object/get.md) | Дает право на чтение определенной версии объекта.
`s3:GetObjectVersionAcl`        | [get](../object/get.md) | Дает право на чтение ACL определенной версии объекта.
`s3:ListBucket`                 | [list](../bucket/list.md) | Дает право на чтение списка некоторых или всех объектов в бакете.
`s3:ListBucketMultipartUploads` | [listUploads](../multipart/listuploads.md) | Дает право на чтение списка незавершенных составных загрузок.
`s3:ListBucketVersions`         | [listObjectVersions](../bucket/listObjectVersions.md) | Дает право на чтение метаданных обо всех версиях объектов в бакете.
`s3:ListMultipartUploadParts`   | [listParts](../multipart/listparts.md) | Дает право на чтение списка загруженных частей определенной составной загрузки.
`s3:PutBucketAcl`               | [bucketPutAcl](../acl/bucketput.md) | Дает право на установку разрешений ACL на бакет.
`s3:PutBucketCORS`              | [upload](../cors/upload.md) | Дает право на установку конфигурации CORS бакета.
`s3:PutBucketVersioning`        | [putBucketVersioning](../bucket/putBucketVersioning.md) | Дает право на установку состояния управления версиями бакета.
`s3:PutBucketWebsite`           | [upload](../hosting/upload.md) | Дает право на установку конфигурации сайта бакета.
`s3:PutEncryptionConfiguration` | [putBucketEncryption](../bucket/putbucketencryption.md) | Дает право на установку конфигурации шифрования для бакета.
`s3:PutLifecycleConfiguration`  | [upload](../lifecycles/upload.md) | Дает право на установку конфигурации жизненного цикла для бакета или замены существующей.
`s3:PutObject`                  | [upload](../object/upload.md) | Дает право на добавление объекта в бакет.
`s3:PutObjectAcl`               | [objectPutAcl](../acl/objectput.md) | Дает право на установку ACL для указанного объекта.
`s3:PutObjectVersionAcl`        | [objectPutAcl](../acl/objectput.md) | Дает право на установку ACL для указанной версии объекта.

#### Связанные статьи {#related-articles}

* [Политика доступа (bucket policy)](../../../concepts/policy.md)

#### Полезные ссылки {#see-also}

* [Начало работы с AWS S3 API в Yandex Object Storage](../../s3-api-quickstart.md)

* [Отладка запросов с помощью утилиты AWS CLI](../../signing-requests.md#debugging)

* [Пример отправки подписанного запроса с помощью утилиты curl](../../../api-ref/authentication.md#s3-api-example)

* [Пример кода для генерации подписи](../../../concepts/pre-signed-urls.md#code-examples)