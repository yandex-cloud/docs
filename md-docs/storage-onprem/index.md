# On-premises Yandex Object Storage

Продукт On-premises Yandex Object Storage — это универсальное масштабируемое решение для хранения данных. Оно подходит как для высоконагруженных продуктов, которым требуется надежный и быстрый доступ к данным, так и для проектов с невысокими требованиями к инфраструктуре хранения.

В терминах Object Storage файлы и папки — это объекты. Все объекты размещаются в бакетах. Структура хранения объектов в бакете плоская, но инструменты с графическим интерфейсом предлагают работать с Object Storage как с иерархической файловой системой.

Используя Object Storage, вы можете:  <ul><li>Хранить данные произвольного формата как объекты с доступом по текстовому идентификатору.</li> <li>Использовать различные классы хранилища для объектов и управлять их жизненным циклом.</li> <li>Хранить большие объекты размером в несколько терабайт.</li> <li>Опубликовать статический сайт.</li></ul>

HTTP API продукта совместим с API AWS S3, то есть для работы с Object Storage вы можете использовать множество инструментов, созданных для работы с объектными хранилищами S3.

Документация версионируется и соответствует конкретной версии On-premises Yandex Object Storage.

# On-premises Yandex Object Storage

## Версия 1.0

### Концепции

 - [О продукте](v-1-0/index.md)

 - [Термины и сокращения](v-1-0/concepts/glossary.md)

#### Архитектура продукта

 - [Обзор](v-1-0/concepts/architecture/index.md)

 - [Схема решения](v-1-0/concepts/architecture/solution-scheme.md)

 - [Elliptics](v-1-0/concepts/architecture/elliptics.md)

 - [Mastermind](v-1-0/concepts/architecture/mastermind.md)

 - [Goose](v-1-0/concepts/architecture/goose.md)

 - [Работа Goose с PostgreSQL](v-1-0/concepts/architecture/goose-postgresql.md)

 - [Топология Goose и Elliptics](v-1-0/concepts/architecture/goose-elliptics.md)

 - [Кластеры PostgreSQL](v-1-0/concepts/architecture/postgresql.md)

 - [Observability](v-1-0/concepts/architecture/observability.md)

 - [Сводка характеристик системы](v-1-0/concepts/architecture/system-characteristics.md)

 - [Требования к системе](v-1-0/concepts/architecture/system-requirements.md)

 - [Требования к кластеру Kubernetes](v-1-0/concepts/architecture/kubernetes.md)

 - [Схемы подключения](v-1-0/concepts/architecture/connection-schemes.md)

 - [Описание доменов отказа](v-1-0/concepts/architecture/desc-failure-domains.md)

 - [Размещение в датацентрах с L2-балансировщиком](v-1-0/concepts/architecture/data-center-placement-l2.md)

 - [Избыточность данных](v-1-0/concepts/data-redundancy.md)

 - [Ограничения и лимиты](v-1-0/concepts/limits.md)

### Установка и настройка

 - [Общее описание процесса установки](v-1-0/install/index.md)

 - [Подготовка окружения](v-1-0/install/environment-preparation.md)

 - [Настройка параметров инсталляции](v-1-0/install/setup-install-params.md)

 - [Шаги установки](v-1-0/install/installation-steps.md)

 - [После установки](v-1-0/install/getting-started.md)

 - [Управление продуктом](v-1-0/quickstart.md)

### Сценарии обслуживания

 - [Обзор](v-1-0/operations/index.md)

 - [Установка обновлений](v-1-0/operations/installing-updates.md)

 - [Расширение хранилища](v-1-0/operations/storage-expansion.md)

 - [Замена дисков](v-1-0/operations/replacing-disks.md)

 - [Перенос базы данных](v-1-0/operations/database-migration.md)

 - [Пересоздание базы данных](v-1-0/operations/database-recreation.md)

 - [Управление квотами rate-лимитера](v-1-0/operations/manage-quotas-rate-limiter.md)

 - [Обновление сертификатов](v-1-0/operations/update-certificates.md)

### Поиск и устранение неисправностей

 - [Устранение неисправностей при установке](v-1-0/troubleshooting/installation-errors.md)

 - [Алгоритмы решения проблем](v-1-0/troubleshooting/problem-solving-algorithms.md)

 - [Типовые проблемы и их устранение](v-1-0/troubleshooting/known-issues.md)

 - [Коды ошибок](v-1-0/troubleshooting/error-codes.md)

 - [Мониторинг](v-1-0/monitoring/index.md)

### Справочник CLI (англ.)

 - [Overview](cli-ref/cli.md)

