[Документация Yandex Cloud](../index.md) > [Yandex Cloud Backup](index.md) > История изменений

# История изменений в Yandex Cloud Backup

## I квартал 2026 {#q1-2026}

* Улучшена функциональность создания виртуальной машины с подключением к Cloud Backup в [консоли управления](https://console.yandex.cloud).
* Добавлена роль [backup.auditor](security/index.md#backup-auditor).

## IV квартал 2025 {#q4-2025}

* Реализована возможность в консоли управления [создать](operations/create-vm.md) ВМ с подключением к Cloud Backup без привязки сервисного аккаунта.
* Поддержаны новые параметры [политики резервного копирования](concepts/policy.md):
  * команда до захвата данных `"prePostCommands":"type":"PRE_DATA_COMMAND"`;
  * команда после захвата данных `"prePostCommands":"type":"POST_DATA_COMMAND"`.

  Параметры аналогичны командам до и после резервного копирования, но выполнение происходит максимально близко к созданию снимка для резервной копии.
* Добавлена [квота](concepts/limits.md) на количество серверов BareMetal, подключенных к Cloud Backup, в одном облаке.

## III квартал 2025 {#q3-2025}

* В [регионе](../overview/concepts/region.md) Казахстан сервис стал доступен на стадии [General Availability](../overview/concepts/launch-stages.md).
* В команду Yandex Cloud CLI [yc backup provider activate](cli-ref/provider/activate.md) добавлен шаг с явным подтверждением [активации провайдера резервного копирования](operations/activate-service.md), а также флаг `--force` для активации без подтверждения.
* Добавлены новые настройки для [политик резервного копирования](concepts/policy.md):
    * выполнение команд до и после резервного копирования;
    * новый тип расписания запуска — интервал между завершением предыдущего копирования и началом нового.
* Добавлены новые метрики Yandex Monitoring:
    * `agent_alive` — индикатор активности [агента Cloud Backup](concepts/agent.md);
    * `agent_version_available` — индикатор доступности новой версии агента Cloud Backup;
    * `error` — ошибки резервного копирования.

## II квартал 2025 {#q2-2025}

* Реализовано автоматическое подключение серверов Yandex BareMetal к Cloud Backup при заказе в [консоли управления](https://console.yandex.cloud).
* Добавлены новые настройки для [политик резервного копирования](concepts/policy.md):
  * создание моментальных снимков [LVM](concepts/backup.md#lvm);
  * посекторное резервное копирование;
  * запуск пропущенных заданий после загрузки ВМ или сервера Yandex BareMetal;
  * проверка резервных копий.
* Прекращена поддержка параметров `preserveFileSecuritySettings` и `quiesceSnapshottingEnabled` политик резервного копирования.
* Поддержана операционная система CentOS 7 для серверов Yandex BareMetal.

## I квартал 2025 {#q1-2025}

В [Yandex Cloud CLI](../cli/quickstart.md) добавлена возможность [удаления](operations/backup-vm/batch-delete.md) всех резервных копий конкретной ВМ или сервера Yandex BareMetal.

## IV квартал 2024 {#q4-2024}

* Добавлена поддержка новых операционных систем:
    * для виртуальных машин Yandex Compute Cloud:
      * [Debian 12](https://yandex.cloud/ru/marketplace/products/yc/debian-12);
      * [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).
    * для серверов Yandex BareMetal:
      * Debian 10;
      * Debian 11;
      * Ubuntu 24.04 LTS.
* Поддержано управление резервным копированием серверов BareMetal в [консоли управления](https://console.yandex.cloud).
* Добавлены новые возможности [Yandex Cloud CLI](../cli/quickstart.md):
  * [просмотр](operations/backup-vm/view-disk-layout.md) параметров дисков и разделов в резервной копии;
  * [активация](operations/activate-service.md) сервиса;
  * [подключение](operations/connect-vm-oslogin-linux.md) и [переподключение](operations/refresh-connection-oslogin-linux.md) к сервису ВМ с OS Login.

## III квартал 2024 {#q3-2024}

* Добавлена возможность задать существующую политику резервного копирования при [создании ВМ с подключением к Cloud Backup](operations/create-vm.md) в консоли управления, CLI, Terraform и API.
* Поддержан новый источник данных в Terraform [yandex_backup_policy](../terraform/data-sources/backup_policy.md) — для получения информации о политике резервного копирования.
* Добавлен новый ресурс в Terraform [yandex_backup_policy_bindings](../terraform/resources/backup_policy_bindings.md) — для привязки ВМ к политикам резервного копирования.
* Реализована отправка [метрик сервиса](metrics.md) в Yandex Monitoring.
* Добавлена возможность [создавать](operations/backup-vm/create.md) резервные копии ВМ вне расписания политики резервного копирования с помощью CLI.
* Поддержана возможность [резервного копирования серверов Yandex BareMetal](tutorials/backup-baremetal.md).

## II квартал 2024 {#q2-2024}

* Обновлен [агент Cloud Backup](concepts/agent.md).
* Добавлена поддержка новых операционных систем:
  * [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts)
  * [Ubuntu 22.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2204-lts-oslogin)
  * [CentOS Stream](https://yandex.cloud/ru/marketplace/products/yc/centos-stream-8)
* Добавлена поддержка образов с OS Login:
  * [Ubuntu 20.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2004-lts-oslogin)
  * [Ubuntu 18.04 LTS OS Login](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-1804-lts-oslogin)
  * [CentOS 7 OS Login](https://yandex.cloud/ru/marketplace/products/yc/centos-7-oslogin)
* Добавлены метод REST API [listTasks](backup/api-ref/Resource/listTasks.md) для ресурса [Resource](backup/api-ref/Resource/index.md) и вызов gRPC API [ResourceService/ListTasks](backup/api-ref/grpc/Resource/listTasks.md). С их помощью вы можете просматривать действия по резервному копированию подключенных ВМ.
* В методах REST API для ресурса [Resource](backup/api-ref/Resource/index.md) и в вызовах gRPC API [ResourceService](backup/api-ref/grpc/Resource/index.md) добавлены параметры:
  * `initStatus` — статус инициализации ВМ в Cloud Backup;
  * `metadata` — метаданные для получения подробной информации о процессе регистрации ВМ в Cloud Backup.
* [Аудитные логи](at-ref.md) сервиса дополнены событиями:
  * `InitResource` — инициализация подключения ВМ к Cloud Backup;
  * `UpdateResource` — обновление статуса подключения ВМ к Cloud Backup.

## I квартал 2024 {#q1-2024}

* В консоли управления на вкладке ![list-check](../_assets/console-icons/list-check.svg) **Операции** часть заведомо долгих действий переведена в асинхронные операции, для некоторых действий добавлено отображение процента выполнения.
* Обновлена механика применения изменений для правил [хранения резервных копий](concepts/policy.md#retention). Теперь по умолчанию новые правила вступают в силу после создания очередной резервной копии.
* Добавлена поддержка создания политики с пользовательской схемой расписания резервного копирования `scheduling.scheme=CUSTOM`. Подробнее в разделе [Спецификация политики резервного копирования](concepts/policy.md#specification).