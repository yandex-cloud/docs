---
title: Ошибка {{ datalens-full-name }} ERR.CK.TOO_MANY_LINES
description: На странице приведено описание ошибки {{ datalens-full-name }} Too many series on the chart.
---

# [{{ datalens-full-name }}] Too many series on the chart

`ERR.CK.TOO_MANY_LINES`

Превышено допустимое число рядов.

В {{ datalens-short-name }} есть ограничение на объем данных для отображения в чарте. Для каждого вида визуализации установлен свой [лимит](../../concepts/limits.md#datalens-chart-data-limits) на количество рядов.

Чтобы исправить ошибку, уменьшите объем данных для отображения, например:

* добавьте [фильтры](../../dataset/settings.md#default-filters);
* используйте [агрегатные функции](../../../datalens/function-ref/aggregation-functions.md);
* включите [пагинацию](../../concepts/chart/settings.md#common-settings), если выбранная визуализация ее поддерживает.