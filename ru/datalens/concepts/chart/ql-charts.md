---
title: QL-чарты. Обзор
description: Из статьи вы узнаете, что такое QL-чарты и познакомитесь с их особенностями.
---

# QL-чарты. Обзор


_QL-чарты_ — чарты, созданные на основе подключения, если источник подключения — БД, {{ prometheus-name }} или {{ monitoring-short-name }}. Для построения таких чартов используется прямой запрос в источник. В зависимости от типа чарта запрос выполняется на SQL-диалекте исходной БД, языке запросов {{ prometheus-name }} или {{ monitoring-short-name }}, что позволяет расширить возможности визуализации с помощью специфических операций.


При выполнении запроса отдельный объект [Датасет](../../dataset/index.md) не создается — чарт генерируется сразу и отображается на панели превью.

В отличие от [чартов на основе датасета](dataset-based-charts.md), в QL-чартах логика использования области визуализации смещена в сторону запроса в источник, то есть область визуализации только отображает данные из запроса.


{% note alert %}

Если выдать пользователю [доступ для просмотра](../../security/manage-access#permission-read) вашего QL-чарта, он сможет выполнить любые запросы к любым данным источника этого QL-чарта.

{% endnote %}

Поддерживаются следующие типы QL-чартов:

* **SQL**. Позволяют построить визуализацию, для которой можно гибко управлять набором данных с помощью параметров SQL-запроса в БД источника.

  Особенности чартов типа SQL:

  * уменьшают нагрузку на БД благодаря прямым запросам;
  * подходят только для запросов `SELECT`;
  * позволяют применять операторы `JOIN`, `GROUP BY`, `SORT BY` и функции агрегации в SQL-запросе;
  * предоставляют возможность параметризации любой части SQL-запроса;
  * поддерживают ограниченный набор [типов визуализаций](../../visualization-ref/index.md);
  * не используют [RLS](../../security/row-level-security.md) и [вычисляемые поля](../calculations/index.md).

    {% include [datalens-sql-ch-example](../../../_includes/datalens/datalens-sql-ch-example.md) %}


* **{{ prometheus-name }}**. Позволяют построить график по данным {{ prometheus-name }}. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% include [datalens-prometheus-ch-example](../../../_includes/datalens/datalens-prometheus-ch-example.md) %}

* **{{ monitoring-short-name }}**. Позволяют построить график по данным {{ monitoring-full-name }}. Поверх этого источника не может быть построен датасет, работать с ним можно только с помощью QL-чартов.

  {% include [datalens-monitoring-ch-example](../../../_includes/datalens/datalens-monitoring-ch-example.md) %}

{% include [datalens-monitoring-prometheus-access-note](../../../_includes/datalens/datalens-monitoring-prometheus-access-note.md) %}



Чтобы создать QL-чарт, перейдите к [инструкции](../../operations/chart/create-sql-chart.md).

#### См. также {#see-also}

* [{#T}](../../operations/chart/create-sql-chart.md)
* [{#T}](../../concepts/chart/index.md)
* [{#T}](../../operations/chart/create-chart.md)

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}