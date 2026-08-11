---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mmy-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mmy-name }}.
---

# Инспекции и рекомендации в {{ mmy-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mmy-name }} требуется роль [{{ roles.mmy.editor }} или выше](../managed-mysql/security/index.md).

## Доступные инспекции в {{ mmy-name }} {#mmy-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-------------------------------------------------------|----------------------------------------------------------------------------------------------------|-----------------|
| Производительность  | Загрузка CPU                                          | [Риск падения производительности](#mysql_cpu_idle)                                                 | Высокая         |
| Высокая доступность | Наличие синхронных реплик в кластере | [Риск потери данных и недоступности кластера при отказе зоны (реплики)](#mysql_ha_replics) | Высокая         |
| Высокая доступность | Выделение памяти                                      | [Нехватка оперативной памяти](#mysql_oom)                                                          | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#mysql_disk_free_space) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#mysql_ha_zone) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны (кворум) | [Риск потери данных и недоступности кластера при отказе зоны (кворум)](#mysql_ha_quorum) | Высокая         |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#mysql_disk_autoscaling_limit) | Умеренная      |

{% include [mysql-cpu-idle](../_advisor/managed-mysql/mysql-cpu-idle.md) %}

{% include [mysql-ha-replics](../_advisor/managed-mysql/mysql-ha-replics.md) %} 

{% include [mysql-oom](../_advisor/managed-mysql/mysql-oom.md) %}

{% include [mysql-disk-free-space](../_advisor/managed-mysql/mysql-disk-free-space.md) %} 

{% include [mysql-ha-zone](../_advisor/managed-mysql/mysql-ha-zone.md) %}

{% include [mysql-ha-quorum](../_advisor/managed-mysql/mysql-ha-quorum.md) %}

{% include [mysql-disk-autoscaling-limit](../_advisor/managed-mysql/mysql-disk-autoscaling-limit.md) %} 







