# Yandex MetaData Hub

Yandex MetaData Hub — сервис Yandex Cloud, предоставляющий клиентам возможности управления подключениями к базам данных, хранения схем обмена данными и описания наборов данных, а также систему управления метаданными.

<em>Apache® и <a href="https://hive.apache.org/">Apache Hive™</a> являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах.</em>

# Yandex MetaData Hub

 - [О сервисе {{ metadata-hub-full-name }}](concepts/index.md)

## {{ connection-manager-name }}

 - [Начало работы](quickstart/connection-manager.md)

### Пошаговые инструкции

 - [Просмотр подключения](operations/view-connection.md)

 - [Создание подключения](operations/create-connection.md)

 - [Изменение подключения](operations/update-connection.md)

 - [Настройка прав доступа к подключению](operations/connection-access.md)

 - [Удаление подключения](operations/delete-connection.md)

 - [Получение информации об операции](operations/operation-connection.md)

 - [Отмена операции](operations/cancel-operation.md)

### Практические руководства

 - [Настройка прав доступа к секрету, созданному {{ connection-manager-name }}, для пользователя {{ mpg-name }}](tutorials/conn-man-secret-access.md)

### Концепции

 - [Подключение](concepts/connection-manager.md)

 - [Секрет](concepts/secret.md)

 - [Сервисные роли для управления доступом](security/connection-manager-roles.md)

 - [Справочник CLI (англ.)](../cli/cli-ref/metadata-hub/cli-ref/connection-manager/index.md)

 - [Справочник {{ TF }}](connman-tf-ref.md)

### Справочник API

 - [Аутентификация в API](api-ref/authentication-connman.md)

#### gRPC (англ.)

 - [Overview](connection-manager/api-ref/grpc/index.md)

##### Connection

 - [Overview](connection-manager/api-ref/grpc/Connection/index.md)

 - [Get](connection-manager/api-ref/grpc/Connection/get.md)

 - [ResolveCluster](connection-manager/api-ref/grpc/Connection/resolveCluster.md)

 - [List](connection-manager/api-ref/grpc/Connection/list.md)

 - [Create](connection-manager/api-ref/grpc/Connection/create.md)

 - [Update](connection-manager/api-ref/grpc/Connection/update.md)

 - [Delete](connection-manager/api-ref/grpc/Connection/delete.md)

 - [ListOperations](connection-manager/api-ref/grpc/Connection/listOperations.md)

##### Operation

 - [Overview](connection-manager/api-ref/grpc/Operation/index.md)

 - [Get](connection-manager/api-ref/grpc/Operation/get.md)

 - [Cancel](connection-manager/api-ref/grpc/Operation/cancel.md)

#### REST (англ.)

 - [Overview](connection-manager/api-ref/index.md)

##### Connection

 - [Overview](connection-manager/api-ref/Connection/index.md)

 - [Get](connection-manager/api-ref/Connection/get.md)

 - [ResolveCluster](connection-manager/api-ref/Connection/resolveCluster.md)

 - [List](connection-manager/api-ref/Connection/list.md)

 - [Create](connection-manager/api-ref/Connection/create.md)

 - [Update](connection-manager/api-ref/Connection/update.md)

 - [Delete](connection-manager/api-ref/Connection/delete.md)

 - [ListOperations](connection-manager/api-ref/Connection/listOperations.md)

##### Operation

 - [Overview](connection-manager/api-ref/Operation/index.md)

 - [Get](connection-manager/api-ref/Operation/get.md)

 - [Cancel](connection-manager/api-ref/Operation/cancel.md)

## {{ metastore-full-name }}

 - [Начало работы](quickstart/metastore.md)

### Пошаговые инструкции

 - [Получение информации о кластерах](operations/metastore/cluster-list.md)

 - [Создание кластера](operations/metastore/cluster-create.md)

 - [Изменение кластера](operations/metastore/cluster-update.md)

 - [Остановка и запуск кластера](operations/metastore/cluster-stop.md)

 - [Настройка группы безопасности](operations/metastore/configure-security-group.md)

 - [Подключение {{ dataproc-name }} к {{ metastore-name }}](operations/metastore/data-processing-connect.md)

 - [Экспорт и импорт кластера](operations/metastore/export-and-import.md)

 - [Подключение к бакету {{ objstorage-full-name }} с политикой доступа](operations/metastore/s3-policy-connect.md)

 - [Передача логов в {{ cloud-logging-name }}](operations/metastore/logging.md)

 - [Управление доступом к кластеру](operations/metastore/cluster-access.md)

 - [Удаление кластера](operations/metastore/cluster-delete.md)

