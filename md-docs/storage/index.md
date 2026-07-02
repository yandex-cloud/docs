[Документация Yandex Cloud](../index.md) > Yandex Object Storage > Object Storage

# Yandex Object Storage

Сервис Yandex Object Storage — это универсальное масштабируемое решение для хранения данных. Оно подходит как для высоконагруженных сервисов, которым требуется надежный и быстрый доступ к данным, так и для проектов с невысокими требованиями к инфраструктуре хранения.

Используя Object Storage, вы можете: <ul><li>Хранить данные произвольного формата как <a href="concepts/object.md">объекты</a> с доступом по текстовому идентификатору.</li> <li>Использовать различные <a href="concepts/storage-class.md">классы хранилища</a> для объектов и управлять их <a href="concepts/lifecycles.md">жизненным циклом</a>.</li> <li>Хранить <a href="concepts/multipart.md">большие объекты</a> размером в несколько терабайт.</li> <li>Опубликовать статический <a href="concepts/hosting.md">сайт</a>.</li></ul>

<a href="s3/index.md">HTTP API сервиса</a> совместим с API Amazon S3, то есть для работы с Object Storage вы можете использовать множество <a href="tools/index.md">инструментов</a>, созданных для работы с объектными хранилищами.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_storage">Уровень обслуживания Yandex Object Storage</a>.

# Yandex Object Storage

