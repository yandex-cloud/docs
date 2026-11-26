---
title: Вопросы и ответы про вычисляемые поля
description: На странице представлены вопросы и ответы про вычисляемые поля.
---

# Вычисляемые поля



{% include [calculate-cumulative-sum](../../_qa/datalens/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../../_qa/datalens/calculating-ifnull-zn-nan.md) %}

### Что делать, если возникает ошибка `ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE`? {#formula-translation-data-type}

Ошибка возникает, когда прямое подключение к {{ metrika }} не поддерживает функцию, используемую в вычисляемом поле. Список доступных функций приведен в разделе [{#T}](../function-ref/availability.md).

Чтобы использовать больше функций, выгрузите данные в {{ CH }} и подключите {{ datalens-name }} к созданной базе данных. Подробнее в ответе [Как работать с сырыми данными Метрики и AppMetrica?](connections.md#uploading-data-logs-api).

### Что делать, если при использовании `AGO` в индикаторе возникает ошибка `ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT`? {#ago-indicator-agg-inconsistent}

Функции `AGO` требуется измерение с датой для группировки. В чарте **Индикатор** измерений по умолчанию нет, поэтому возникает ошибка `ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT`.

Чтобы использовать `AGO` в индикаторе, оберните функцию снаружи в [LOD-выражение](../concepts/lod-aggregation.md), которое задает группировку по дате. В аргументах `AGO` LOD-выражения не поддерживаются.

Пример формулы:

```text
SUM(SUM(AGO(SUM([SALES]), [DT], 'week', 1) INCLUDE [DT]))
```

Также можно использовать линейный чарт с датой на оси X, сравнивать периоды с помощью фильтров или селекторов либо предварительно рассчитать значение за прошлый период в датасете.



