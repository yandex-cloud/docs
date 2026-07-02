[Документация Yandex Cloud](../index.md) > Yandex DataSphere > DataSphere

# Yandex DataSphere

Yandex DataSphere — это сервис для ML-разработки полного цикла, который позволяет использовать все преимущества облачных технологий, сочетая в себе простой и понятный веб-интерфейс, привычные IDE и возможность бесшовного использования разных конфигураций вычислительных ресурсов Yandex Cloud.

Yandex DataSphere помогает значительно сократить стоимость машинного обучения по сравнению с вычислениями на собственном оборудовании или на других облачных платформах.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_yds">Уровень обслуживания Yandex DataSphere</a>.

# Yandex DataSphere

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Управление сообществом

 - [Создать сообщество](operations/community/create.md)

 - [Добавить пользователя в сообщество](operations/community/add-user.md)

 - [Управление метками сообщества](operations/community/manage-community-labels.md)

 - [Управление ограничениями сообщества](operations/community/manage-community-config.md)

 - [Создать сервисного агента](operations/community/create-ssa.md)

 - [Добавить ссылку для сообщества](operations/community/link-channel.md)

 - [Привязать платежный аккаунт](operations/community/link-ba.md)

 - [Посмотреть детализацию расходов](operations/community/billing-details.md)

 - [Удалить сообщество](operations/community/delete.md)

 - [Удалить пользователя из сообщества](operations/community/delete-user.md)

### Управление проектом

 - [Создать проект](operations/projects/create.md)

 - [Добавить пользователя в проект](operations/projects/add-user.md)

 - [Управление метками проекта](operations/projects/manage-project-labels.md)

 - [Выбрать версию Python](operations/projects/python-version.md)

 - [Изменить размер хранилища проекта](operations/projects/storage-resize.md)

 - [Изменить настройки проекта](operations/projects/update.md)

 - [Задать ограничения для проекта](operations/projects/restrictions.md)

 - [Удалить ноутбук или проект](operations/projects/delete.md)

 - [Удалить пользователя из проекта](operations/projects/delete-user.md)

 - [Использовать ресурс с совместным доступом](operations/projects/use-shared-resource.md)

 - [Решение проблем](operations/projects/debugging-tools.md)

### DataSphere Notebook

 - [Подключиться к JupyterLab из локальной IDE](operations/projects/remote-connect.md)

 - [Выбрать вычислительные ресурсы](operations/projects/control-compute-resources.md)

 - [Проверить загрузку GPU](operations/projects/gpu-performance-check.md)

 - [Получить идентификатор ноутбука](operations/projects/get-notebook-cell-ids.md)

 - [Установить пакеты](operations/projects/install-dependencies.md)

 - [Примеры кода в ноутбуке](operations/projects/snippets.md)

 - [Очистить вывод ячеек ноутбука](operations/projects/clear-outputs.md)

 - [Работа с Git](operations/projects/work-with-git.md)

 - [Настроить создание ноутбуков по шаблону](operations/projects/templates.md)

### Работа с ресурсами

 - [Работа с секретами](operations/data/secrets.md)

 - [Работа с шаблонами Yandex Data Processing](operations/data-processing-template.md)

 - [Работа с Docker-образами](operations/user-images.md)

 - [Работа с датасетами](operations/data/dataset.md)

 - [Работа с коннекторами S3](operations/data/s3-connectors.md)

 - [Работа с коннекторами Spark](operations/data/spark-connectors.md)

 - [Работа с моделями](operations/data/models.md)

 - [Работа с файловыми хранилищами](operations/data/filestores.md)

### Подключение к источникам данных

 - [Подключение к S3 с помощью библиотеки boto3](operations/data/connect-to-s3.md)

 - [Подключение к базе данных ClickHouse®](operations/data/connect-to-clickhouse.md)

 - [Подключение к базе данных PostgreSQL](operations/data/connect-to-postgresql.md)

 - [Подключение к Яндекс Диску](operations/data/connect-to-ya-disk.md)

 - [Подключение к Google Drive](operations/data/connect-to-google-drive.md)

### DataSphere Inference

 - [Создать ноду](operations/deploy/node-create.md)

 - [Изменить ноду](operations/deploy/node-update.md)

 - [Удалить ноду](operations/deploy/node-delete.md)

 - [Настроить окружение ноды](operations/deploy/node-customization.md)

 - [Отправить запрос в ноду](operations/deploy/node-api.md)

 - [Остановить или возобновить ноду](operations/deploy/node-suspend-resume.md)

 - [Создать алиас](operations/deploy/alias-create.md)

 - [Изменить алиас](operations/deploy/alias-update.md)

 - [Удалить алиас](operations/deploy/alias-delete.md)

 - [Отправить запрос в алиас](operations/deploy/alias-api.md)

