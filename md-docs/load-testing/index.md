# Yandex Load Testing

С 1 июля 2026 года сервис Load Testing прекращает работу.

Подробнее о сроках и порядке закрытия читайте на странице <a href="sunset.md">Закрытие сервиса</a>.

Чтобы перенести сценарии нагрузочного тестирования на k6, воспользуйтесь <a href="tutorials/loadtesting-migration-to-k6.md">инструкцией по миграции</a>.

# Yandex Load Testing

 - [Закрытие сервиса](sunset.md)

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создать агент тестирования](operations/create-agent.md)

 - [Настроить группы безопасности агента тестирования](operations/security-groups-agent.md)

 - [Настроить группы безопасности цели тестирования](operations/security-groups-target.md)

 - [Создать тест с данными из бакета](operations/create-test-bucket.md)

### Управление дашбордом регрессий

 - [Создать и настроить дашборд](operations/regressions/create.md)

 - [Редактировать данные на дашборде](operations/regressions/update.md)

 - [Удалить дашборд](operations/regressions/delete.md)

 - [Экспорт отчётов с результатами тестирования](operations/export-test-reports.md)

 - [Собрать пользовательские запросы с помощью Dispatcher](operations/payload-dispatcher.md)

 - [Создать и настроить дашборд регрессий](operations/regressions.md)

 - [Проверить превышение порогов метрик регрессий](operations/check-regression.md)

 - [Сохранить артефакты теста в Object Storage](operations/save-artifacts.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Нагрузочное тестирование gRPC-сервиса](tutorials/loadtesting-grpc.md)

 - [Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием](tutorials/loadtesting-grpc-autoscaling.md)

 - [HTTPS-тест с постоянной нагрузкой с помощью Phantom](tutorials/loadtesting-https-phantom.md)

 - [HTTPS-тест со ступенчатой нагрузкой с помощью Pandora](tutorials/loadtesting-https-pandora.md)

 - [HTTP-тест с нагрузкой по сценарию с помощью Pandora](tutorials/loadtesting-http-scenario-pandora.md)

 - [Нагрузочный тест с помощью JMeter](tutorials/loadtesting-jmeter.md)

 - [Нагрузочное тестирование с нескольких агентов](tutorials/loadtesting-multiply.md)

 - [Запуск внешних агентов для нагрузочного тестирования](tutorials/loadtesting-external-agent.md)

 - [Вызов нагрузочного тестирования из GitLab CI](tutorials/loadtesting-gitlab-ci.md)

 - [Сравнение результатов нагрузочных тестов](tutorials/loadtesting-results-compare.md)

 - [Миграция нагрузочного тестирования на k6](tutorials/loadtesting-migration-to-k6.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Агент](concepts/agent.md)

 - [Выбор агента](concepts/agent-select.md)

 - [Генератор нагрузки](concepts/load-generator.md)

 - [Профиль нагрузки](concepts/load-profile.md)

