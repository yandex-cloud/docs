---
title: Скорость копирования данных в {{ data-transfer-full-name }}
description: При копировании скорость может достигать 15 МБ/с
alternate:
  - href: ru/data-transfer/concepts/copy-speed.md
    type: text/markdown
    title: Markdown version
---

# Скорость копирования

При копировании скорость может достигать 15 МБ/с. База размером 100 ГБ обычно копируется за 2–3 часа. Точное время зависит от:

* настроек приемника и источника;
* количества [воркеров и потоков](../operations/transfer.md#update-copy-repl);
* возможностей [параллельного копирования](sharded.md) источника;
* стабильности соединения.

При репликации {{ PG }} и {{ MY }} пропускная способность может достигать 20–30 тысяч пишущих транзакций в секунду.

{% include [speed-degrade](../../_includes/data-transfer/speed-degrade.md) %}