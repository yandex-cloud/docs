[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Too many series on the chart

# [Yandex DataLens] Too many series on the chart

`ERR.CK.TOO_MANY_LINES`

Превышено допустимое число рядов.

В DataLens есть ограничение на объем данных для отображения в чарте. Для каждого вида визуализации установлен свой [лимит](../../concepts/limits.md#datalens-chart-data-limits) на количество рядов.

Чтобы исправить ошибку, уменьшите объем данных для отображения, например:

* добавьте [фильтры](../../dataset/settings.md#default-filters);
* используйте [агрегатные функции](../../function-ref/aggregation-functions.md);
* включите [пагинацию](../../concepts/chart/settings.md#common-settings), если выбранная визуализация ее поддерживает.