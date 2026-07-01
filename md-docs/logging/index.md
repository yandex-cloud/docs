# Yandex Cloud Logging

Сервис Yandex Cloud Logging позволяет читать и записывать логи сервисов и пользовательских приложений, объединяя сообщения в лог-группы.

Сервис Cloud Logging будет закрыт во II квартале 2027 года и заменен платформой Monium.

# Yandex Cloud Logging

 - [Начало работы](quickstart.md)

 - [Миграция на Monium](migration-to-monium.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Добавление записей](operations/write-logs.md)

 - [Чтение записей](operations/read-logs.md)

 - [Управление правами доступа к лог-группе](operations/access-rights.md)

### Получение информации о лог-группе

 - [Получить список лог-групп](operations/list.md)

 - [Получить информацию о лог-группе](operations/get-group.md)

### Управление лог-группой

 - [Создать лог-группу](operations/create-group.md)

 - [Изменить лог-группу](operations/retention-period.md)

 - [Посмотреть графики мониторинга](operations/monitoring.md)

 - [Удалить лог-группу](operations/delete-group.md)

### Выгрузка логов

 - [Создать приемник логов](operations/create-sink.md)

#### Выгрузить логи

 - [Object Storage](operations/export-logs.md)

 - [Data Streams](operations/export-logs-yds.md)

 - [Получить список приемников логов](operations/list-sink.md)

 - [Получить информацию о приемнике логов](operations/get-sink.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Передача логов кластера Yandex Managed Service for Kubernetes в Cloud Logging](tutorials/k8s-fluent-bit-logging.md)

 - [Передача логов с ВМ в Cloud Logging](tutorials/vm-fluent-bit-logging.md)

 - [Передача логов с COI в Cloud Logging](tutorials/coi-fluent-bit-logging.md)

 - [Передача логов через HTTP-вход Unified Agent в Cloud Logging](tutorials/ua-http-logging.md)

 - [Репликация логов в Object Storage с помощью Fluent Bit](tutorials/replicate-logs-to-storage.md)

 - [Репликация логов в Object Storage с помощью Data Streams](tutorials/replicate-logs-to-storage-via-data-streams.md)

 - [Визуализация логов в Grafana с помощью плагина Yandex Cloud Logging](tutorials/grafana-logs-plugin.md)

 - [Интерактивная отладка функций Cloud Functions](tutorials/serverless-live-debug.md)

 - [Запись логов балансировщика в PostgreSQL](tutorials/logging.md)

 - [Настройки логирования для Ingress-контроллеров Application Load Balancer](tutorials/alb-ingress-controller-log-options.md)

 - [Обработка логов Cloud Logging](tutorials/cloud-logging.md)

 - [Настройка реагирования в Cloud Logging и Yandex Cloud Functions](tutorials/logging-functions.md)

 - [Поиск событий в аудитных логах](tutorials/search-events-audit-logs/index.md)

 - [Мониторинг записи событий в лог-группу](tutorials/log-group-record-monitoring.md)

 - [Передача логов кластера Yandex MPP Analytics for PostgreSQL в Yandex Cloud Logging](tutorials/mgp-to-cloud-logging.md)

