---
title: Рекомендации по повышению надежности, оптимизации стоимости и производительности кластера {{ mrd-name }}
description: В этом разделе вы узнаете, как работать с результатами проверок и диагностики кластера {{ mrd-name }}.
---

# Инспекции и рекомендации в {{ mrd-name }} 

{% include [advisor-description](../_advisor/concept/advisor-description.md) %}

Для управления рекомендациями в {{ mrd-name }} требуется роль [{{ roles.mrd.editor }} или выше](../managed-valkey/security/index.md).

## Доступные инспекции в {{ mrd-name }} {#mrd-recommendations}

| **Категория** | **Проверка** | **Риск** | **Критичность** |
|---------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------|
| Производительность | Загрузка CPU (main thread) | [Риск падения производительности](#valkey_main_thread) | Умеренная |
| Производительность | Частота попадания в кеш | [Низкий процент попадания в кеш](#valkey_cachehit) | Умеренная |
| Высокая доступность | Наличие реплик в шарде | [Риск потери данных и недоступности кластера при отказе зоны (отсутствие реплик)](#valkey_ha_replics) | Низкая |
| Высокая доступность | Высокая доступность кластера при отказе зоны | [Риск потери данных и недоступности кластера при отказе зоны](#valkey_ha_geos) | Высокая |
| Высокая доступность | Выделение памяти | [Нехватка оперативной памяти](#valkey_oom) | Умеренная |
| Высокая доступность | Актуальность версии базы данных | [Версия базы данных устарела](#valkey_deprecated_version) | Высокая |
| Высокая доступность | Политика потребления памяти {{ VLK }} | [Достигнут лимит по объему памяти на хосте](#valkey_maxmemory_policy) | Умеренная |
| Высокая доступность | Возможность автомасштабирования диска | [Ограничена возможность автомасштабирования дискового пространства](#valkey_disk_autoscaling_limit) | Умеренная |

{% include [valkey-main_thread](../_advisor/managed-valkey/valkey-main-thread.md) %}

{% include [valkey-valkey_cachehit](../_advisor/managed-valkey/valkey-cachehit.md) %}

{% include [valkey-ha-replics](../_advisor/managed-valkey/valkey-ha-replics.md) %}

{% include [valkey-ha-geos](../_advisor/managed-valkey/valkey-ha-geos.md) %}

{% include [valkey-oom](../_advisor/managed-valkey/valkey-oom.md) %}

{% include [valkey-deprecated-verion](../_advisor/managed-valkey/valkey-deprecated-version.md) %}

{% include [valkey-maxmemory-policy](../_advisor/managed-valkey/valkey-maxmemory-policy.md) %}

{% include [valkey-disk-autoscaling-limit](../_advisor/managed-valkey/valkey-disk-autoscaling-limit.md) %}