### DataSphere Jobs

 - [Аутентификация в DataSphere Jobs](operations/projects/authentication.md)

 - [Запустить задание DataSphere Jobs](operations/projects/work-with-jobs.md)

 - [Работа с заданиями из Visual Studio Code](operations/projects/jobs-toolkit.md)

 - [Использование результатов работы выполненных заданий](operations/projects/use-job-results.md)

 - [Работа с сервисным агентом из задания](operations/projects/jobs-with-ssa.md)

### Совместный доступ

 - [Опубликовать ноутбук](operations/projects/publication.md)

 - [Экспортировать проект](operations/projects/export.md)

 - [Открыть ноутбук в DataSphere](operations/projects/open-in-datasphere.md)

 - [Как перенести работу в новую версию](operations/migration.md)

## Концепции

 - [О сервисе DataSphere](concepts/index.md)

 - [Взаимосвязь ресурсов в DataSphere](concepts/resource-model.md)

 - [Сообщества](concepts/community.md)

 - [Управление расходами](concepts/budget.md)

 - [Проект](concepts/project.md)

 - [Конфигурации вычислительных ресурсов](concepts/configurations.md)

### DataSphere Notebook

 - [Список предустановленного ПО](concepts/preinstalled-packages.md)

 - [Доступные команды](concepts/magic.md)

#### Вычисления на кластерах Apache Spark™

 - [Способы работы с кластерами Apache Spark™](concepts/data-processing.md)

 - [Вычисления на кластерах Apache Spark™](concepts/data-processing-operations.md)

 - [Особенности работы с временными кластерами Yandex Data Processing](concepts/temporary-data-processing-clusters.md)

### DataSphere Inference

 - [Ноды и алиасы](concepts/deploy/index.md)

 - [Проверки состояния и мониторинг](concepts/deploy/monitoring.md)

 - [Метрики нод](concepts/deploy/metrics.md)

### DataSphere Jobs

 - [Задания](concepts/jobs/index.md)

 - [DataSphere CLI](concepts/jobs/cli.md)

 - [Docker-образы в заданиях](concepts/jobs/docker.md)

 - [Среда исполнения заданий](concepts/jobs/environment.md)

 - [Повторный запуск заданий](concepts/jobs/fork.md)

 - [Интеграция с Managed Service for Apache Airflow™](concepts/jobs/airflow.md)

 - [Работа с коннекторами Spark](concepts/jobs/work-with-spark.md)

### Ресурсы

 - [Обзор](concepts/resources.md)

 - [Секреты](concepts/secrets.md)

 - [Docker-образы](concepts/docker.md)

 - [Датасеты](concepts/dataset.md)

 - [Шаблоны Yandex Data Processing](concepts/data-processing-template.md)

 - [Коннекторы S3](concepts/s3-connector.md)

 - [Коннекторы Spark](concepts/spark-connector.md)

 - [Модели](concepts/models/index.md)

 - [Файловые хранилища](concepts/filestores.md)

 - [Фундаментальные модели](concepts/models/foundation-models.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Специальные условия для образования](concepts/freetier.md)

