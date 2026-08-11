---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mos-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mos-name }}.
---

# Инспекции и рекомендации в {{ mos-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mos-name }} требуется роль [{{ roles.mos.editor }} или выше](../managed-opensearch/security/index.md).

## Доступные инспекции в {{ mos-name }} {#mos-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-----------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#opensearch_cpu_idle) | Высокая         |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#opensearch_deprecated_version) | Высокая         |
| Высокая доступность | Возможность автомасштабирования | [Автомасштабирование дискового пространства не настроено](#opensearch_disk_autoscaling) | Низкая          |
| Высокая доступность | Возможность автомасштабирования (ограничения) | [Ограничена возможность автомасштабирования дискового пространства](#opensearch-disk-autoscaling-limit) | Умеренная       |
| Высокая доступность | Выделение дискового пространства | [Риск недоступности кластера](#opensearch_disk_free_space) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#opensearch_oom) | Высокая         |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#opensearch_high_availability) | Высокая         |

{% include [opensearch-cpu-idle](../_advisor/managed-opensearch/opensearch-cpu-idle.md) %}

{% include [opensearch-deprecated-version](../_advisor/managed-opensearch/opensearch-deprecated-version.md) %}

{% include [opensearch-disk-autoscaling](../_advisor/managed-opensearch/opensearch-disk-autoscaling.md) %} 

{% include [opensearch-disk-autoscaling-limit](../_advisor/managed-opensearch/opensearch-disk-autoscaling-limit.md) %}

{% include [opensearch-disk-free-space](../_advisor/managed-opensearch/opensearch-disk-free-space.md) %}

{% include [opensearch-oom](../_advisor/managed-opensearch/opensearch-oom.md) %}

{% include [opensearch-ha-zone](../_advisor/managed-opensearch/opensearch-ha-zone.md) %}



