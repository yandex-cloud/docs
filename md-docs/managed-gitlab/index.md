[Документация Yandex Cloud](../index.md) > Yandex Managed Service for GitLab > Managed Service for GitLab

# Yandex Managed Service for GitLab

Сервис Managed Service for GitLab помогает разворачивать и поддерживать инстансы GitLab в инфраструктуре Yandex Cloud.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_glb/">Уровень обслуживания Yandex Managed Service for GitLab</a>.

# Yandex Managed Service for GitLab

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получение информации об инстансах](operations/instance/instance-list.md)

 - [Создание и активация инстанса](operations/instance/instance-create.md)

 - [Настройка групп безопасности](operations/configure-security-group.md)

 - [Остановка и запуск инстанса](operations/instance/instance-stop.md)

 - [Изменение настроек инстанса](operations/instance/instance-update.md)

 - [Управление резервными копиями](operations/instance/instance-backups.md)

 - [Миграция из пользовательской инсталляции GitLab](operations/instance/migration.md)

 - [Миграция в другую зону доступности](operations/instance/zone-migration.md)

 - [Очистка переполненного дискового пространства](operations/instance/clean-up-disk-space.md)

 - [Удаление инстанса](operations/instance/instance-delete.md)

 - [Создание и добавление пользователей в проект](operations/create-user.md)

 - [Настройка правил ревью кода](operations/approval-rules.md)

 - [Мониторинг состояния инстанса](operations/instance/monitoring.md)

 - [Настройка OmniAuth](operations/omniauth.md)

 - [Интеграция с Object Storage](operations/objstorage-integration.md)

 - [Работа с управляемым раннером](operations/runner.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Развертывание GitLab Runner на виртуальной машине Yandex Compute Cloud](tutorials/install-gitlab-runner.md)

 - [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](tutorials/gitlab-lockbox-integration.md)

 - [Непрерывное развертывание контейнеризованных приложений Managed Service for Kubernetes](tutorials/gitlab-containers.md)

 - [Сканирование уязвимостей Container Registry при непрерывном развертывании приложений Managed Service for Kubernetes](tutorials/cr-scanner-with-k8s-and-gitlab.md)

 - [Построение пайплайна CI/CD с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

 - [Хранение Docker-образов в Yandex Container Registry](tutorials/image-storage.md)

 - [Тестирование приложений с помощью GitLab](tutorials/application-testing-with-gitlab.md)

 - [Создание тестовых виртуальных машин через GitLab CI](tutorials/test-vms-creation-via-gitlab-ci.md)

 - [Интеграция с Яндекс Трекер](tutorials/tracker-integration.md)

 - [Интеграция с Argo CD](tutorials/argo-cd.md)

 - [Управление жизненным циклом MLOps с помощью ML Registry](tutorials/mlops-ml-registry.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Преимущества сервиса перед пользовательской инсталляцией GitLab](concepts/managed-gitlab-vs-custom-installation.md)

 - [Порядок миграции из пользовательской инсталляции GitLab](concepts/migration.md)

### Правила ревью кода

 - [Обзор](concepts/approval-rules.md)

 - [Рекомендации и примеры](concepts/approval-rules-scenarios.md)

 - [Резервные копии](concepts/backup.md)

 - [Безопасность в GitLab](concepts/security.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Интеграция с хранилищем Object Storage](concepts/s3-integration.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### instance

 - [Overview](cli-ref/instance/index.md)

 - [create](cli-ref/instance/create.md)

 - [delete](cli-ref/instance/delete.md)

 - [get](cli-ref/instance/get.md)

 - [list](cli-ref/instance/list.md)

 - [start](cli-ref/instance/start.md)

 - [stop](cli-ref/instance/stop.md)

 - [update](cli-ref/instance/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### instance

 - [Overview](cli-ref/v0/instance/index.md)

 - [create](cli-ref/v0/instance/create.md)

 - [delete](cli-ref/v0/instance/delete.md)

 - [get](cli-ref/v0/instance/get.md)

 - [list](cli-ref/v0/instance/list.md)

 - [start](cli-ref/v0/instance/start.md)

 - [stop](cli-ref/v0/instance/stop.md)

 - [update](cli-ref/v0/instance/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Instance

 - [Overview](api-ref/grpc/Instance/index.md)

 - [Get](api-ref/grpc/Instance/get.md)

 - [List](api-ref/grpc/Instance/list.md)

 - [Create](api-ref/grpc/Instance/create.md)

 - [Update](api-ref/grpc/Instance/update.md)

 - [Delete](api-ref/grpc/Instance/delete.md)

 - [Start](api-ref/grpc/Instance/start.md)

 - [Stop](api-ref/grpc/Instance/stop.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Instance

 - [Overview](api-ref/Instance/index.md)

 - [Get](api-ref/Instance/get.md)

 - [List](api-ref/Instance/list.md)

 - [Create](api-ref/Instance/create.md)

 - [Update](api-ref/Instance/update.md)

 - [Delete](api-ref/Instance/delete.md)

 - [Start](api-ref/Instance/start.md)

 - [Stop](api-ref/Instance/stop.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)