## Концепции

 - [Лог-группа](concepts/log-group.md)

 - [Язык фильтрующих выражений](concepts/filter.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### group

 - [Overview](cli-ref/group/index.md)

 - [add-access-binding](cli-ref/group/add-access-binding.md)

 - [create](cli-ref/group/create.md)

 - [delete](cli-ref/group/delete.md)

 - [get](cli-ref/group/get.md)

 - [list](cli-ref/group/list.md)

 - [list-access-bindings](cli-ref/group/list-access-bindings.md)

 - [list-operations](cli-ref/group/list-operations.md)

 - [list-resources](cli-ref/group/list-resources.md)

 - [remove-access-binding](cli-ref/group/remove-access-binding.md)

 - [set-access-bindings](cli-ref/group/set-access-bindings.md)

 - [stats](cli-ref/group/stats.md)

 - [update](cli-ref/group/update.md)

 - [read](cli-ref/read.md)

### sink

 - [Overview](cli-ref/sink/index.md)

 - [add-access-binding](cli-ref/sink/add-access-binding.md)

 - [create](cli-ref/sink/create.md)

 - [delete](cli-ref/sink/delete.md)

 - [get](cli-ref/sink/get.md)

 - [list](cli-ref/sink/list.md)

 - [list-access-bindings](cli-ref/sink/list-access-bindings.md)

 - [list-operations](cli-ref/sink/list-operations.md)

 - [remove-access-binding](cli-ref/sink/remove-access-binding.md)

 - [set-access-bindings](cli-ref/sink/set-access-bindings.md)

 - [update](cli-ref/sink/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### group

 - [Overview](cli-ref/v0/group/index.md)

 - [add-access-binding](cli-ref/v0/group/add-access-binding.md)

 - [create](cli-ref/v0/group/create.md)

 - [delete](cli-ref/v0/group/delete.md)

 - [get](cli-ref/v0/group/get.md)

 - [list](cli-ref/v0/group/list.md)

 - [list-access-bindings](cli-ref/v0/group/list-access-bindings.md)

 - [list-operations](cli-ref/v0/group/list-operations.md)

 - [list-resources](cli-ref/v0/group/list-resources.md)

 - [remove-access-binding](cli-ref/v0/group/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/group/set-access-bindings.md)

 - [stats](cli-ref/v0/group/stats.md)

 - [update](cli-ref/v0/group/update.md)

 - [read](cli-ref/v0/read.md)

#### sink

 - [Overview](cli-ref/v0/sink/index.md)

 - [add-access-binding](cli-ref/v0/sink/add-access-binding.md)

 - [create](cli-ref/v0/sink/create.md)

 - [delete](cli-ref/v0/sink/delete.md)

 - [get](cli-ref/v0/sink/get.md)

 - [list](cli-ref/v0/sink/list.md)

 - [list-access-bindings](cli-ref/v0/sink/list-access-bindings.md)

 - [list-operations](cli-ref/v0/sink/list-operations.md)

 - [remove-access-binding](cli-ref/v0/sink/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/sink/set-access-bindings.md)

 - [update](cli-ref/v0/sink/update.md)

 - [write](cli-ref/v0/write.md)

 - [write](cli-ref/write.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Export

 - [Overview](api-ref/grpc/Export/index.md)

 - [Get](api-ref/grpc/Export/get.md)

 - [List](api-ref/grpc/Export/list.md)

 - [Create](api-ref/grpc/Export/create.md)

 - [Update](api-ref/grpc/Export/update.md)

 - [Delete](api-ref/grpc/Export/delete.md)

 - [Run](api-ref/grpc/Export/run.md)

 - [ListOperations](api-ref/grpc/Export/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Export/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Export/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Export/updateAccessBindings.md)

#### LogGroup

 - [Overview](api-ref/grpc/LogGroup/index.md)

 - [Get](api-ref/grpc/LogGroup/get.md)

 - [Stats](api-ref/grpc/LogGroup/stats.md)

 - [List](api-ref/grpc/LogGroup/list.md)

 - [Create](api-ref/grpc/LogGroup/create.md)

 - [Update](api-ref/grpc/LogGroup/update.md)

 - [Delete](api-ref/grpc/LogGroup/delete.md)

 - [ListResources](api-ref/grpc/LogGroup/listResources.md)

 - [ListOperations](api-ref/grpc/LogGroup/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/LogGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/LogGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/LogGroup/updateAccessBindings.md)

#### LogIngestion

 - [Overview](api-ref/grpc/LogIngestion/index.md)

 - [Write](api-ref/grpc/LogIngestion/write.md)

#### LogReading

 - [Overview](api-ref/grpc/LogReading/index.md)

 - [Read](api-ref/grpc/LogReading/read.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Sink

 - [Overview](api-ref/grpc/Sink/index.md)

 - [Get](api-ref/grpc/Sink/get.md)

 - [List](api-ref/grpc/Sink/list.md)

 - [Create](api-ref/grpc/Sink/create.md)

 - [Update](api-ref/grpc/Sink/update.md)

 - [Delete](api-ref/grpc/Sink/delete.md)

 - [ListOperations](api-ref/grpc/Sink/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Sink/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Sink/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Sink/updateAccessBindings.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Export

 - [Overview](api-ref/Export/index.md)

 - [Get](api-ref/Export/get.md)

 - [List](api-ref/Export/list.md)

 - [Create](api-ref/Export/create.md)

 - [Update](api-ref/Export/update.md)

 - [Delete](api-ref/Export/delete.md)

 - [Run](api-ref/Export/run.md)

 - [ListOperations](api-ref/Export/listOperations.md)

 - [ListAccessBindings](api-ref/Export/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Export/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Export/updateAccessBindings.md)

#### LogGroup

 - [Overview](api-ref/LogGroup/index.md)

 - [Get](api-ref/LogGroup/get.md)

 - [Stats](api-ref/LogGroup/stats.md)

 - [List](api-ref/LogGroup/list.md)

 - [Create](api-ref/LogGroup/create.md)

 - [Update](api-ref/LogGroup/update.md)

 - [Delete](api-ref/LogGroup/delete.md)

 - [ListResources](api-ref/LogGroup/listResources.md)

 - [ListOperations](api-ref/LogGroup/listOperations.md)

 - [ListAccessBindings](api-ref/LogGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/LogGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/LogGroup/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Sink

 - [Overview](api-ref/Sink/index.md)

 - [Get](api-ref/Sink/get.md)

 - [List](api-ref/Sink/list.md)

 - [Create](api-ref/Sink/create.md)

 - [Update](api-ref/Sink/update.md)

 - [Delete](api-ref/Sink/delete.md)

 - [ListOperations](api-ref/Sink/listOperations.md)

 - [ListAccessBindings](api-ref/Sink/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Sink/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Sink/updateAccessBindings.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)