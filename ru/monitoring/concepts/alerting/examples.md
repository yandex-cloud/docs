# Примеры алертов

## Сценарии {#scenarios}

### Алерт на долю ошибок в ответах методов API {#api-errors}

Мульти-алерт на большую долю ошибок в ответах методов API, отдельный под-алерт по каждому методу API. Мониторятся только коды ответа 5хх.

Под-алерт переходит в статус `ALARM`, когда доля ошибок в ответах по методу API в пятиминутном окне превышает заданный порог.

В алерте выставлен параметр *Delay*, равный 60 секундам, поскольку алерт настроен на [агрегат](../aggregation.md#aggregation-on-write) по хостам. Это позволяет избежать ложных срабатываний алерта, так как данные в агрегате нарастают постепенно, по мере получения данных от хостов, участвующих в агрегации.


[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/api-errors)


### Алерт на большое время ответа методов API {#api-timings}

Мульти-алерт на большое время ответа методов API в 99 процентиле, отдельный под-алерт по каждому методу API.

Под-алерт переходит в статус `ALARM`, когда среднее значение 99 процентиля времени ответа по методу API за последние 5 минут превышает заданный порог.

В алерте выставлен параметр *Delay*, равный 60 секундам, поскольку алерт настроен на [агрегат](../aggregation.md#aggregation-on-write) по хостам. Это позволяет избежать ложных срабатываний алерта, так как данные в агрегате нарастают постепенно, по мере получения данных от хостов, участвующих в агрегации.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/api-timings)


### Алерт на превышение квоты на количество файловых метрик в шарде {#file-sensors-limit}

Мульти-алерт на превышение квоты на количество [файловых метрик](../limits.md#quotas) по каждому из шардов проекта.

Алерт переходит в статус `WARNING` при использовании >80% от выданной квоты (и в `ALARM` при использовании >90% от выданной квоты).

Для использования алерта в своем проекте необходимо подставить свое значение в переменную **project_id** в начале программы.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/file-sensors-limit)


### Алерт на превышение квоты на количество memonly-метрик в шарде {#in-memory-sensors-limit}

Мульти-алерт на превышение квоты на количество [memonly-метрик](../limits.md#quotas) по каждому из шардов проекта.

Алерт переходит в статус `WARNING` при использовании >80% от выданной квоты ( и в `ALARM` при использовании >90% от выданной квоты).

Для использования алерта в своем проекте необходимо подставить свое значение в переменную **project_id** в начале программы.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/in-memory-sensors-limit)


### Алерт на превышение квоты на количество метрик  в ответе для шардов Solomon {#metrics-per-url-limit}
 
Мульти-алерт на превышение квоты на [количество метрик в ответе](../limits.md#quotas) от любого из источников метрик в любом из шардов проекта в Solomon. 
 
Алерт переходит в статус `WARNING`, если  количество метрик в ответе от любого из хостов превышает  80% от выданной квоты (и в `ALARM`, если превышает 90% выданной квоты). 
 
Для использования алерта в своем проекте необходимо подставить свое значение в переменную **project_id** в начале программы.
[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/metrics-per-url-limit)


## Функциональность {#functionality}

### Пороговый алерт на одну метрику {#threshold-one-metric}

Пороговый алерт на одну метрику. Если среднее значение за последнюю минуту больше заданного порога, алерт перейдет в состояние `ALARM`.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/threshold-one-metric)

### Пороговый алерт на несколько метрик {#threshold-vector-metrics}

Пороговый алерт на несколько метрик. Если среднее значение **любой** из метрик за последнюю минуту больше заданного порога, алерт перейдет в состояние `ALARM`. В таком алерте нельзя работать более, чем со 100 метриками.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/threshold-vector-metrics)

### Пороговый мульти-алерт на одну метрику {#multi-alert-threshold}

Пороговый [мульти-алерт](index.md#multi-alerts), в котором создается независимый под-алерт для каждого значения метки `host`. Если на каком-либо хосте среднее значение за последнюю минуту больше заданного порога, соответствующий под-алерт перейдет в состояние `ALARM`.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/multi-alert-threshold)

### Получение значения метки из программы алерта {#get-label-value}

Алерт, получающий значение метки из программы при помощи функции [get_label](../querying.md#get_label) — например, для использования в [аннотациях](index.md#annotations).

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/get-label-value)

### Алерт на сумму линий {#sum-series-alert}

Expression-алерт на сумму нескольких метрик при помощи функции [series_sum](../querying.md#series_sum). Если среднее значение суммы метрик за последние 5 минут больше 20, алерт перейдет в состояние `ALARM`.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/sum-series-alert)

### Алерт на процентиль {#percentile-alert}

Expression-алерт на процентиль по гистограмме при помощи функции [histogram_percentile](../querying.md#histogram_percentile). Если среднее значение 99-го процентиля за последние 5 минут больше 1, алерт перейдет в состояние `ALARM`.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/percentile-alert)

### Алерт на отношение метрик {#ratio-alert}

Expression-алерт на отношение двух метрик при [арифметических функций](../querying.md#arithmetic-operations). Если среднее значение отношения метрик за последние 5 минут больше 0.5, алерт перейдет в состояние `ALARM`.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/ratio-alert)


### Мульти-алерт для некоторых хостов {#groupby-with-selector}

Мульти-алерт на максимальное значение метрики для всех хостов, не исключенных из селектора [оператором сравнения](../querying.md#comparison-operations) "!=". Для каждого не исключенного хоста будет создан свой под-алерт.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/groupby-with-selector)


### Алерт, не срабатывающий при отсутствии данных {#ignore-no-points}

Пороговый алерт, который не срабатывает при отсутствии данных. Если за последние 5 минут нет данных, то алерт будет находиться в состоянии `OK`. Обработка отсутствия данных осуществляется настройкой **No points policy**. [Подробнее о политиках алертов](./index.md#no-points-policy).

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/ignore-no-points)


### Алерт, не срабатывающий при отсутствии метрик {#ignore-no-metrics}

Пороговый алерт, который переходит в статус `OK`, если селектор не вернул ни одной метрики. Обработка отсутствия метрики осуществляется настройкой **No metrics policy**. [Подробнее о политиках алертов](./index.md#no-metrics-policy).

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/ignore-no-metrics)


### Алерт на данные в другом проекте {#cross-project}

Простой пороговый алерт на метрику из проекта Solomon.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/cross-project)

### Алерт, использующий различные типы уведомлений {#channels}

Алерт, использующий различные типы уведомлений: Email, Telegram (на конкретный логин и в [группу](https://t.me/joinchat/8fgLBimkpnUxOTJi), SMS, Webhook.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/channels)


### Алерт на превышение порога максимальным значением любой из метрик {#max-series-max-alert}

Expression-алерт на превышение порога максимальным значением любой из метрик, выбранных селектором.

Алерт переходит в статус `ALARM`, когда максимальное значение любой из метрик за последние 5 минут становится > 3.

Для использования алерта в своем проекте необходимо подставить свое значение в переменную **data** в начале программы.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/max-series-max-alert)

### Алерт со ссылкой на график в момент вычисления алерта {#graph-link}

Пороговый алерт на среднее значение метрики за последние 5 минут, у которого есть [аннотация](index.md#annotations) `details`, содержащая ссылку на график метрик в момент вычисления алерта.

### Отображение пользовательского значения на виджете алерта {#widget-with-annotation} {#lights}

Пороговый алерт на среднее значение метрики за последние 5 минут, на виджете которого отображается [аннотация](index.md#annotations) с вычисленным значением.

[Пример алерта в UI](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/widget-with-annotation)

[Виджет алерта](https://solomon.yandex-team.ru/admin/projects/monitoring-examples/alerts/widget-with-annotation/singlestat?annotationKeys=value)

### Как создать алерт на No data? {#nodata}

В настройках [канала уведомлений](#notifications) можно включить отправку уведомлений, если алерт перешел в статус No data.
