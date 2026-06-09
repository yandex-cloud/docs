# Yandex Lockbox

Yandex Lockbox — сервис для хранения секретов.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_lockbox">Уровень обслуживания Yandex Lockbox</a>.

# Yandex Lockbox

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создать секрет](operations/secret-create.md)

 - [Изменить секрет](operations/secret-update.md)

 - [Настроить права доступа к секрету](operations/secret-access.md)

 - [Получить информацию о секрете](operations/secret-get-info.md)

 - [Удалить секрет](operations/secret-delete.md)

 - [Деактивировать и активировать секрет](operations/secret-activation-manage.md)

 - [Управление версиями секрета](operations/secret-version-manage.md)

### Serverless

 - [Передать секрет в {{ serverless-containers-full-name }}](operations/serverless/containers.md)

 - [Передать секрет в {{ sf-full-name }}](operations/serverless/functions.md)

 - [Посмотреть операции с секретом](operations/operation-logs.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Секрет](concepts/secret.md)

 - [Интеграция с сервисами {{ yandex-cloud }}](concepts/services.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Синхронизация с секретами Managed Service for Kubernetes](tutorials/kubernetes-lockbox-secrets.md)

 - [Хранение подключений и переменных {{ AF }} в {{ lockbox-full-name }}](tutorials/lockbox-and-airflow.md)

 - [Построение пайплайна CI/CD в {{ GL }} с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

 - [Безопасное хранение паролей для {{ GL }} CI в виде секретов {{ lockbox-name }}](tutorials/gitlab-lockbox-integration.md)

### Хранение статического ключа доступа в секрете {{ lockbox-name }}

 - [Обзор](tutorials/static-key-in-lockbox/index.md)

 - [CLI](tutorials/static-key-in-lockbox/console.md)

 - [{{ TF }}](tutorials/static-key-in-lockbox/terraform.md)

 - [Загрузка данных из {{ yandex-direct }} в витрину {{ mch-full-name }} с использованием {{ sf-full-name }}, {{ objstorage-full-name }} и {{ data-transfer-full-name }}](tutorials/data-transfer-direct-to-mch.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](tutorials/nodejs-cron-restart-vm.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Автоматическое копирование объектов из одного бакета {{ objstorage-name }} в другой](tutorials/bucket-to-bucket-copying.md)

### Безопасная передача пароля в скрипт инициализации

 - [Обзор](tutorials/secure-password-script/index.md)

 - [Консоль управления, CLI, API](tutorials/secure-password-script/console.md)

 - [{{ TF }}](tutorials/secure-password-script/terraform.md)

 - [Использование секрета в PySpark-задании для подключения к {{ mpg-full-name }}](tutorials/job-pyspark-secret-access.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### payload

 - [Overview](cli-ref/payload/index.md)

 - [get](cli-ref/payload/get.md)

### secret

 - [Overview](cli-ref/secret/index.md)

 - [activate](cli-ref/secret/activate.md)

 - [add-access-binding](cli-ref/secret/add-access-binding.md)

 - [add-version](cli-ref/secret/add-version.md)

 - [cancel-version-destruction](cli-ref/secret/cancel-version-destruction.md)

 - [create](cli-ref/secret/create.md)

 - [deactivate](cli-ref/secret/deactivate.md)

 - [delete](cli-ref/secret/delete.md)

 - [get](cli-ref/secret/get.md)

 - [list](cli-ref/secret/list.md)

 - [list-access-bindings](cli-ref/secret/list-access-bindings.md)

 - [list-operations](cli-ref/secret/list-operations.md)

 - [list-versions](cli-ref/secret/list-versions.md)

 - [remove-access-binding](cli-ref/secret/remove-access-binding.md)

 - [schedule-version-destruction](cli-ref/secret/schedule-version-destruction.md)

 - [set-access-bindings](cli-ref/secret/set-access-bindings.md)

 - [update](cli-ref/secret/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### payload

 - [Overview](cli-ref/v0/payload/index.md)

 - [get](cli-ref/v0/payload/get.md)

#### secret

 - [Overview](cli-ref/v0/secret/index.md)

 - [activate](cli-ref/v0/secret/activate.md)

 - [add-access-binding](cli-ref/v0/secret/add-access-binding.md)

 - [add-version](cli-ref/v0/secret/add-version.md)

 - [cancel-version-destruction](cli-ref/v0/secret/cancel-version-destruction.md)

 - [create](cli-ref/v0/secret/create.md)

 - [deactivate](cli-ref/v0/secret/deactivate.md)

 - [delete](cli-ref/v0/secret/delete.md)

 - [get](cli-ref/v0/secret/get.md)

 - [list](cli-ref/v0/secret/list.md)

 - [list-access-bindings](cli-ref/v0/secret/list-access-bindings.md)

 - [list-operations](cli-ref/v0/secret/list-operations.md)

 - [list-versions](cli-ref/v0/secret/list-versions.md)

 - [remove-access-binding](cli-ref/v0/secret/remove-access-binding.md)

 - [schedule-version-destruction](cli-ref/v0/secret/schedule-version-destruction.md)

 - [set-access-bindings](cli-ref/v0/secret/set-access-bindings.md)

 - [update](cli-ref/v0/secret/update.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Payload

 - [Overview](api-ref/grpc/Payload/index.md)

 - [Get](api-ref/grpc/Payload/get.md)

 - [GetEx](api-ref/grpc/Payload/getEx.md)

#### Secret

 - [Overview](api-ref/grpc/Secret/index.md)

 - [Get](api-ref/grpc/Secret/get.md)

 - [List](api-ref/grpc/Secret/list.md)

 - [Create](api-ref/grpc/Secret/create.md)

 - [Update](api-ref/grpc/Secret/update.md)

 - [Delete](api-ref/grpc/Secret/delete.md)

 - [Activate](api-ref/grpc/Secret/activate.md)

 - [Deactivate](api-ref/grpc/Secret/deactivate.md)

 - [ListVersions](api-ref/grpc/Secret/listVersions.md)

 - [AddVersion](api-ref/grpc/Secret/addVersion.md)

 - [ScheduleVersionDestruction](api-ref/grpc/Secret/scheduleVersionDestruction.md)

 - [CancelVersionDestruction](api-ref/grpc/Secret/cancelVersionDestruction.md)

 - [ListOperations](api-ref/grpc/Secret/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Secret/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Secret/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Secret/updateAccessBindings.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Payload

 - [Overview](api-ref/Payload/index.md)

 - [Get](api-ref/Payload/get.md)

 - [GetEx](api-ref/Payload/getEx.md)

#### Secret

 - [Overview](api-ref/Secret/index.md)

 - [Get](api-ref/Secret/get.md)

 - [List](api-ref/Secret/list.md)

 - [Create](api-ref/Secret/create.md)

 - [Update](api-ref/Secret/update.md)

 - [Delete](api-ref/Secret/delete.md)

 - [Activate](api-ref/Secret/activate.md)

 - [Deactivate](api-ref/Secret/deactivate.md)

 - [ListVersions](api-ref/Secret/listVersions.md)

 - [AddVersion](api-ref/Secret/addVersion.md)

 - [ScheduleVersionDestruction](api-ref/Secret/scheduleVersionDestruction.md)

 - [CancelVersionDestruction](api-ref/Secret/cancelVersionDestruction.md)

 - [ListOperations](api-ref/Secret/listOperations.md)

 - [ListAccessBindings](api-ref/Secret/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Secret/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Secret/updateAccessBindings.md)

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)