---
title: История изменений в {{ mspqr-full-name }}
description: В разделе представлена история изменений сервиса {{ mspqr-name }}.
---

# История изменений в {{ mspqr-full-name }}

## Октябрь 2026 {#october-2026}

Добавлены практические рекомендации по [восстановлению кластеров при отказе зоны доступности](../architecture/mdb-recovery.md).

## Сентябрь 2026 {#september-2026}

Добавлена возможность задавать предпочтительное время начала [технического обслуживания](concepts/maintenance.md#maintenance-window) кластера.

## Август 2026 {#august-2026}

Добавлены автоматические инспекции кластера: сервис регулярно проверяет кластер, выявляет риски для его доступности и производительности и выдает рекомендации по их устранению. Подробнее в разделе [{#T}](advisor.md).

## Июнь 2026 {#jun-2026}

Сервис {{ mspqr-full-name }} перешел на стадию [General Availability](../overview/concepts/launch-stages.md).

## Январь 2026 {#jan-2026}

* Сервис {{ mspqr-full-name }} вышел в [Public Preview](../overview/concepts/launch-stages.md).
* Поддержаны интерфейсы [{{ TF }}](tf-ref.md) и [YC CLI](../cli/cli-ref/managed-sharded-postgresql/cli-ref/index.md).

## Ноябрь 2025 {#nov-2025}

* Добавлена возможность задавать настройки СУБД при создании и изменении кластера.
* Добавлена роль `managed-spqr.restorer`, позволяющая восстанавливать кластеры из резервных копий. Узнайте больше в разделе [Управление доступом](security.md#managed-spqr-restorer).

## Июль 2025 {#jul-2025}

Сервис {{ mspqr-full-name }} вышел в Technical Preview.
