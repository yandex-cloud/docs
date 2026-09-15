[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > Практические руководства > Все руководства

# Практические руководства Object Storage

В этом разделе собраны практические руководства по использованию Object Storage для хостинга сайтов, резервного копирования, работы с данными и других задач. {#other}


## Хостинг сайтов и веб-приложений {#hosting}

* [Статический сайт в Yandex Object Storage](static/index.md)
* [Хостинг статического сайта на фреймворке Gatsby в Yandex Object Storage](gatsby-static-website.md)
* [Настройка хостинга статического сайта в бакете Yandex Object Storage с доступом через Yandex Cloud CDN](cdn-hosting/index.md)
* [Интеграция L7-балансировщика с Cloud CDN и Object Storage](cdn-storage-integration/index.md)
* [Развертывание Nextcloud в Yandex Cloud](integrate-nextcloud/index.md)
* [Установка Ghost CMS High Availability с помощью Cloud Apps](ghost-cms-cloudapp.md)
* [Установка WordPress с помощью Cloud Apps](wordpress-cloudapp.md)
* [Установка WordPress High Availability с помощью Cloud Apps](wordpress-ha-cloudapp.md)



## Резервное копирование {#backup}

* [Обзор](storage-backup-overview.md)
* [Резервное копирование в Yandex Object Storage с помощью AWS S3 Sync](storage-backup-aws-s3-sync.md)
* [Резервное копирование в Yandex Object Storage с помощью rclone](storage-backup-rclone.md)
* [Резервное копирование в Object Storage с помощью Veeam Backup](backup-with-veeam.md)
* [Резервное копирование в Yandex Object Storage с помощью GeeseFS](storage-backup-geesefs.md)
* [Резервное копирование ВМ с помощью «Хайстекс Акура — Система резервного копирования»](hystax-backup.md)
* [Резервное копирование в Yandex Object Storage с помощью Duplicati](object-storage-duplicati.md)
* [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](kubernetes-backup.md)
* [Резервное копирование в Yandex Object Storage с помощью MSP360 Backup (CloudBerry Desktop Backup)](object-storage-cloudberry.md)
* [Резервное копирование в Yandex Object Storage с помощью Bacula](backup-with-bacula.md)
* [Резервное копирование в Yandex Object Storage с помощью Veritas Backup Exec](object-storage-veritas.md)


## Сбор и анализ логов {#logs}

* [Получение статистики запросов к объекту с использованием S3 Select](server-logs.md)
* [Получение статистики посещения сайта с использованием S3 Select](user-agent-statistics.md)


* [Поиск событий в аудитных логах](search-events-audit-logs/index.md)


* [Анализ логов Object Storage при помощи DataLens](storage-logs-analysis.md)


* [Получение статистики запросов к объектам Object Storage с использованием Yandex Query](server-logs-yq.md)
* [Хранение журналов работы приложения](log-ingestion.md)
* [Поиск событий Yandex Cloud в Object Storage](search-events-bucket.md)
* [Загрузка аудитных логов в SIEM ArcSight](export-logs-to-arcsight.md)
* [Репликация логов в Yandex Object Storage с помощью Fluent Bit](replicate-logs-to-storage.md)
* [Репликация логов в Object Storage с помощью Yandex Data Streams](replicate-logs-to-storage-via-data-streams.md)
* [Загрузка аудитных логов в SIEM Splunk](export-logs-to-splunk.md)
* [Поиск событий Yandex Cloud в Yandex Query](search-events-query.md)



## Разработка и развертывание приложений {#applications}

* [Как создать бота в Telegram](telegram-bot-serverless/index.md)
* [Сокращатель ссылок](serverless-url-shortener/index.md)
* [Организация сине-зеленого и канареечного развертывания версий веб-сервиса](blue-green-canary-deployment.md)
* [Конвертация видео в GIF на Python](video-converting-queue/index.md)
* [Разработка навыка Алисы и сайта с авторизацией](alice-shareable-todolist.md)
* [Публикация обновлений для игр с помощью Yandex Cloud CDN](prefetch.md)
* [Разработка пользовательской интеграции в API Gateway](api-gw-integration.md)
* [Развертывание веб-приложения с использованием Java Servlet API](java-servlet-todo-list.md)
* [Создание интерактивного serverless-приложения с использованием WebSocket](websocket-app.md)
* [Развертывание веб-приложения с JWT-авторизацией в Yandex API Gateway и аутентификацией в Firebase](jwt-authorizer-firebase.md)



## Безопасность и управление доступом {#security}

* [Шифрование на стороне сервера](server-side-encryption.md)
* [Подключение к Object Storage из Virtual Private Cloud](storage-vpc-access.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](static-key-in-lockbox/index.md)


## Работа с файловыми системами {#file-systems}

* [Подключение бакета как диска в Windows](s3-disk-connect.md)


* [Монтирование бакетов Object Storage к файловой системе хостов Yandex Data Processing](data-processing-init-actions-geesefs.md)


## Перенос данных и интеграция с базами данных {#data-transfer}


* [Автоматическое копирование объектов из одного бакета Object Storage в другой](bucket-to-bucket.md)


* [Использование гибридного хранилища в Managed Service for ClickHouse®](clickhouse-hybrid-storage.md)
* [Миграция базы данных из Managed Service for PostgreSQL в Object Storage](mpg-to-objstorage.md)
* [Выгрузка данных Greenplum® в гибридное хранилище Yandex Object Storage](greenplum-yezzey.md)


* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](data-transfer-direct-to-mch.md)
* [Миграция данных из Yandex Data Streams с помощью Yandex Data Transfer](yds-obj-migration.md)


* [Перенос данных в Yandex Managed Service for PostgreSQL с использованием Yandex Data Transfer](object-storage-to-postgresql.md)
* [Миграция базы данных из Yandex Managed Service for MySQL® в Object Storage](mmy-objs-migration.md)
* [Загрузка данных из Yandex Managed Service for OpenSearch в Yandex Object Storage с помощью Yandex Data Transfer](opensearch-to-object-storage.md)
* [Загрузка данных из Yandex Managed Service for YDB в Yandex Object Storage с помощью Yandex Data Transfer](ydb-to-object-storage.md)
* [Загрузка данных из Object Storage в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer](object-storage-to-greenplum.md)
* [Загрузка данных из Object Storage в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](object-storage-to-clickhouse.md)
* [Миграция данных из Object Storage в Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](objs-mmy-migration.md)
* [Миграция базы данных из Google BigQuery в Yandex Managed Service for ClickHouse®](bigquery-to-clickhouse.md)
* [Загрузка данных из Object Storage в Yandex Managed Service for YDB с помощью Yandex Data Transfer](object-storage-to-ydb.md)

## Обработка и анализ данных {#data-analysis}

* [Анализ поресурсной детализации расходов](billing-resource-detailing.md)


* [Использование Object Storage в Yandex Data Processing](copy-files-from-object-storage.md)
* [Импорт данных из Object Storage, обработка и экспорт в Yandex Managed Service for ClickHouse®](s3-data-processing-ch.md)
* [Работа с данными с помощью Yandex Query](yq-storage.md)


* [Создание внешней таблицы на базе таблицы из бакета с помощью конфигурационного файла](mgp-config-server-for-s3.md)


* [Автоматизация задач Yandex Query с помощью Yandex Managed Service for Apache Airflow™](airflow-auto-tasks.md)
* [Обмен данными между Yandex Managed Service for ClickHouse® и Yandex Data Processing](dp-mch-data-exchange.md)
* [Обработка файлов детализации в сервисе Yandex Cloud Billing](billing.md)


* [Использование Object Storage в сервисе Yandex Managed Service for Apache Spark™](spark-objstorage-integration.md)


* [Импорт данных из Yandex Managed Service for MySQL® в Yandex Data Processing с помощью Sqoop](sqoop-mmy.md)
* [Импорт данных из Yandex Managed Service for PostgreSQL в Yandex Data Processing с помощью Sqoop](sqoop-mpg.md)
* [Федеративные запросы к данным с помощью Yandex Query](yq-federative-queries.md)
* [Визуализация данных из Yandex Object Storage в Yandex DataLens](data-from-yandex-query-visualization.md)



## Машинное обучение и искусственный интеллект {#machine-learning}

* [Использование данных из Object Storage для обучения модели в Yandex DataSphere](s3-to-datasphere.md)
* [Регулярное асинхронное распознавание аудиофайлов в бакете Object Storage](batch-recognition-stt.md)
* [Регулярное распознавание изображений и PDF-документов из бакета Object Storage](vision-ocrrecognizer-storage.md)
* [Распознавание архива изображений в Yandex Vision OCR](archive-from-vision-to-object-storage.md)
* [Создание сервера MLFlow для логирования экспериментов и артефактов](mlflow-datasphere.md)



## Управление инфраструктурой с Terraform {#infrastructure}

* [Загрузка состояний Terraform в Yandex Object Storage](terraform-state-storage.md)
* [Блокировка состояний Terraform с помощью Yandex Managed Service for YDB](terraform-state-lock.md)


#### Полезные ссылки {#see-also}

* [Вебинар: как с помощью Cloud CDN и Object Storage разгрузить высоконагруженную инфраструктуру](https://yandex.cloud/ru/events/1489?utm_source=docs&utm_medium=yandex&utm_campaign=infra&utm_content=vebinar&utm_term=cdns3)