## Как организовать работу в DataSphere

 - [Настроить проект для работы с облаком](tutorials/basics.md)

 - [Организовать сообщество для студентов](tutorials/community-for-students.md)

 - [Автоматизировать настройку проектов](tutorials/automation-community-settings.md)

 - [Интегрировать сервис Yandex Data Processing](tutorials/data-processing-integration.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

### Разработка

 - [Классификация изображений на видеокадрах](tutorials/video-recognition.md)

 - [Запуск вычислений по расписанию](tutorials/regular-launch.md)

 - [Запуск вычислений с помощью API](tutorials/batch-code-execution.md)

 - [Геокодинг с помощью API Яндекс Карт для визуализации в DataLens](tutorials/data-from-ch-geocoder.md)

 - [Обучение модели на данных из Yandex Object Storage](tutorials/s3-to-datasphere.md)

 - [Создание сервера MLFlow для логирования экспериментов и артефактов](tutorials/mlflow-datasphere.md)

### Эксплуатация

 - [Развертывание сервиса на основе Docker-образа](tutorials/node-from-docker.md)

 - [Развертывание сервиса на основе Docker-образа с FastAPI](tutorials/node-from-docker-fast-api.md)

 - [Развертывание сервиса на основе модели ONNX](tutorials/node-from-model.md)

 - [Развертывание gRPC-сервиса на основе Docker-образа](tutorials/grpc-node.md)

 - [Генерация изображения с помощью модели Stable Diffusion](tutorials/stable-diffusion.md)

 - [Создание интеллектуального ассистента для Telegram](tutorials/tg-bot-assistant.md)

### Аналитика данных

 - [Веб-аналитика с расчетом воронок и когорт на данных Яндекс Метрики](tutorials/data-from-metrica-yc-visualization.md)

 - [AppMetrica: экспорт, постобработка и визуализация данных](tutorials/data-from-appmetrica-yc-visualization.md)

 - [Анализ данных с помощью Query](tutorials/yq.md)

 - [Работа с данными в Object Storage](tutorials/yq-storage.md)

 - [Работа с данными в Managed Service for ClickHouse®](tutorials/yq-clickhouse.md)

 - [Работа с данными в Managed Service for PostgreSQL](tutorials/yq-postgre.md)

 - [Федеративные запросы к данным](tutorials/yq-federative-queries.md)

 - [Использование сервиса Yandex Managed Service for Apache Spark™](tutorials/spark-and-datasphere.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Обзор](api-ref/overview.md)

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Community

 - [Overview](api-ref/grpc/Community/index.md)

 - [Create](api-ref/grpc/Community/create.md)

 - [Get](api-ref/grpc/Community/get.md)

 - [Update](api-ref/grpc/Community/update.md)

 - [Delete](api-ref/grpc/Community/delete.md)

 - [List](api-ref/grpc/Community/list.md)

 - [ListAccessBindings](api-ref/grpc/Community/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Community/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Community/updateAccessBindings.md)

 - [AddResource](api-ref/grpc/Community/addResource.md)

 - [RemoveResource](api-ref/grpc/Community/removeResource.md)

 - [GetRestrictionsMeta](api-ref/grpc/Community/getRestrictionsMeta.md)

 - [GetRestrictions](api-ref/grpc/Community/getRestrictions.md)

 - [SetRestrictions](api-ref/grpc/Community/setRestrictions.md)

#### Dataset

 - [Overview](api-ref/grpc/Dataset/index.md)

 - [Activate](api-ref/grpc/Dataset/activate.md)

 - [Deactivate](api-ref/grpc/Dataset/deactivate.md)

#### DockerImage

 - [Overview](api-ref/grpc/DockerImage/index.md)

 - [Activate](api-ref/grpc/DockerImage/activate.md)

#### DockerImageV2

 - [Overview](api-ref/grpc/DockerImageV2/index.md)

 - [SetActive](api-ref/grpc/DockerImageV2/setActive.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Project

 - [Overview](api-ref/grpc/Project/index.md)

 - [Create](api-ref/grpc/Project/create.md)

 - [Update](api-ref/grpc/Project/update.md)

 - [Delete](api-ref/grpc/Project/delete.md)

 - [Open](api-ref/grpc/Project/open.md)

 - [Get](api-ref/grpc/Project/get.md)

 - [List](api-ref/grpc/Project/list.md)

 - [GetUnitBalance](api-ref/grpc/Project/getUnitBalance.md)

 - [SetUnitBalance](api-ref/grpc/Project/setUnitBalance.md)

 - [Execute](api-ref/grpc/Project/execute.md)

 - [ListAccessBindings](api-ref/grpc/Project/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Project/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Project/updateAccessBindings.md)

 - [AddResource](api-ref/grpc/Project/addResource.md)

 - [RemoveResource](api-ref/grpc/Project/removeResource.md)

 - [ResizeDisk](api-ref/grpc/Project/resizeDisk.md)

 - [GetRestrictionsMeta](api-ref/grpc/Project/getRestrictionsMeta.md)

 - [GetRestrictions](api-ref/grpc/Project/getRestrictions.md)

 - [SetRestrictions](api-ref/grpc/Project/setRestrictions.md)

#### S3

 - [Overview](api-ref/grpc/S3/index.md)

 - [Activate](api-ref/grpc/S3/activate.md)

 - [Deactivate](api-ref/grpc/S3/deactivate.md)

#### DataSphere Jobs API v2

 - [Overview](jobs/api-ref/grpc/index.md)

##### Operation

 - [Overview](jobs/api-ref/grpc/Operation/index.md)

 - [Get](jobs/api-ref/grpc/Operation/get.md)

 - [Cancel](jobs/api-ref/grpc/Operation/cancel.md)

##### ProjectJob

 - [Overview](jobs/api-ref/grpc/ProjectJob/index.md)

 - [Create](jobs/api-ref/grpc/ProjectJob/create.md)

 - [Clone](jobs/api-ref/grpc/ProjectJob/clone.md)

 - [Execute](jobs/api-ref/grpc/ProjectJob/execute.md)

 - [Cancel](jobs/api-ref/grpc/ProjectJob/cancel.md)

 - [ReadStdLogs](jobs/api-ref/grpc/ProjectJob/readStdLogs.md)

 - [ReadLogs](jobs/api-ref/grpc/ProjectJob/readLogs.md)

 - [DownloadJobFiles](jobs/api-ref/grpc/ProjectJob/downloadJobFiles.md)

 - [List](jobs/api-ref/grpc/ProjectJob/list.md)

 - [Get](jobs/api-ref/grpc/ProjectJob/get.md)

 - [Delete](jobs/api-ref/grpc/ProjectJob/delete.md)

 - [DeleteData](jobs/api-ref/grpc/ProjectJob/deleteData.md)

 - [DeleteAllData](jobs/api-ref/grpc/ProjectJob/deleteAllData.md)

 - [SetDataTtl](jobs/api-ref/grpc/ProjectJob/setDataTtl.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Community

 - [Overview](api-ref/Community/index.md)

 - [Create](api-ref/Community/create.md)

 - [Get](api-ref/Community/get.md)

 - [Update](api-ref/Community/update.md)

 - [Delete](api-ref/Community/delete.md)

 - [List](api-ref/Community/list.md)

 - [ListAccessBindings](api-ref/Community/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Community/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Community/updateAccessBindings.md)

 - [AddResource](api-ref/Community/addResource.md)

 - [RemoveResource](api-ref/Community/removeResource.md)

 - [GetRestrictionsMeta](api-ref/Community/getRestrictionsMeta.md)

 - [GetRestrictions](api-ref/Community/getRestrictions.md)

 - [SetRestrictions](api-ref/Community/setRestrictions.md)

#### Dataset

 - [Overview](api-ref/Dataset/index.md)

 - [Activate](api-ref/Dataset/activate.md)

 - [Deactivate](api-ref/Dataset/deactivate.md)

#### DockerImage

 - [Overview](api-ref/DockerImage/index.md)

 - [Activate](api-ref/DockerImage/activate.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Project

 - [Overview](api-ref/Project/index.md)

 - [Create](api-ref/Project/create.md)

 - [Update](api-ref/Project/update.md)

 - [Delete](api-ref/Project/delete.md)

 - [Open](api-ref/Project/open.md)

 - [Get](api-ref/Project/get.md)

 - [List](api-ref/Project/list.md)

 - [GetUnitBalance](api-ref/Project/getUnitBalance.md)

 - [SetUnitBalance](api-ref/Project/setUnitBalance.md)

 - [Execute](api-ref/Project/execute.md)

 - [ListAccessBindings](api-ref/Project/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Project/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Project/updateAccessBindings.md)

 - [AddResource](api-ref/Project/addResource.md)

 - [RemoveResource](api-ref/Project/removeResource.md)

 - [GetRestrictionsMeta](api-ref/Project/getRestrictionsMeta.md)

 - [GetRestrictions](api-ref/Project/getRestrictions.md)

 - [SetRestrictions](api-ref/Project/setRestrictions.md)

#### S3

 - [Overview](api-ref/S3/index.md)

 - [Activate](api-ref/S3/activate.md)

 - [Deactivate](api-ref/S3/deactivate.md)

#### DataSphere Jobs API v2

 - [Overview](jobs/api-ref/index.md)

##### Operation

 - [Overview](jobs/api-ref/Operation/index.md)

 - [Get](jobs/api-ref/Operation/get.md)

 - [Cancel](jobs/api-ref/Operation/cancel.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Решение проблем

 - [Проблемы с установкой библиотек](qa/environment-problems.md)

 - [Ошибки при работе коннектора Spark](troubleshooting/troubles-with-spark.md)

 - [Вопросы и ответы](qa/index.md)