### Практические руководства

 - [Совместная работа с таблицами {{ dataproc-name }} с использованием {{ metastore-name }}](tutorials/sharing-tables.md)

 - [Перенос метаданных между кластерами {{ dataproc-name }} с помощью {{ metastore-name }}](tutorials/metastore-import.md)

 - [Работа с таблицей в {{ objstorage-name }} из PySpark-задания](tutorials/spark-simple-rw-job.md)

 - [Интеграция {{ msp-full-name }} и {{ metastore-name }}](tutorials/metastore-and-spark.md)

 - [Автоматизация работы с помощью {{ maf-full-name }}](tutorials/airflow-automation.md)

 - [Совместная работа с таблицами с использованием {{ metastore-name }}](tutorials/data-processing-to-data-processing.md)

### Концепции

 - [Кластеры {{ metastore-name }}](concepts/metastore.md)

 - [Имперсонация в {{ metastore-name }}](concepts/metastore-impersonation.md)

 - [Сервисные роли для управления доступом](security/metastore-roles.md)

 - [Решение проблем](qa/metastore-qa.md)

### Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

#### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [export-data](cli-ref/cluster/export-data.md)

 - [get](cli-ref/cluster/get.md)

 - [import-data](cli-ref/cluster/import-data.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

#### v0

 - [Overview](cli-ref/v0/index.md)

##### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [export-data](cli-ref/v0/cluster/export-data.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [import-data](cli-ref/v0/cluster/import-data.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [Справочник {{ TF }}](metastore-tf-ref.md)

### Справочник API

 - [Аутентификация в API](api-ref/authentication-metastore.md)

#### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

##### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [ImportData](api-ref/grpc/Cluster/importData.md)

 - [ExportData](api-ref/grpc/Cluster/exportData.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

##### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### REST (англ.)

 - [Overview](api-ref/index.md)

##### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [ImportData](api-ref/Cluster/importData.md)

 - [ExportData](api-ref/Cluster/exportData.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

##### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

## {{ schema-registry-name }}

 - [Начало работы](quickstart/schema-registry.md)

### Пошаговые инструкции

#### Пространство имен

 - [Создание пространства имен](operations/create-name-space.md)

 - [Просмотр списка пространств имен](operations/list-name-space.md)

 - [Изменение пространства имен](operations/update-name-space.md)

 - [Подключение к пространству имен](operations/connect-to-namespace.md)

 - [Удаление пространства имен](operations/delete-name-space.md)

#### Схемы

 - [Загрузка схемы в новый субъект](operations/upload-schema-to-subject.md)

 - [Добавление схемы в существующий субъект](operations/add-schema.md)

 - [Просмотр схемы](operations/view-schema.md)

 - [Сравнение схем](operations/compare-schemas.md)

 - [Удаление схемы](operations/delete-schema.md)

#### Субъекты

 - [Создание субъекта](operations/create-subject.md)

 - [Изменение субъекта](operations/update-subject.md)

 - [Удаление субъекта](operations/delete-subject.md)

### Практические руководства

 - [Поставка данных в формате Debezium CDC из {{ KF }}](tutorials/schema-registry-cdc-debezium-kafka.md)

### Концепции

 - [Реестр схем](concepts/schema-registry.md)

 - [Совместимость JSON-схем](concepts/schema-compatibility.md)

 - [Контентные модели и проблемы эволюции JSON-схем](concepts/schema-registry-content-model.md)

 - [Политики проверки совместимости](concepts/compatibility-check-policy.md)

 - [Сервисные роли для управления доступом](security/schema-registry-roles.md)

 - [Решение проблем](qa/schema-registry-qa.md)

### Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

 - [Schema Registry](api-ref/schema-registry/index.md)

## {{ data-catalog-name }}

### Начало работы

 - [Начало работы управляющего метаданными](quickstart/data-steward-quickstart.md)

 - [Начало работы аналитика метаданных](quickstart/data-analyst-quickstart.md)

### Пошаговые инструкции

#### Каталог

 - [Получение списка каталогов](operations/data-catalog/catalog-list.md)

 - [Создание каталога](operations/data-catalog/create-catalog.md)

 - [Изменение каталога](operations/data-catalog/update-catalog.md)

 - [Получение списка операций](operations/data-catalog/catalog-operations.md)

 - [Удаление каталога](operations/data-catalog/delete-catalog.md)

#### Источники

 - [Получение списка источников](operations/data-catalog/source-list.md)

 - [Создание источника](operations/data-catalog/create-source.md)

 - [Изменение источника](operations/data-catalog/update-source.md)

 - [Удаление источника](operations/data-catalog/delete-source.md)

#### Загрузки

 - [Получение списка загрузок](operations/data-catalog/list-ingestions.md)

 - [Создание загрузки](operations/data-catalog/create-ingestion.md)

 - [Запуск загрузки](operations/data-catalog/start-ingestion.md)

 - [Изменение загрузки](operations/data-catalog/update-ingestion.md)

 - [Получение информации о загрузке](operations/data-catalog/get-info-ingestion.md)

 - [Удаление загрузки](operations/data-catalog/delete-ingestion.md)

#### Работа с данными

 - [Разметка метаданных](operations/data-catalog/markup-metadata.md)

 - [Поиск метаданных](operations/data-catalog/search-metadata.md)

 - [Анализ связей между метаданными](operations/data-catalog/analysis-metadata.md)

 - [Получение профиля данных](operations/data-catalog/get-data-profile.md)

 - [Запросы к наборам данных с помощью {{ websql-full-name }}](operations/data-catalog/web-sql-query.md)

#### Домены

 - [Получение списка доменов и поддоменов](operations/data-catalog/list-domains.md)

 - [Создание домена](operations/data-catalog/create-domain.md)

 - [Изменение домена](operations/data-catalog/update-domain.md)

 - [Удаление домена](operations/data-catalog/delete-domain.md)

#### Глоссарии

 - [Получение списка глоссариев](operations/data-catalog/list-glossaries.md)

 - [Создание глоссария](operations/data-catalog/create-glossary.md)

 - [Изменение глоссария](operations/data-catalog/update-glossary.md)

 - [Удаление глоссария](operations/data-catalog/delete-glossary.md)

#### Термины

 - [Получение списка терминов](operations/data-catalog/list-terms.md)

 - [Получение списка дочерних терминов](operations/data-catalog/list-terms-child.md)

 - [Создание термина](operations/data-catalog/create-term.md)

 - [Создание дочернего термина](operations/data-catalog/create-term-child.md)

 - [Изменение термина](operations/data-catalog/update-term.md)

 - [Удаление термина](operations/data-catalog/delete-term.md)

 - [Удаление дочернего термина](operations/data-catalog/delete-term-child.md)

#### Классификации

 - [Получение списка классификаций](operations/data-catalog/list-classifications.md)

 - [Создание классификации](operations/data-catalog/create-classification.md)

 - [Изменение классификации](operations/data-catalog/update-classification.md)

 - [Удаление классификации](operations/data-catalog/delete-classification.md)

#### Теги

 - [Получение списка тегов](operations/data-catalog/list-tags.md)

 - [Создание тега](operations/data-catalog/create-tag.md)

 - [Изменение тега](operations/data-catalog/update-tag.md)

 - [Удаление тега](operations/data-catalog/delete-tag.md)

#### Хранилище данных

 - [Получение списка хранилищ данных](operations/data-catalog/list-data-store.md)

 - [Получение информации о хранилище данных](operations/data-catalog/get-info-data-store.md)

 - [Разметка хранилища данных](operations/data-catalog/markup-data-store.md)

### Практические руководства

 - [Интеграция AI-аналитика данных с {{ data-catalog-name }}](tutorials/ai-studio-data-catalog-integration.md)

### Концепции

 - [Каталог метаданных](concepts/data-catalog.md)

 - [Сервисные роли для управления доступом](security/data-catalog-roles.md)

 - [Управление доступом](security/index.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Правила тарификации](pricing.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes/index.md)

 - [Решение проблем](qa/index.md)

 - [Начало работы в сервисе](quickstart/index.md)

 - [Все пошаговые инструкции](operations/index.md)

 - [Все руководства](tutorials/index.md)