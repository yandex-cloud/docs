---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mch-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mch-name }}.
---

# Инспекции и рекомендации в {{ mch-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mch-name }} требуется роль [{{ roles.mch.editor }} или выше](../managed-clickhouse/security.md).

## Доступные инспекции в {{ mch-name }} {#mch-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------|-----------------|
| Производительность  | Загрузка CPU                                       | [Высокая загрузка CPU на хосте](#clickhouse_cpu_idle)                                               | Высокая         |
| Высокая доступность | Выделение дискового пространства | [Нехватка места на диске](#clickhouse_disk_free_space) | Высокая       |
| Высокая доступность | Размещение сервиса координации на отдельных хостах | [Риск недоступности из-за размещения сервиса координации на хостах](#clickhouse_ha_embedded_keeper) | Высокая         |
| Высокая доступность | Высокая доступность шарда | [Риск потери данных и недоступности кластера при отказе зоны доступности](#clickhouse_ha_shard) | Высокая         |
| Высокая доступность | Кворум сервиса координации при отказе зоны | [Риск потери кворума сервиса координации при отказе зоны](#clickhouse_ha_keeper) | Высокая          |


{% include [clickhouse-cpu-idle](../_advisor/managed-clickhouse/clickhouse-cpu-idle.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-disk-free-space.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-embedded-keeper.md) %} 

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-shards.md) %}

{% include [disk-free-space](../_advisor/managed-clickhouse/clickhouse-ha-keeper.md) %}
