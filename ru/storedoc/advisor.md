---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mmg-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mmg-name }}.
---

# Инспекции и рекомендации в {{ mmg-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mmg-name }} требуется роль [{{ roles.mmg.editor }} или выше](../storedoc/security/index.md).

## Доступные инспекции в {{ mmg-name }} {#mmg-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#storedoc_cpu_idle) | Высокая         |
| Высокая доступность | Наличие реплик в шарде                       | [Риск потери данных и недоступности кластера при отказе зоны (отсутствие реплик)](#storedoc_ha_replics) | Низкая          |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#storedoc_ha_geos) | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#storedoc_disk_free_space) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#storedoc_oom) | Высокая         |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#storedoc_deprecated_version) | Высокая         |
| Высокая доступность | Лаг репликации | [Риск потери данных](#storedoc_replication_lag) | Умеренная       |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#storedoc_disk_autoscaling_limit) | Умеренная       |

{% include [storedoc-cpu-idle](../_advisor/storedoc/storedoc-cpu-idle.md) %}

{% include [storedoc-ha-replics](../_advisor/storedoc/storedoc-ha-replics.md) %}

{% include [storedoc-ha-geos](../_advisor/storedoc/storedoc-ha-geos.md) %}

{% include [storedoc-disk-free-space](../_advisor/storedoc/storedoc-disk-free-space.md) %} 

{% include [storedoc-oom](../_advisor/storedoc/storedoc-oom.md) %}

{% include [storedoc-deprecated-version](../_advisor/storedoc/storedoc-deprecated-version.md) %}

{% include [storedoc-replication-lag](../_advisor/storedoc/storedoc-replication-lag.md) %}

{% include [storedoc-disk-autoscaling-limit](../_advisor/storedoc/storedoc-disk-autoscaling-limit.md) %}
