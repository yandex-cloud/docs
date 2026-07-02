[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Received too many result data rows

# [Yandex DataLens] Received too many result data rows

`ERR.DS_API.ROW_COUNT_LIMIT`

Превышено допустимое количество строк.

В DataLens есть ограничение на объем данных для отображения в чарте. Для каждого типа визуализации установлен свой [лимит](../../concepts/limits.md) на количество рядов.

Чтобы исправить ошибку, уменьшите объем запрошенных данных с помощью фильтров.