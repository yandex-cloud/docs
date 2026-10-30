---
title: Квоты и лимиты в {{ compute-full-name }}
description: В сервисе {{ compute-name }} действуют лимиты и квоты на виртуальные машины, HDD и SSD диски. Более подробно об ограничениях в сервисе вы узнаете из данной статьи.
editable: false
---

# Квоты и лимиты в {{ compute-name }}


{% note warning %}

Девять квот на ресурсы {{ compute-name }} действуют не в рамках региона, а отдельно по каждой зоне доступности.

{% endnote %}


{% include [reserved-pools-preview-notice](../../_includes/compute/reserved-pools-preview-notice.md) %}

В сервисе {{ compute-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}


В {{ compute-name }} действуют *региональные* и *зональные* квоты. Региональная квота ограничивает использование ресурсов одного облака во всем [регионе](../../overview/concepts/region.md). Зональная квота ограничивает использование ресурсов одного облака отдельно в каждой [зоне доступности](../../overview/concepts/geo-scope.md).


{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [compute-limits.md](../../_includes/compute-limits.md) %}