#### access-keys

 - [Overview](cli-ref/cli_access-keys.md)

 - [create](cli-ref/cli_access-keys_create.md)

 - [delete](cli-ref/cli_access-keys_delete.md)

 - [list](cli-ref/cli_access-keys_list.md)

#### buckets

 - [Overview](cli-ref/cli_buckets.md)

 - [create](cli-ref/cli_buckets_create.md)

 - [delete](cli-ref/cli_buckets_delete.md)

##### get

 - [Overview](cli-ref/cli_buckets_get.md)

 - [acl](cli-ref/cli_buckets_get_acl.md)

 - [cors](cli-ref/cli_buckets_get_cors.md)

 - [lifecycle](cli-ref/cli_buckets_get_lifecycle.md)

 - [max_size](cli-ref/cli_buckets_get_max_size.md)

 - [object_lock](cli-ref/cli_buckets_get_object_lock.md)

 - [policy](cli-ref/cli_buckets_get_policy.md)

 - [settings](cli-ref/cli_buckets_get_settings.md)

 - [storage_class](cli-ref/cli_buckets_get_storage_class.md)

 - [tags](cli-ref/cli_buckets_get_tags.md)

 - [versioning](cli-ref/cli_buckets_get_versioning.md)

 - [list](cli-ref/cli_buckets_list.md)

##### update

 - [Overview](cli-ref/cli_buckets_update.md)

 - [acl](cli-ref/cli_buckets_update_acl.md)

 - [cors](cli-ref/cli_buckets_update_cors.md)

 - [lifecycle](cli-ref/cli_buckets_update_lifecycle.md)

 - [max_size](cli-ref/cli_buckets_update_max_size.md)

 - [object_lock](cli-ref/cli_buckets_update_object_lock.md)

 - [policy](cli-ref/cli_buckets_update_policy.md)

 - [storage_class](cli-ref/cli_buckets_update_storage_class.md)

 - [tags](cli-ref/cli_buckets_update_tags.md)

 - [versioning](cli-ref/cli_buckets_update_versioning.md)

#### completion

 - [Overview](cli-ref/cli_completion.md)

 - [bash](cli-ref/cli_completion_bash.md)

 - [fish](cli-ref/cli_completion_fish.md)

 - [powershell](cli-ref/cli_completion_powershell.md)

 - [zsh](cli-ref/cli_completion_zsh.md)

#### config

 - [Overview](cli-ref/cli_config.md)

 - [init](cli-ref/cli_config_init.md)

 - [profile](cli-ref/cli_config_profile.md)

 - [show](cli-ref/cli_config_show.md)

 - [help](cli-ref/cli_help.md)

#### login

 - [Overview](cli-ref/cli_login.md)

 - [renew](cli-ref/cli_login_renew.md)

#### service-accounts

 - [Overview](cli-ref/cli_service-accounts.md)

 - [create](cli-ref/cli_service-accounts_create.md)

 - [delete](cli-ref/cli_service-accounts_delete.md)

 - [get](cli-ref/cli_service-accounts_get.md)

 - [list](cli-ref/cli_service-accounts_list.md)

 - [update](cli-ref/cli_service-accounts_update.md)

 - [update-role](cli-ref/cli_service-accounts_update-role.md)

#### settings

 - [Overview](cli-ref/cli_settings.md)

 - [login](cli-ref/cli_settings_login.md)

#### tenants

 - [Overview](cli-ref/cli_tenants.md)

 - [activate](cli-ref/cli_tenants_activate.md)

 - [create](cli-ref/cli_tenants_create.md)

 - [delete](cli-ref/cli_tenants_delete.md)

 - [get](cli-ref/cli_tenants_get.md)

 - [list](cli-ref/cli_tenants_list.md)

##### members

 - [Overview](cli-ref/cli_tenants_members.md)

 - [change](cli-ref/cli_tenants_members_change.md)

 - [list](cli-ref/cli_tenants_members_list.md)

 - [update](cli-ref/cli_tenants_update.md)

#### users

 - [Overview](cli-ref/cli_users.md)

 - [add](cli-ref/cli_users_add.md)

 - [get](cli-ref/cli_users_get.md)

 - [list](cli-ref/cli_users_list.md)

 - [lock](cli-ref/cli_users_lock.md)

 - [unlock](cli-ref/cli_users_unlock.md)

 - [whoami](cli-ref/cli_users_whoami.md)

### Справочник API

 - [Руководство по использованию gRPC API](v-1-0/api-ref/index.md)

 - [gRPC (англ.)](v-1-0/api-ref/grpc-api-ref.md)