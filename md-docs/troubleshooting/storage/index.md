# Решения для Object Storage

## Примеры конфигураций и сценариев Object Storage {#configuration-examples}

* [Как ограничить доступ к бакету Object Storage диапазоном IP-адресов, принадлежащих Cloud CDN](how-to/permit-bucket-access-only-to-cdn-networks.md)
* [Как перенести данные из бакета Object Storage в ледяное хранилище](how-to/moving-objects-to-glacier-storage-type.md)
* [Как перенести содержимое бакета в другой бакет в пределах организации](how-to/moving-data-to-other-bucket-within-organisation.md)
* [Как работать напрямую с API Object Storage без использования SDK](how-to/curl-api-request-example.md)
* [Как просматривать и удалять незавершенные загрузки](how-to/incomplete-downloads.md)
* [Как узнать скорость загрузки и скачивания данных](how-to/upload-download-speed.md)
* [Как настроить заголовки кэширования `Cache-Control` для объектов в бакете при HTTP-запросах](how-to/configure-cache-headings-with-http-queries.md)
* [Как ограничить доступ к бакету для пользователя](how-to/restrict-bucket-access.md)
* [Как изменить класс хранения](how-to/change-storage-class.md)
* [Как восстановить удаленные данные из бакета](how-to/recover-deleted-objects.md)

## Решения для известных проблем Object Storage {#known-issues-resolving}

* [Устранение ошибки `Bucket is not empty` при удалении бакета](known-issues/bucket-deletion-issue.md)
* [Устранение ошибки `The request signature we calculated does not match the signature you provided.`](known-issues/the-request-signature-we-calculated-does-not-match.md)
* [Устранение ошибок доступа к бакету с назначенной политикой безопасности](known-issues/unable-to-access-bucket-with-assigned-policy.md)
* [Устранение ошибки 409 `BucketAlreadyExists`](known-issues/error-409-bucket-already-exists.md)
* [Устранение ошибки доступа к бакетам S3 из кластера Yandex Data Processing 1.4](known-issues/cannot-access-buckets.md)
* [Устранение ошибки 403 (не отдается заголовок при использовании метода `OPTION`)](known-issues/error-403-cors-header.md)
* [Устранение ошибки сертификата](known-issues/wrong-certificate.md)
* [Устранение ошибки `GATEWAY_REQUEST_ERROR`](known-issues/error-gateway-request.md)
* [Устранение проблем с некорректным MIME-типов объектов при их загрузке в Object Storage](known-issues/incorrect-mime-type.md)
* [Устранение проблем с загрузкой новых объектов в бакет](known-issues/objects-uploading-issue.md)