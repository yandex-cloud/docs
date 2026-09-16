[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > Пошаговые инструкции > Все инструкции

# Пошаговые инструкции для Object Storage

## Бакеты {#buckets}

* [Создать бакет](buckets/create.md)
* [Удалить бакет](buckets/delete.md)
* [Ограничить максимальный размер бакета](buckets/limit-max-volume.md)
* [Настроить и отключить шифрование по умолчанию в бакете](buckets/encrypt.md)
* [Настроить жизненный цикл объектов в бакете](buckets/lifecycles.md)
* [Настроить CORS](buckets/cors.md)
* [Настроить права доступа к бакету с помощью Identity and Access Management](buckets/iam-access.md)
* [Редактировать ACL бакета](buckets/edit-acl.md)
* [Управлять политикой доступа (bucket policy)](buckets/policy.md)
* [Открыть и закрыть публичный доступ к бакету](buckets/bucket-availability.md)
* [Запретить доступ в бакет с помощью статических ключей](buckets/disable-statickey-auth.md)
* [Получить доступ в бакет с помощью Security Token Service](buckets/create-sts-key.md)
* [Получить доступ к бакету с помощью эфемерного ключа доступа](buckets/manage-ephemeral-keys.md)
* [Настроить доступ в бакет с помощью сервисного подключения из Yandex Virtual Private Cloud](buckets/access-via-vpc.md)
* [Искать чувствительные данные в бакете](buckets/sensitive-data-search.md) 
* [Включить и приостановить версионирование бакета](buckets/versioning.md)
* [Логировать действия с бакетом](buckets/enable-logging.md)
* [Включить и выключить блокировку версий объектов (object lock)](buckets/configure-object-lock.md)
* [Управлять выгрузкой метаданных объектов (S3 Inventory) в бакете](buckets/manage-s3-inventory.md)
* [Управлять метками бакета](buckets/tagging.md)
* [Получить список бакетов](buckets/get-list.md)
* [Получить информацию о бакете и его статистику](buckets/get-info.md)
* [Посмотреть метрики бакета](buckets/get-stats.md)


## Объекты {#objects}

* [Загрузить объект](objects/upload.md)
* [Загрузить объект составной (multipart) загрузкой](objects/multipart-upload.md)
* [Получить список объектов в бакете](objects/list.md)
* [Получить информацию об объекте](objects/info.md)
* [Скачать объект](objects/download.md)
* [Восстановить версию объекта](objects/restore-object-version.md)
* [Переименовать и переместить объект](objects/rename-move.md)
* [Скопировать объект](objects/copy.md)
* [Получить подписанную ссылку (pre-signed URL) на скачивание объекта](objects/link-for-download.md)
* [Получить подписанную ссылку (pre-signed URL) на загрузку объекта](objects/link-for-upload.md)
* [Блокировать версии объекта (object lock)](objects/edit-object-lock.md)
* [Удалить объект](objects/delete.md)
* [Удалить все объекты из бакета](objects/delete-all.md)
* [Удалить частично загруженный объект](objects/deleting-multipart.md)
* [Редактировать ACL объекта](objects/edit-acl.md)
* [Управлять метками объекта](objects/tagging.md)
* [Управлять пользовательскими метаданными объекта](objects/object-meta.md)


## Хостинг статических сайтов {#hosting}

* [Настроить хостинг](hosting/setup.md)
* [Поддержать собственный домен](hosting/own-domain.md)
* [Поддержать несколько доменных имен](hosting/multiple-domains/index.md)
* [Настроить HTTPS](hosting/certificate.md)