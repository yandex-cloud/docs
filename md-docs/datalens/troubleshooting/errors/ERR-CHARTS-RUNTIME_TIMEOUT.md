[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Response processing timeout

# [Yandex DataLens] Response processing timeout

`ERR.CHARTS.RUNTIME_TIMEOUT`

Превышено время обработки ответа.

Ошибка возникает из-за того, что DataLens не успевает обработать и отрисовать в чарте поступающие данные.

Чтобы исправить ошибку, уменьшите объем данных в запросе, например, используйте фильтры. Учитывайте [лимиты](../../concepts/limits.md) для количества рядов в датасете.