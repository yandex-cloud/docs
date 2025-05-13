---
title: История изменений в {{ compute-full-name }}
description: В разделе представлена история изменений сервиса {{ compute-name }}.
---

# История изменений в {{ compute-full-name }}

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
* В документацию провайдера добавлено [описание ресурсов gpus](https://terraform-provider.yandexcloud.net/Resources/compute_instance).