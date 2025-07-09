---
title: История изменений в {{ backup-full-name }}
description: В разделе представлена история изменений сервиса {{ backup-name }}.
---

# История изменений в {{ backup-full-name }}

## II квартал 2025 {#q2-2025}

* Реализовано автоматическое подключение серверов {{ baremetal-full-name }} к {{ backup-name }} при заказе в [консоли управления]({{ link-console-main }}).
* Добавлены новые настройки для [политик резервного копирования](./concepts/policy.md):
  * создание моментальных снимков [LVM](./concepts/backup.md#lvm);
  * посекторное резервное копирование;
  * запуск пропущенных заданий после загрузки ВМ или сервера {{ baremetal-full-name }};
  * проверка резервных копий.
* Прекращена поддержка параметров `preserveFileSecuritySettings` и `quiesceSnapshottingEnabled` политик резервного копирования.
* Поддержана операционная система CentOS 7 для серверов {{ baremetal-full-name }}.

## I квартал 2025 {#q1-2025}

В [{{ yandex-cloud }} CLI](../cli/quickstart.md) добавлена возможность [удаления](./operations/backup-vm/batch-delete.md) всех резервных копий конкретной ВМ или сервера {{ baremetal-full-name }}.

## IV квартал 2024 {#q4-2024}

* Добавлена поддержка новых операционных систем:
    * для виртуальных машин {{ compute-full-name }}:
      * [Debian 12](/marketplace/products/yc/debian-12);
      * [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin).
    * для серверов {{ baremetal-full-name }}:
      * Debian 10;
      * Debian 11;
      * Ubuntu 24.04 LTS.
* Поддержано управление резервным копированием серверов {{ baremetal-name }} в [консоли управления]({{ link-console-main }}).
* Добавлены новые возможности [{{ yandex-cloud }} CLI](../cli/quickstart.md):
  * [просмотр](./operations/backup-vm/view-disk-layout.md) параметров дисков и разделов в резервной копии;
  * [активация](./operations/activate-service.md) сервиса;
  * [подключение](./operations/connect-vm-oslogin-linux.md) и [переподключение](./operations/refresh-connection-oslogin-linux.md) к сервису ВМ с OS Login.

## III квартал 2024 {#q3-2024}

* Добавлена возможность задать существующую политику резервного копирования при [создании ВМ с подключением к {{ backup-name }}](./operations/create-vm.md) в консоли управления, CLI, {{ TF }} и API.
* Поддержан новый источник данных в {{ TF }} [yandex_backup_policy]({{ tf-provider-datasources-link }}/backup_policy) — для получения информации о политике резервного копирования.
* Добавлен новый ресурс в {{ TF }} [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings) — для привязки ВМ к политикам резервного копирования.
* Реализована отправка [метрик сервиса](metrics.md) в {{ monitoring-full-name }}.
* Добавлена возможность [создавать](./operations/backup-vm/create.md) резервные копии ВМ вне расписания политики резервного копирования с помощью CLI.
* Поддержана возможность [резервного копирования серверов {{ baremetal-full-name }}](./tutorials/backup-baremetal.md).

## II квартал 2024 {#q2-2024}

* Обновлен [агент {{ backup-name }}](concepts/agent.md).
* Добавлена поддержка новых операционных систем:
  * [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
  * [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
  * [CentOS Stream](/marketplace/products/yc/centos-stream-8)
* Добавлена поддержка образов с {{ oslogin }}:
  * [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
  * [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
  * [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* Добавлены метод REST API [listTasks](./backup/api-ref/Resource/listTasks.md) для ресурса [Resource](./backup/api-ref/Resource/index.md) и вызов gRPC API [ResourceService/ListTasks](backup/api-ref/grpc/Resource/listTasks.md). С их помощью вы можете просматривать действия по резервному копированию подключенных ВМ.
* В методах REST API для ресурса [Resource](./backup/api-ref/Resource/index.md) и в вызовах gRPC API [ResourceService](backup/api-ref/grpc/Resource/index.md) добавлены параметры:
  * `initStatus` — статус инициализации ВМ в {{ backup-name }};
  * `metadata` — метаданные для получения подробной информации о процессе регистрации ВМ в {{ backup-name }}.
* [Аудитные логи](at-ref.md) сервиса дополнены событиями:
  * `InitResource` — инициализация подключения ВМ к {{ backup-name }};
  * `UpdateResource` — обновление статуса подключения ВМ к {{ backup-name }}.

## I квартал 2024 {#q1-2024}

* В консоли управления на вкладке ![list-check](../_assets/console-icons/list-check.svg) **Операции** часть заведомо долгих действий переведена в асинхронные операции, для некоторых действий добавлено отображение процента выполнения.
* Обновлена механика применения изменений для правил [хранения резервных копий](./concepts/policy.md#retention). Теперь по умолчанию новые правила вступают в силу после создания очередной резервной копии.
* Добавлена поддержка создания политики с пользовательской схемой расписания резервного копирования `scheduling.scheme=CUSTOM`. Подробнее см. [Спецификация политики резервного копирования](./concepts/policy.md#specification).