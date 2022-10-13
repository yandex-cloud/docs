# Watermark

`Watermark` это альтернативный стандартному [режиму `HOP`](stream-processing-windows.md#) механизм, позволяющий указывать различные политики ожидания отстающих данных.

Стандартный режим работы `HOP` закрывает окна обработки только по пришествию новых данных. То есть новые данные "проталкивают" обработку вперед. Если данные перестают приходить, это приводит к остановке выдачи результатов.

Режим работы с watermark не полагается на поступающие данные, вместо этого watermark определяет специальные критерии, что данных больше ждать не нужно и можно закрывать окна обработки. 

## Что такое Watermark

Концепция watermark'ов впервые появилась в серии постов Tyler Akendau [Streaming 102](https://www.oreilly.com/radar/the-world-beyond-batch-streaming-102/). 

Потоковая обработка данных всегда балансирует между полнотой обрабатываемых данных и скоростью получения результатов: если нужна максимальная точность, то нужно дождаться всех данных. Если же важна скорость, то можно не ждать части отстающих данных, что ускорит получение результатов, но ухудшит точность.

Концепция watermark'ов позволяет определять различные критерии, что данных можно дальше не ждать, и уже можно начинать обработку. Правильно выбранный режим watermark'ов позволяет получать корректные результаты без специальных механизмов уточнений уже переданных данных (`retraction`).

Watermark'и фактически сигнализируют, что данных со временем меньше, чем времени watermark быть уже больше не может, поэтому можно выполнить все расчеты со временем событий меньшим, чем Watermark. Из-за этого концепция продвижения времени является очень важной.

## Продвижение времени

{{yq-full-name}} опирается на время записи событий в шину данных {{yds-full-name}}. 

Временем watermark'а является минимальное время записи в шину данных во всех сегментах шины данных минус время ожидания остающих данных. 

Если данных в каком-либо сегменте нет, то {{yq-full-name}} выполняет предсказание watermark'a, исходя из предыдущих переданных данных. То есть раз в некоторое время сегменты без данных все равно продвигают watermark на некоторую величину. В этом случае временем сегмента является текущее ожидаемое время данных минус время ожидания отстающих данных. 

## Синтаксис

Пример синтаксиса:

```sql
SELECT
    *
FROM 
    bindings.`<binding name>` 
GROUP BY 
    HoppingWindow(interval, step);
```

Где:

- `bindings` — указание, что работа производится через [привязки к данным](../concepts/glossary.md#binding).
- `<binding name>` — название привязки к данным.
- `HoppingWindow` — указание, что обработка данных выполняется с помощью Watermark'ов.
- `hop` — шаг окна группировки по времени. Подробнее про окна обработки описано в разделе [Окна потоковой обработки](stream-processing-windows.md).
- `interval` — длина окна группировки по времени. Подробнее про окна обработки описано в разделе [Окна потоковой обработки](stream-processing-windows.md).