## Начало работы

 - [Обзор](quickstart/overview.md)

 - [Начало работы c Object Storage](quickstart.md)

 - [Начало работы с AWS CLI](quickstart/quickstart-aws-cli.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Бакеты

 - [Создание бакета](operations/buckets/create.md)

 - [Удаление бакета](operations/buckets/delete.md)

 - [Ограничение максимального размера бакета](operations/buckets/limit-max-volume.md)

 - [Шифрование бакета](operations/buckets/encrypt.md)

 - [Управление жизненными циклами объектов](operations/buckets/lifecycles.md)

 - [Управление конфигурацией CORS](operations/buckets/cors.md)

 - [Настройка прав доступа с помощью IAM](operations/buckets/iam-access.md)

 - [Редактирование ACL бакета](operations/buckets/edit-acl.md)

 - [Управление политикой доступа](operations/buckets/policy.md)

 - [Настройка публичного доступа к бакету](operations/buckets/bucket-availability.md)

 - [Запретить доступ со статическими ключами](operations/buckets/disable-statickey-auth.md)

 - [Доступ в бакет с помощью Security Token Service](operations/buckets/create-sts-key.md)

 - [Доступ в бакет с помощью эфемерного ключа доступа](operations/buckets/manage-ephemeral-keys.md)

 - [Доступ в бакет с помощью сервисного подключения из VPC](operations/buckets/access-via-vpc.md)

 - [Управление версионированием бакета](operations/buckets/versioning.md)

 - [Включение механизма логирования](operations/buckets/enable-logging.md)

 - [Управление блокировками версий объектов](operations/buckets/configure-object-lock.md)

 - [Управление выгрузкой метаданных объектов](operations/buckets/manage-s3-inventory.md)

 - [Управление метками бакета](operations/buckets/tagging.md)

 - [Получение списка бакетов](operations/buckets/get-list.md)

 - [Получение информации и статистики о бакете](operations/buckets/get-info.md)

 - [Просмотр метрик бакета](operations/buckets/get-stats.md)

### Объекты

 - [Загрузка объекта](operations/objects/upload.md)

 - [Составная загрузка объекта](operations/objects/multipart-upload.md)

 - [Получение списка объектов в бакете](operations/objects/list.md)

 - [Получение информации об объекте](operations/objects/info.md)

 - [Скачивание объекта](operations/objects/download.md)

 - [Восстановление версии объекта](operations/objects/restore-object-version.md)

 - [Переименование и перемещение объекта](operations/objects/rename-move.md)

 - [Копирование объектов](operations/objects/copy.md)

 - [Скачивание объекта по подписанной ссылке (pre-signed URL)](operations/objects/link-for-download.md)

 - [Загрузка объекта по подписанной ссылке (pre-signed URL)](operations/objects/link-for-upload.md)

 - [Настройка блокировок версии объекта](operations/objects/edit-object-lock.md)

 - [Удаление объекта](operations/objects/delete.md)

 - [Удаление всех объектов](operations/objects/delete-all.md)

 - [Удаление частично загруженного объекта](operations/objects/deleting-multipart.md)

 - [Редактирование ACL объекта](operations/objects/edit-acl.md)

 - [Управление метками объекта](operations/objects/tagging.md)

 - [Управление пользовательскими метаданными объекта](operations/objects/object-meta.md)

### Хостинг статических сайтов

 - [Настройка хостинга](operations/hosting/setup.md)

 - [Поддержка собственного домена](operations/hosting/own-domain.md)

#### Поддержка нескольких доменных имен

 - [Обзор](operations/hosting/multiple-domains/index.md)

 - [Консоль управления, CLI и API](operations/hosting/multiple-domains/console.md)

 - [Terraform](operations/hosting/multiple-domains/terraform.md)

 - [Настройка HTTPS](operations/hosting/certificate.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Резервное копирование

 - [Обзор](tutorials/storage-backup-overview.md)

 - [Резервное копирование в Object Storage с помощью aws s3 sync](tutorials/storage-backup-aws-s3-sync.md)

 - [Резервное копирование в Object Storage с помощью rclone](tutorials/storage-backup-rclone.md)

 - [Резервное копирование в Object Storage с помощью GeeseFS](tutorials/storage-backup-geesefs.md)

 - [Резервное копирование в Object Storage с помощью CloudBerry Desktop Backup](tutorials/object-storage-cloudberry.md)

 - [Резервное копирование в Object Storage с помощью Duplicati](tutorials/object-storage-duplicati.md)

 - [Резервное копирование в Object Storage с помощью Bacula](tutorials/backup-with-bacula.md)

 - [Резервное копирование в Object Storage с помощью Veritas Backup Exec](tutorials/object-storage-veritas.md)

 - [Резервное копирование в Object Storage с помощью Veeam Backup](tutorials/backup-with-veeam.md)

 - [Резервное копирование ВМ с помощью Хайстекс Акура](tutorials/hystax-backup.md)

 - [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](tutorials/kubernetes-backup.md)

 - [Получение статистики запросов к объекту с использованием S3 Select](tutorials/server-logs.md)

 - [Получение статистики посещения сайта с использованием S3 Select](tutorials/user-agent-statistics.md)

 - [Получение статистики запросов к объектам с использованием Yandex Query](tutorials/server-logs-yq.md)

 - [Анализ поресурсной детализации расходов](tutorials/billing-resource-detailing.md)

 - [Шифрование на стороне сервера](tutorials/server-side-encryption.md)

### Интеграция L7-балансировщика с CDN и Object Storage

 - [Обзор](tutorials/cdn-storage-integration/index.md)

 - [Консоль управления, CLI и API](tutorials/cdn-storage-integration/console.md)

 - [Terraform](tutorials/cdn-storage-integration/terraform.md)

 - [Сине-зеленое и канареечное развертывание версий сервиса](tutorials/blue-green-canary-deployment.md)

 - [Анализ логов с использованием DataLens](tutorials/storage-logs-analysis.md)

### Поиск событий в аудитных логах

 - [Обзор](tutorials/search-events-audit-logs/index.md)

 - [Инструменты для работы с аудитными логами](tutorials/search-events-audit-logs/tools.md)

 - [Примеры запросов для поиска событий](tutorials/search-events-audit-logs/examples.md)

 - [Настройка работы с Yandex Query](tutorials/search-events-audit-logs/query.md)

 - [Монтирование бакетов к файловой системе хостов Yandex Data Processing](tutorials/data-processing-init-actions-geesefs.md)

 - [Использование Object Storage в Yandex Data Processing](tutorials/copy-files-from-object-storage.md)

 - [Импорт данных из Object Storage, обработка и экспорт в Managed Service for ClickHouse®](tutorials/s3-data-processing-ch.md)

 - [Подключение бакета как диска в Windows](tutorials/s3-disk-connect.md)

 - [Миграция данных из Yandex Data Streams с помощью Yandex Data Transfer](tutorials/yds-obj-migration.md)

 - [Использование гибридного хранилища в Yandex Managed Service for ClickHouse®](tutorials/clickhouse-hybrid-storage.md)

 - [Загрузка данных из Yandex Managed Service for OpenSearch в Yandex Object Storage с помощью Yandex Data Transfer](tutorials/opensearch-to-object-storage.md)

 - [Автоматическое копирование объектов из бакета в бакет](tutorials/bucket-to-bucket.md)

 - [Регулярное асинхронное распознавание аудиофайлов в бакете](tutorials/batch-recognition-stt.md)

 - [Обучение модели в Yandex DataSphere на данных из Object Storage](tutorials/s3-to-datasphere.md)

 - [Подключение к Object Storage из VPC](tutorials/storage-vpc-access.md)

 - [Перенос данных в Yandex Managed Service for PostgreSQL с использованием Yandex Data Transfer](tutorials/object-storage-to-postgresql.md)

 - [Загрузка данных в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](tutorials/object-storage-to-greenplum.md)

 - [Загрузка данных в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](tutorials/object-storage-to-clickhouse.md)

 - [Загрузка данных в Yandex Managed Service for YDB с помощью Yandex Data Transfer](tutorials/object-storage-to-ydb.md)

 - [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](tutorials/dp-mch-data-exchange.md)

 - [Загрузка данных из Yandex Managed Service for YDB с помощью Yandex Data Transfer](tutorials/ydb-to-object-storage.md)

 - [Хостинг статического сайта на фреймворке Gatsby в Object Storage](tutorials/gatsby-static-website.md)

 - [Установка WordPress High Availability с помощью Cloud Apps](tutorials/wordpress-ha-cloudapp.md)

 - [Установка WordPress с помощью Cloud Apps](tutorials/wordpress-cloudapp.md)

 - [Установка Ghost CMS High Availability с помощью Cloud Apps](tutorials/ghost-cms-cloudapp.md)

### Хранение статического ключа доступа в секрете Yandex Lockbox

 - [Обзор](tutorials/static-key-in-lockbox/index.md)

 - [CLI](tutorials/static-key-in-lockbox/console.md)

 - [Terraform](tutorials/static-key-in-lockbox/terraform.md)

 - [Миграция базы данных из Managed Service for PostgreSQL в Object Storage](tutorials/mpg-to-objstorage.md)

 - [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](tutorials/dp-mch-data-exchange.md)

 - [Импорт данных из Yandex Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](tutorials/sqoop-mpg.md)

 - [Импорт данных из Yandex Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](tutorials/sqoop-mmy.md)

 - [Миграция данных из Yandex Object Storage в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](tutorials/objs-mmy-migration.md)

 - [Миграция базы данных из Yandex Managed Service for MySQL® в Yandex Object Storage](tutorials/mmy-objs-migration.md)

 - [Выгрузка данных Greenplum® в холодное хранилище Yandex Object Storage](tutorials/greenplum-yezzey.md)

 - [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](tutorials/data-transfer-direct-to-mch.md)

 - [Загрузка состояний Terraform в Object Storage](tutorials/terraform-state-storage.md)

 - [Блокировка состояний Terraform с помощью Managed Service for YDB](tutorials/terraform-state-lock.md)

### Статический сайт в Yandex Object Storage

 - [Обзор](tutorials/static/index.md)

 - [Консоль управления](tutorials/static/console.md)

 - [Terraform](tutorials/static/terraform.md)

 - [Визуализация данных Yandex Query](tutorials/data-from-yandex-query-visualization.md)

 - [Публикация обновлений для игр](tutorials/prefetch.md)

 - [Разработка пользовательской интеграции в API Gateway](tutorials/api-gw-integration.md)

### Сокращатель ссылок

 - [Обзор](tutorials/serverless-url-shortener/index.md)

 - [Консоль управления](tutorials/serverless-url-shortener/console.md)

 - [Terraform](tutorials/serverless-url-shortener/terraform.md)

 - [Хранение журналов работы приложения](tutorials/log-ingestion.md)

 - [Разработка навыка Алисы и сайта с авторизацией](tutorials/alice-shareable-todolist.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Развертывание веб-приложения с использованием Java Servlet API](tutorials/java-servlet-todo-list.md)

### Разработка Telegram-бота

 - [Обзор](tutorials/telegram-bot-serverless/index.md)

 - [Консоль управления](tutorials/telegram-bot-serverless/console.md)

 - [Terraform](tutorials/telegram-bot-serverless/terraform.md)

 - [Репликация логов в Object Storage с помощью Fluent Bit](tutorials/replicate-logs-to-storage.md)

 - [Репликация логов в Object Storage с помощью Data Streams](tutorials/replicate-logs-to-storage-via-data-streams.md)

 - [Загрузка аудитных логов в SIEM ArcSight](tutorials/export-logs-to-arcsight.md)

 - [Загрузка аудитных логов в SIEM Splunk](tutorials/export-logs-to-splunk.md)

 - [Создание сервера MLFlow для логирования экспериментов и артефактов](tutorials/mlflow-datasphere.md)

 - [Работа с данными с помощью Yandex Query](tutorials/yq-storage.md)

 - [Федеративные запросы к данным с помощью Query](tutorials/yq-federative-queries.md)

 - [Распознавание архива изображений в Vision OCR](tutorials/archive-from-vision-to-object-storage.md)

 - [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](tutorials/vision-ocrrecognizer-storage.md)

### Конвертация видео в GIF на Python

 - [Обзор](tutorials/video-converting-queue/index.md)

 - [Консоль управления](tutorials/video-converting-queue/console.md)

 - [Terraform](tutorials/video-converting-queue/terraform.md)

 - [Автоматизация задач с помощью Managed Service for Apache Airflow™](tutorials/airflow-auto-tasks.md)

 - [Обработка файлов детализации в сервисе Yandex Cloud Billing](tutorials/billing.md)

 - [Развертывание веб-приложения с JWT-авторизацией в API Gateway и аутентификацией в Firebase](tutorials/jwt-authorizer-firebase.md)

 - [Поиск событий Yandex Cloud в Yandex Query](tutorials/search-events-query.md)

 - [Поиск событий Yandex Cloud в Object Storage](tutorials/search-events-bucket.md)

 - [Создание внешней таблицы на базе таблицы из бакета с помощью конфигурационного файла](tutorials/mgp-config-server-for-s3.md)

 - [Миграция базы данных из Google BigQuery в Managed Service for ClickHouse®](tutorials/bigquery-to-clickhouse.md)

### Развертывание Nextcloud в интеграции с Object Storage

 - [Обзор](tutorials/integrate-nextcloud/index.md)

 - [Развертывание Nextcloud на ВМ из образа Container Optimized Image](tutorials/integrate-nextcloud/coi-based.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ вручную](tutorials/integrate-nextcloud/fault-tolerant.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ с помощью Terraform](tutorials/integrate-nextcloud/terraform.md)

### Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN

 - [Обзор](tutorials/cdn-hosting/index.md)

 - [Консоль управления, CLI, API](tutorials/cdn-hosting/console.md)

 - [Terraform](tutorials/cdn-hosting/terraform.md)

 - [Использование Object Storage в Yandex Managed Service for Apache Spark™](tutorials/spark-objstorage-integration.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Бакет](concepts/bucket.md)

 - [Объект](concepts/object.md)

 - [Версионирование бакета](concepts/versioning.md)

 - [Блокировка версии объекта (object lock)](concepts/object-lock.md)

 - [Частичное изменение объекта](concepts/object-patch.md)

 - [Шифрование](concepts/encryption.md)

 - [Жизненные циклы объектов](concepts/lifecycles.md)

 - [CORS](concepts/cors.md)

 - [Хостинг статических сайтов](concepts/hosting.md)

 - [Подписанные (pre-signed) URL](concepts/pre-signed-urls.md)

 - [Составная (multipart) загрузка](concepts/multipart.md)

 - [Список управления доступом (ACL)](concepts/acl.md)

 - [Политика доступа (Bucket Policy)](concepts/policy.md)

 - [Загрузка файла через HTML-форму](concepts/presigned-post-forms.md)

 - [Класс хранилища](concepts/storage-class.md)

 - [Выгрузка метаданных объектов](concepts/s3-inventory.md)

 - [Механизм логирования действий с бакетом](concepts/server-logs.md)

 - [Резервное копирование](concepts/backup.md)

 - [Протокол TLS](concepts/tls.md)

 - [Метки](concepts/tags.md)

 - [Язык запросов S3 Select](concepts/s3-select-language.md)

 - [Квоты и лимиты](concepts/limits.md)

## Инструменты

 - [Все инструменты](tools/index.md)

### Консольные клиенты

 - [Yandex Cloud CLI](tools/yc-cli.md)

 - [AWS CLI](tools/aws-cli.md)

 - [S3cmd](tools/s3cmd.md)

### Файловые браузеры

 - [CyberDuck](tools/cyberduck.md)

 - [WinSCP](tools/winscp.md)

### SDK

 - [Все SDK](tools/sdk/index.md)

 - [AWS SDK для Java](tools/aws-sdk-java.md)

 - [AWS SDK для JavaScript](tools/aws-sdk-js.md)

 - [AWS SDK для Python (boto)](tools/boto.md)

 - [AWS SDK для .NET](tools/aws-sdk-net.md)

 - [AWS SDK для C++](tools/aws-sdk-cpp.md)

 - [AWS SDK для PHP](tools/aws-sdk-php.md)

 - [AWS SDK для Go](tools/aws-sdk-go.md)

### FUSE

 - [GeeseFS](tools/geesefs.md)

 - [s3fs](tools/s3fs.md)

 - [goofys](tools/goofys.md)

 - [rclone](tools/rclone.md)

### FTP

 - [Docker-контейнер для (S)FTP(S)](tools/sftps.md)

## Управление доступом

 - [Обзор](security/overview.md)

 - [Identity and Access Management](security/index.md)

 - [Список управления доступом (ACL)](security/acl.md)

 - [Политика доступа (Bucket Policy)](security/policy.md)

 - [Публичный доступ](security/public-access.md)

 - [Подписанные (pre-signed) URL](security/pre-signed-urls.md)

 - [Security Token Service](security/sts.md)

 - [Эфемерные ключи](security/ephemeral-keys.md)

 - [Правила тарификации](pricing.md)

## Справочник YC CLI (англ.)

 - [Overview](cli-ref/index.md)

### bucket

 - [Overview](cli-ref/bucket/index.md)

 - [create](cli-ref/bucket/create.md)

 - [create-inventory-configuration](cli-ref/bucket/create-inventory-configuration.md)

 - [delete](cli-ref/bucket/delete.md)

 - [delete-https](cli-ref/bucket/delete-https.md)

 - [delete-inventory-configuration](cli-ref/bucket/delete-inventory-configuration.md)

 - [get](cli-ref/bucket/get.md)

 - [get-https](cli-ref/bucket/get-https.md)

 - [get-inventory-configuration](cli-ref/bucket/get-inventory-configuration.md)

 - [list](cli-ref/bucket/list.md)

 - [list-inventory-configurations](cli-ref/bucket/list-inventory-configurations.md)

 - [set-https](cli-ref/bucket/set-https.md)

 - [stats](cli-ref/bucket/stats.md)

 - [update](cli-ref/bucket/update.md)

### s3

 - [Overview](cli-ref/s3/index.md)

 - [cp](cli-ref/s3/cp.md)

 - [mv](cli-ref/s3/mv.md)

 - [presign](cli-ref/s3/presign.md)

 - [rm](cli-ref/s3/rm.md)

### s3api

 - [Overview](cli-ref/s3api/index.md)

 - [abort-multipart-upload](cli-ref/s3api/abort-multipart-upload.md)

 - [complete-multipart-upload](cli-ref/s3api/complete-multipart-upload.md)

 - [copy-object](cli-ref/s3api/copy-object.md)

 - [create-multipart-upload](cli-ref/s3api/create-multipart-upload.md)

 - [delete-object](cli-ref/s3api/delete-object.md)

 - [delete-object-tagging](cli-ref/s3api/delete-object-tagging.md)

 - [delete-objects](cli-ref/s3api/delete-objects.md)

 - [get-bucket-acl](cli-ref/s3api/get-bucket-acl.md)

 - [get-object](cli-ref/s3api/get-object.md)

 - [get-object-acl](cli-ref/s3api/get-object-acl.md)

 - [get-object-legal-hold](cli-ref/s3api/get-object-legal-hold.md)

 - [get-object-retention](cli-ref/s3api/get-object-retention.md)

 - [get-object-tagging](cli-ref/s3api/get-object-tagging.md)

 - [head-object](cli-ref/s3api/head-object.md)

 - [list-multipart-uploads](cli-ref/s3api/list-multipart-uploads.md)

 - [list-objects](cli-ref/s3api/list-objects.md)

 - [list-parts](cli-ref/s3api/list-parts.md)

 - [put-bucket-acl](cli-ref/s3api/put-bucket-acl.md)

 - [put-object](cli-ref/s3api/put-object.md)

 - [put-object-acl](cli-ref/s3api/put-object-acl.md)

 - [put-object-legal-hold](cli-ref/s3api/put-object-legal-hold.md)

 - [put-object-retention](cli-ref/s3api/put-object-retention.md)

 - [put-object-tagging](cli-ref/s3api/put-object-tagging.md)

 - [upload-part](cli-ref/s3api/upload-part.md)

 - [upload-part-copy](cli-ref/s3api/upload-part-copy.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### bucket

 - [Overview](cli-ref/v0/bucket/index.md)

 - [create](cli-ref/v0/bucket/create.md)

 - [create-inventory-configuration](cli-ref/v0/bucket/create-inventory-configuration.md)

 - [delete](cli-ref/v0/bucket/delete.md)

 - [delete-https](cli-ref/v0/bucket/delete-https.md)

 - [delete-inventory-configuration](cli-ref/v0/bucket/delete-inventory-configuration.md)

 - [get](cli-ref/v0/bucket/get.md)

 - [get-https](cli-ref/v0/bucket/get-https.md)

 - [get-inventory-configuration](cli-ref/v0/bucket/get-inventory-configuration.md)

 - [list](cli-ref/v0/bucket/list.md)

 - [list-inventory-configurations](cli-ref/v0/bucket/list-inventory-configurations.md)

 - [set-https](cli-ref/v0/bucket/set-https.md)

 - [stats](cli-ref/v0/bucket/stats.md)

 - [update](cli-ref/v0/bucket/update.md)

#### s3

 - [Overview](cli-ref/v0/s3/index.md)

 - [cp](cli-ref/v0/s3/cp.md)

 - [mv](cli-ref/v0/s3/mv.md)

 - [presign](cli-ref/v0/s3/presign.md)

 - [rm](cli-ref/v0/s3/rm.md)

#### s3api

 - [Overview](cli-ref/v0/s3api/index.md)

 - [abort-multipart-upload](cli-ref/v0/s3api/abort-multipart-upload.md)

 - [complete-multipart-upload](cli-ref/v0/s3api/complete-multipart-upload.md)

 - [copy-object](cli-ref/v0/s3api/copy-object.md)

 - [create-multipart-upload](cli-ref/v0/s3api/create-multipart-upload.md)

 - [delete-object](cli-ref/v0/s3api/delete-object.md)

 - [delete-object-tagging](cli-ref/v0/s3api/delete-object-tagging.md)

 - [delete-objects](cli-ref/v0/s3api/delete-objects.md)

 - [get-bucket-acl](cli-ref/v0/s3api/get-bucket-acl.md)

 - [get-object](cli-ref/v0/s3api/get-object.md)

 - [get-object-acl](cli-ref/v0/s3api/get-object-acl.md)

 - [get-object-legal-hold](cli-ref/v0/s3api/get-object-legal-hold.md)

 - [get-object-retention](cli-ref/v0/s3api/get-object-retention.md)

 - [get-object-tagging](cli-ref/v0/s3api/get-object-tagging.md)

 - [head-object](cli-ref/v0/s3api/head-object.md)

 - [list-multipart-uploads](cli-ref/v0/s3api/list-multipart-uploads.md)

 - [list-objects](cli-ref/v0/s3api/list-objects.md)

 - [list-parts](cli-ref/v0/s3api/list-parts.md)

 - [put-bucket-acl](cli-ref/v0/s3api/put-bucket-acl.md)

 - [put-object](cli-ref/v0/s3api/put-object.md)

 - [put-object-acl](cli-ref/v0/s3api/put-object-acl.md)

 - [put-object-legal-hold](cli-ref/v0/s3api/put-object-legal-hold.md)

 - [put-object-retention](cli-ref/v0/s3api/put-object-retention.md)

 - [put-object-tagging](cli-ref/v0/s3api/put-object-tagging.md)

 - [upload-part](cli-ref/v0/s3api/upload-part.md)

 - [upload-part-copy](cli-ref/v0/s3api/upload-part-copy.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### AWS S3 REST

 - [Как пользоваться API](s3/index.md)

 - [Подписывание запросов](s3/signing-requests.md)

 - [Начало работы с S3 API](s3/s3-api-quickstart.md)

#### REST

 - [Все сервисы и методы](s3/api-ref/index.md)

##### Bucket

 - [Все методы](s3/api-ref/bucket.md)

 - [CreateBucket](s3/api-ref/bucket/create.md)

 - [GetBucketEncryption](s3/api-ref/bucket/getbucketencryption.md)

 - [HeadBucket](s3/api-ref/bucket/getmeta.md)

 - [ListObjects](s3/api-ref/bucket/listobjects.md)

 - [ListBuckets](s3/api-ref/bucket/list.md)

 - [DeleteBucket](s3/api-ref/bucket/delete.md)

 - [DeleteBucketEncryption](s3/api-ref/bucket/deletebucketencryption.md)

 - [PutBucketEncryption](s3/api-ref/bucket/putbucketencryption.md)

 - [PutBucketVersioning](s3/api-ref/bucket/putBucketVersioning.md)

 - [GetBucketVersioning](s3/api-ref/bucket/getBucketVersioning.md)

 - [PutBucketLogging](s3/api-ref/bucket/putBucketLogging.md)

 - [GetBucketLogging](s3/api-ref/bucket/getBucketLogging.md)

 - [ListObjectVersions](s3/api-ref/bucket/listObjectVersions.md)

 - [PutObjectLockConfiguration](s3/api-ref/bucket/putobjectlockconfiguration.md)

 - [GetObjectLockConfiguration](s3/api-ref/bucket/getobjectlockconfiguration.md)

 - [PutBucketTagging](s3/api-ref/bucket/putbuckettagging.md)

 - [GetBucketTagging](s3/api-ref/bucket/getbuckettagging.md)

 - [DeleteBucketTagging](s3/api-ref/bucket/deletebuckettagging.md)

##### Object

 - [Все методы](s3/api-ref/object.md)

 - [PutObject](s3/api-ref/object/upload.md)

 - [GetObject](s3/api-ref/object/get.md)

 - [patch](s3/api-ref/object/patch.md)

 - [CopyObject](s3/api-ref/object/copy.md)

 - [HeadObject](s3/api-ref/object/getobjectmeta.md)

 - [DeleteObject](s3/api-ref/object/delete.md)

 - [DeleteObjects](s3/api-ref/object/deletemultipleobjects.md)

 - [options](s3/api-ref/object/options.md)

 - [SelectObjectContent](s3/api-ref/object/select.md)

 - [PutObjectRetention](s3/api-ref/object/putobjectretention.md)

 - [PutObjectLegalHold](s3/api-ref/object/putobjectlegalhold.md)

 - [GetObjectRetention](s3/api-ref/object/getobjectretention.md)

 - [GetObjectLegalHold](s3/api-ref/object/getobjectlegalhold.md)

 - [PutObjectTagging](s3/api-ref/object/putobjecttagging.md)

 - [GetObjectTagging](s3/api-ref/object/getobjecttagging.md)

 - [DeleteObjectTagging](s3/api-ref/object/deleteobjecttagging.md)

##### Multipart upload

 - [Общий порядок составной загрузки](s3/api-ref/multipart.md)

 - [CreateMultipartUpload](s3/api-ref/multipart/startupload.md)

 - [UploadPart](s3/api-ref/multipart/uploadpart.md)

 - [UploadPartCopy](s3/api-ref/multipart/copypart.md)

 - [ListParts](s3/api-ref/multipart/listparts.md)

 - [AbortMultipartUpload](s3/api-ref/multipart/abortupload.md)

 - [CompleteMultipartUpload](s3/api-ref/multipart/completeupload.md)

 - [ListMultipartUploads](s3/api-ref/multipart/listuploads.md)

##### Static Website Hosting

 - [Все методы](s3/api-ref/hosting.md)

 - [PutBucketWebsite](s3/api-ref/hosting/upload.md)

 - [GetBucketWebsite](s3/api-ref/hosting/get.md)

 - [DeleteBucketWebsite](s3/api-ref/hosting/delete.md)

 - [Коды ответов статического сайта](s3/api-ref/hosting/answer-codes.md)

##### CORS

 - [Все методы](s3/api-ref/cors.md)

 - [XML-структура конфигурации CORS](s3/api-ref/cors/xml-config.md)

 - [PutBucketCors](s3/api-ref/cors/upload.md)

 - [GetBucketCors](s3/api-ref/cors/get.md)

 - [DeleteBucketCors](s3/api-ref/cors/delete.md)

##### Lifecycles

 - [Все методы](s3/api-ref/lifecycles.md)

 - [XML-структура конфигурации жизненных циклов](s3/api-ref/lifecycles/xml-config.md)

 - [PutBucketLifecycleConfiguration](s3/api-ref/lifecycles/upload.md)

 - [GetBucketLifecycleConfiguration](s3/api-ref/lifecycles/get.md)

 - [DeleteBucketLifecycle](s3/api-ref/lifecycles/delete.md)

##### ACL

 - [Все методы](s3/api-ref/acl.md)

 - [XML-структура конфигурации ACL](s3/api-ref/acl/xml-config.md)

 - [GetObjectAcl](s3/api-ref/acl/objectget.md)

 - [PutObjectAcl](s3/api-ref/acl/objectput.md)

 - [GetBucketAcl](s3/api-ref/acl/bucketget.md)

 - [PutBucketAcl](s3/api-ref/acl/bucketput.md)

##### Bucket Policy

 - [Все методы](s3/api-ref/policy.md)

 - [GetBucketPolicy](s3/api-ref/policy/get.md)

 - [PutBucketPolicy](s3/api-ref/policy/put.md)

 - [DeleteBucketPolicy](s3/api-ref/policy/delete.md)

 - [Схема данных](s3/api-ref/policy/scheme.md)

 - [Действия](s3/api-ref/policy/actions.md)

 - [Условия](s3/api-ref/policy/conditions.md)

 - [Общие заголовки запросов](s3/api-ref/common-request-headers.md)

 - [Общие заголовки ответов](s3/api-ref/common-response-headers.md)

 - [Ответы](s3/api-ref/response-codes.md)

### Yandex Cloud REST (англ.)

 - [Overview](api-ref/index.md)

#### Bucket

 - [Overview](api-ref/Bucket/index.md)

 - [List](api-ref/Bucket/list.md)

 - [Get](api-ref/Bucket/get.md)

 - [Create](api-ref/Bucket/create.md)

 - [Update](api-ref/Bucket/update.md)

 - [Delete](api-ref/Bucket/delete.md)

 - [GetStats](api-ref/Bucket/getStats.md)

 - [GetHTTPSConfig](api-ref/Bucket/getHTTPSConfig.md)

 - [SetHTTPSConfig](api-ref/Bucket/setHTTPSConfig.md)

 - [DeleteHTTPSConfig](api-ref/Bucket/deleteHTTPSConfig.md)

 - [SetAccessBindings](api-ref/Bucket/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Bucket/updateAccessBindings.md)

 - [ListAccessBindings](api-ref/Bucket/listAccessBindings.md)

 - [CreateInventoryConfiguration](api-ref/Bucket/createInventoryConfiguration.md)

 - [GetInventoryConfiguration](api-ref/Bucket/getInventoryConfiguration.md)

 - [DeleteInventoryConfiguration](api-ref/Bucket/deleteInventoryConfiguration.md)

 - [ListInventoryConfigurations](api-ref/Bucket/listInventoryConfigurations.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

### Yandex Cloud gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Bucket

 - [Overview](api-ref/grpc/Bucket/index.md)

 - [List](api-ref/grpc/Bucket/list.md)

 - [Get](api-ref/grpc/Bucket/get.md)

 - [Create](api-ref/grpc/Bucket/create.md)

 - [Update](api-ref/grpc/Bucket/update.md)

 - [Delete](api-ref/grpc/Bucket/delete.md)

 - [GetStats](api-ref/grpc/Bucket/getStats.md)

 - [GetHTTPSConfig](api-ref/grpc/Bucket/getHTTPSConfig.md)

 - [SetHTTPSConfig](api-ref/grpc/Bucket/setHTTPSConfig.md)

 - [DeleteHTTPSConfig](api-ref/grpc/Bucket/deleteHTTPSConfig.md)

 - [SetAccessBindings](api-ref/grpc/Bucket/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Bucket/updateAccessBindings.md)

 - [ListAccessBindings](api-ref/grpc/Bucket/listAccessBindings.md)

 - [CreateInventoryConfiguration](api-ref/grpc/Bucket/createInventoryConfiguration.md)

 - [GetInventoryConfiguration](api-ref/grpc/Bucket/getInventoryConfiguration.md)

 - [DeleteInventoryConfiguration](api-ref/grpc/Bucket/deleteInventoryConfiguration.md)

 - [ListInventoryConfigurations](api-ref/grpc/Bucket/listInventoryConfigurations.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Presign

 - [Overview](api-ref/grpc/Presign/index.md)

 - [Create](api-ref/grpc/Presign/create.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Логи бакета](logs-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa.md)

 - [Обучающие курсы](training.md)