---
title: История изменений в {{ compute-full-name }}
description: В разделе представлена история изменений сервиса {{ compute-name }}.
---

# История изменений в {{ compute-full-name }}

## III–IV квартал 2025 {#q3-q4-2025}

* Доступны новые [платформы](./concepts/vm-platforms.md) виртуальных машин:
  * AMD Zen 4 (`standard-v4a`);
  * AMD Zen 4 Compute-Optimized (`highfreq-v4a`);
  * GPU PLATFORM V4 (`gpu-standard-v4`) с поддержкой работы в [кластере GPU](./concepts/gpus.md#gpu-clusters).
* Реализованы новые [поколения оборудования](./concepts/hardware-generations.md) ВМ на топологии `PCI_TOPOLOGY_V2` с увеличенными лимитами на число дисков и сетевых интерфейсов:
  * `Gen 1.2` (загрузчик — [BIOS](https://ru.wikipedia.org/wiki/BIOS));
  * `Gen 2` (загрузчик — [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface)).
* Изменена логика работы [групп ВМ при зональном инциденте](./concepts/instance-groups/zonal-inc/overview.md#multi-zone-in) для уменьшения последствий инцидента и повышения управляемости.
* Добавлена возможность [временного отключения зон доступности для групп ВМ](./concepts/instance-groups/disable-enable-zone.md).
* Обновлена логика работы [пулов резервов ВМ](./concepts/reserved-pools.md), управление пулами теперь также доступно в [консоли управления]({{ link-console-main }}/link/compute).
* Поддержана функциональность [генерации SSH-ключей](./operations/vm-connect/ssh.md#creating-ssh-keys) в [консоли управления]({{ link-console-main }}/link/compute).
* Реализована группа команд [yc compute maintenance](./cli-ref/maintenance/index.md) в {{ yandex-cloud }} CLI для управления обслуживанием ВМ.
* Добавлены [события {{ at-name }} уровня конфигурации](./at-ref.md#control-plane-events):
  * `instancegroup.DisableZones` — временное отключение зон доступности;
  * `instancegroup.EnableZones` — включение зон доступности.
* Поддержаны новые [метрики {{ monitoring-name }}](./metrics.md#fs-metrics):
  * `filestore.index_cumulative_time` — совокупное время выполнения операций индексации в файловом хранилище;
  * `filestore.index_latency` — задержка выполнения операций индексации в файловом хранилище. 
* Обновлен механизм удаления группы ВМ — теперь нельзя приостановить процессы в удаляемой группе. Также нельзя запускать любые операции для групп с приостановленными процессами.
* Убрана простая форма создания ВМ в [консоли управления]({{ link-console-main }}/link/compute).

## II квартал 2025 {#q2-2025}

* Запущена функциональность [пулов резервов виртуальных машин](./concepts/reserved-pools.md) на [стадии Preview](../overview/concepts/launch-stages.md). Доступ предоставляется по запросу.
* Реализована простая форма создания ВМ в [консоли управления]({{ link-console-main }}).
* Добавлена передача в {{ at-full-name }} [события уровня сервисов](./at-ref.md#data-plane-events) `MigrateInstance` при [динамической миграции](./concepts/live-migration.md) ВМ с настроенной [политикой обслуживания](./concepts/maintenance-policies.md).

## I квартал 2025 {#q1-2025}

* Запущена [платформа](./concepts/vm-platforms.md) AMD Zen 3 (`amd-v1`) на [стадии Preview](../overview/concepts/launch-stages.md). Доступ предоставляется по запросу.
* Улучшены средства мониторинга и логирования (observability), и повышена надежность высокоскоростной защищенной сети Infiniband в [кластерах GPU](./concepts/gpus.md#gpu-clusters).
* Добавлена [конфигурация виртуальных машин](./concepts/gpus.md#config) с одним GPU для платформы `gpu-standard-v3i`.

## IV квартал 2024 {#q4-2024}

* Функциональность [шифрования дисков](./concepts/encryption.md) перешла в стадию [General Availability](../overview/concepts/launch-stages.md).
* Добавлена [конфигурация виртуальных машин](./concepts/gpus.md#config) с двумя и четырьмя GPU для платформы `gpu-standard-v3i`.
* Поддержана возможность объединять ВМ на платформе `gpu-standard-v3i` в [кластер GPU](./concepts/gpus.md#gpu-clusters).
* Платформа `gpu-standard-v3-t4i` стала доступна в [регионе](../overview/concepts/region.md) Казахстан.

## III квартал 2024 {#q3-2024}

* Реализована новая PCI-топология. Создать ВМ с новой топологией можно командой `yc instance create` с параметрами `--hardware-generation-id=generation2` и `--hardware-features pci_topology=v2`.
* QEMU обновлен до версии 7.

## II квартал 2024 {#q2-2024}

* Увеличены [лимиты](concepts/limits.md) сетевых соединений.

## I квартал 2024 {#q1-2024}

* Появилась возможность добавлять и удалять сетевые интерфейсы без пересоздания ВМ.
* Добавлена поддержка формата виртуального диска VHD.
* Исправлена ошибка в {{ TF }}-провайдере, которая возникала при создании ВМ с несколькими дисками через мета-аргумент `Count`.
* В документацию провайдера добавлено [описание ресурсов gpus]({{ tf-provider-resources-link }}/compute_instance).