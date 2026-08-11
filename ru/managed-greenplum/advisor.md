---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mgp-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mgp-name }}.
---

# Инспекции и рекомендации в {{ mgp-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mgp-name }} требуется роль [{{ roles.mgp.editor }} или выше](../managed-greenplum/security/index.md).

## Доступные инспекции в {{ mgp-name }} {#mgp-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|-------------------------|----------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU | [Риск падения производительности](#greenplum_cpu_idle) | Высокая         |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#greenplum_oom) | Умеренная       |
| Высокая доступность | Учет памяти ZSTD | [Риск превышения лимитов памяти ресурсного менеджера](#greenplum_gp_enable_zstd_memory_accounting) | Умеренная       |

{% include [greenplum-cpu-idle](../_advisor/managed-greenplum/greenplum-cpu-idle.md) %}

{% include [greenplum-oom](../_advisor/managed-greenplum/greenplum-oom.md) %} 

{% include [greenplum-gp-enable-zstd-memory-accounting](../_advisor/managed-greenplum/greenplum-gp-enable-zstd-memory-accounting.md) %}
