---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mpg-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mpg-name }}.
---

# Инспекции и рекомендации в {{ mpg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mpg-name }} требуется роль [{{ roles.mpg.editor }} или выше](../managed-postgresql/security/index.md).

## Доступные инспекции {{ mpg-name }} {#mpg-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#postgresql_cpu_idle) | Высокая         |
| Высокая доступность | Наличие синхронных реплик в кластере                  | [Риск потери данных и недоступности кластера при отказе зоны (реплики)](#postgresql_ha_replics) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#postgresql_oom) | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#postgresql_disk_free_space) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны доступности](#postgresql_ha_zone) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны (кворум) | [Риск потери данных и недоступности кластера при отказе зоны (кворум)](#postgresql_ha_quorum) | Высокая         |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#postgresql_disk_autoscaling_limit) | Умеренная       |

{% include [postgresql-cpu-idle](../_advisor/managed-postgresql/postgresql-cpu-idle.md) %}

{% include [postgresql-ha-replics](../_advisor/managed-postgresql/postgresql-ha-replics.md) %}

{% include [postgresql-oom](../_advisor/managed-postgresql/postgresql-oom.md) %}

{% include [postgresql-disk-free-space](../_advisor/managed-postgresql/postgresql-disk-free-space.md) %}

{% include [postgresql-ha-zone](../_advisor/managed-postgresql/postgresql-ha-zone.md) %}

{% include [postgresql-ha-quorum](../_advisor/managed-postgresql/postgresql-ha-quorum.md) %}

{% include [postgresql-disk-autoscaling-limit](../_advisor/managed-postgresql/postgresql-disk-autoscaling-limit.md) %}