### Тестовые данные и их типы

 - [Обзор](concepts/payload.md)

 - [URI](concepts/payloads/uri.md)

 - [URIPOST](concepts/payloads/uripost.md)

 - [PHANTOM](concepts/payloads/phantom.md)

 - [RAW](concepts/payloads/raw.md)

 - [HTTP_JSON](concepts/payloads/http-json.md)

 - [GRPC_JSON](concepts/payloads/grpc-json.md)

 - [Тестирующие потоки](concepts/testing-stream.md)

 - [Автостоп](concepts/auto-stop.md)

 - [Resource Check](concepts/resource-check.md)

 - [Мониторинг агентов тестирования](concepts/monitoring.md)

 - [Отчеты](concepts/reports.md)

 - [Результаты нагрузочного теста](concepts/load-test-results.md)

 - [Сравнение результатов нагрузочных тестов](concepts/load-tests-compare.md)

 - [Регрессии нагрузочных тестов](concepts/load-test-regressions.md)

 - [Артефакты тестирования](concepts/artifacts.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### agent

 - [Overview](cli-ref/agent/index.md)

 - [create](cli-ref/agent/create.md)

 - [delete](cli-ref/agent/delete.md)

 - [get](cli-ref/agent/get.md)

 - [list](cli-ref/agent/list.md)

### test

 - [Overview](cli-ref/test/index.md)

 - [check-regression](cli-ref/test/check-regression.md)

 - [create](cli-ref/test/create.md)

 - [delete](cli-ref/test/delete.md)

 - [get](cli-ref/test/get.md)

 - [get-report-table](cli-ref/test/get-report-table.md)

 - [list](cli-ref/test/list.md)

 - [stop](cli-ref/test/stop.md)

 - [wait](cli-ref/test/wait.md)

### test-config

 - [Overview](cli-ref/test-config/index.md)

 - [create](cli-ref/test-config/create.md)

 - [get](cli-ref/test-config/get.md)

 - [list](cli-ref/test-config/list.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### agent

 - [Overview](cli-ref/v0/agent/index.md)

 - [create](cli-ref/v0/agent/create.md)

 - [delete](cli-ref/v0/agent/delete.md)

 - [get](cli-ref/v0/agent/get.md)

 - [list](cli-ref/v0/agent/list.md)

#### test

 - [Overview](cli-ref/v0/test/index.md)

 - [check-regression](cli-ref/v0/test/check-regression.md)

 - [create](cli-ref/v0/test/create.md)

 - [delete](cli-ref/v0/test/delete.md)

 - [get](cli-ref/v0/test/get.md)

 - [get-report-table](cli-ref/v0/test/get-report-table.md)

 - [list](cli-ref/v0/test/list.md)

 - [stop](cli-ref/v0/test/stop.md)

 - [wait](cli-ref/v0/test/wait.md)

#### test-config

 - [Overview](cli-ref/v0/test-config/index.md)

 - [create](cli-ref/v0/test-config/create.md)

 - [get](cli-ref/v0/test-config/get.md)

 - [list](cli-ref/v0/test-config/list.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](user/api-ref/grpc/index.md)

#### Agent

 - [Overview](user/api-ref/grpc/Agent/index.md)

 - [Create](user/api-ref/grpc/Agent/create.md)

 - [Get](user/api-ref/grpc/Agent/get.md)

 - [List](user/api-ref/grpc/Agent/list.md)

 - [Delete](user/api-ref/grpc/Agent/delete.md)

 - [Update](user/api-ref/grpc/Agent/update.md)

#### Config

 - [Overview](user/api-ref/grpc/Config/index.md)

 - [Create](user/api-ref/grpc/Config/create.md)

 - [Get](user/api-ref/grpc/Config/get.md)

 - [List](user/api-ref/grpc/Config/list.md)

 - [Delete](user/api-ref/grpc/Config/delete.md)

#### Operation

 - [Overview](user/api-ref/grpc/Operation/index.md)

 - [Get](user/api-ref/grpc/Operation/get.md)

 - [Cancel](user/api-ref/grpc/Operation/cancel.md)

#### RegressionDashboard

 - [Overview](user/api-ref/grpc/RegressionDashboard/index.md)

 - [Create](user/api-ref/grpc/RegressionDashboard/create.md)

 - [Get](user/api-ref/grpc/RegressionDashboard/get.md)

 - [List](user/api-ref/grpc/RegressionDashboard/list.md)

 - [Delete](user/api-ref/grpc/RegressionDashboard/delete.md)

 - [Update](user/api-ref/grpc/RegressionDashboard/update.md)

#### Report

 - [Overview](user/api-ref/grpc/Report/index.md)

 - [GetTable](user/api-ref/grpc/Report/getTable.md)

 - [CalculateKpiValues](user/api-ref/grpc/Report/calculateKpiValues.md)

#### Test

 - [Overview](user/api-ref/grpc/Test/index.md)

 - [Create](user/api-ref/grpc/Test/create.md)

 - [Get](user/api-ref/grpc/Test/get.md)

 - [Stop](user/api-ref/grpc/Test/stop.md)

 - [Delete](user/api-ref/grpc/Test/delete.md)

 - [List](user/api-ref/grpc/Test/list.md)

#### Load Testing API

 - [Overview](agent/user/api-ref/grpc/index.md)

##### Operation

 - [Overview](agent/user/api-ref/grpc/Operation/index.md)

 - [Get](agent/user/api-ref/grpc/Operation/get.md)

 - [Cancel](agent/user/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](user/api-ref/index.md)

#### Agent

 - [Overview](user/api-ref/Agent/index.md)

 - [Create](user/api-ref/Agent/create.md)

 - [Get](user/api-ref/Agent/get.md)

 - [List](user/api-ref/Agent/list.md)

 - [Delete](user/api-ref/Agent/delete.md)

 - [Update](user/api-ref/Agent/update.md)

#### Config

 - [Overview](user/api-ref/Config/index.md)

 - [Create](user/api-ref/Config/create.md)

 - [Get](user/api-ref/Config/get.md)

 - [List](user/api-ref/Config/list.md)

 - [Delete](user/api-ref/Config/delete.md)

#### Operation

 - [Overview](user/api-ref/Operation/index.md)

 - [Get](user/api-ref/Operation/get.md)

 - [Cancel](user/api-ref/Operation/cancel.md)

#### RegressionDashboard

 - [Overview](user/api-ref/RegressionDashboard/index.md)

 - [Create](user/api-ref/RegressionDashboard/create.md)

 - [Get](user/api-ref/RegressionDashboard/get.md)

 - [List](user/api-ref/RegressionDashboard/list.md)

 - [Delete](user/api-ref/RegressionDashboard/delete.md)

 - [Update](user/api-ref/RegressionDashboard/update.md)

#### Report

 - [Overview](user/api-ref/Report/index.md)

 - [GetTable](user/api-ref/Report/getTable.md)

 - [CalculateKpiValues](user/api-ref/Report/calculateKpiValues.md)

#### Test

 - [Overview](user/api-ref/Test/index.md)

 - [Create](user/api-ref/Test/create.md)

 - [Get](user/api-ref/Test/get.md)

 - [Stop](user/api-ref/Test/stop.md)

 - [Delete](user/api-ref/Test/delete.md)

 - [List](user/api-ref/Test/list.md)

#### Load Testing API

 - [Overview](agent/user/api-ref/index.md)

##### Operation

 - [Overview](agent/user/api-ref/Operation/index.md)

 - [Get](agent/user/api-ref/Operation/get.md)

 - [Cancel](agent/user/api-ref/Operation/cancel.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Обучающие курсы](training.md)