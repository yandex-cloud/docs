---
title: "Язык запросов в {{ monitoring-full-name }}"
description: "В этом разделе описан язык запросов {{monitoring-full-name}}. Он используется для преобразования метрик при настройке дашбордов и алертов, а также в API-методе MetricsData.read."
---

# Язык запросов в {{ monitoring-name }}

В этом разделе описан язык запросов {{monitoring-full-name}}. Он используется для преобразования метрик при настройке [дашбордов](./visualization/dashboard.md) и [алертов](./alerting.md), а также в API-методе [MetricsData.read](../api-ref/MetricsData/read.md).

## Загрузка метрик {#selectors}

Выбирайте множество метрик с помощью имени метрик и набора _селекторов_, фильтрующих значения меток (подробнее в разделе [{#T}](./data-model.md#label)). Получившиеся наборы метрик можно использовать в алертах или передавать в функцию в качестве аргумента.

> Укажите имя метрики, а также обязательные метки `folderId` и `service`. Тогда запрос `cpu_usage{folderId="zoeu2rgjpqak********", service="compute"}` вернет метрики с именем `cpu_usage` для всех виртуальных машин сервиса {{compute-full-name}} в каталоге с идентификатором `zoeu2rgjpqak********`.

{% note warning %}

Значение метки `folderId` всегда должно совпадать с выбранным каталогом, запрашивать данные из других каталогов запрещено. Это ограничение касается всех вариантов применения языка запросов: при построении графиков в Обзоре метрик или на дашбордах, при создании алертов или при вызове API-методов.

{% endnote %}

_Селектор_ состоит из имени метки, оператора и выражения, описывающего множество значений меток.

В языке запросов {{monitoring-full-name}} поддерживаются следующие выражения для фильтрации значений меток:

- `label="*"` — возвращает все метрики, у которых присутствует указанная метка.

  > Селектор `host="*"` вернет все метрики, у которых есть метка `host`.

- `label="<glob-выражение>"` — возвращает все метрики, у которых есть метки, значения которых удовлетворяют [glob-выражению](https://ru.wikipedia.org/wiki/Шаблон_поиска).
  - `*` — любое количество символов (в том числе отсутствие).

    > `name="folder*"` вернет все метрики, у которых значение метки `name` начинается с префикса `folder`.

  - `?` — один произвольный символ.

    > `name="metric?"` вернет все метки, у которых в значении метки `name` есть один символ после `metric`.

  - `|` — все указанные варианты.

    > `name="metric1|metric2"` вернет две метрики со значениями метки `name=metric1` и `name=metric2`.

## Использование имен запросов в качестве переменных {#query-name-as-variable}

В языке запросов поддерживаются ссылки на результаты выполнения других запросов как на имена переменных.

Например:

A: `"temperature"{folderId="my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor1" }`

B: `"temperature"{folderId="my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor2" }`

C: `(A + B) / 2`

Ссылаться по имени можно только в текстовом режиме и на вышестоящие запросы в одном и том же алерте или графике. К переменным можно применять любые поддерживаемые арифметические операции и [функции](#functions) языка запросов.

## Типы данных {#data-types}

В языке запросов {{monitoring-full-name}} существуют следующие типы данных:

* _timeseries_vector_ — набор временных рядов (метрик);
* _number_ — вещественное число;
* _string_ — строка в одинарных или двойных кавычках;
* _duration_ — временной промежуток в формате `15s, 10m, 3h, 7d, 2w.` (записывается без кавычек);
* _bool_ – логический тип, может принимать одно из двух значений: `true` или `false`.
* _scalar_ – вещественное число с плавающей точкой двойной точности по [стандарту IEEE 754](https://ru.wikipedia.org/wiki/IEEE_754-2008), включая специальное значение `NaN`.

{% note info %}

При записи вещественных чисел поддерживается запись с мантиссой, а также следующие суффиксы:

* `k` — 10^3^;
* `M` — 10^6^;
* `G` — 10^9^;
* `T` — 10^12^;
* `P` — 10^15^;
* `E` – 10^18^.

{% endnote %}

## Функции {#functions}

- [Агрегация](#aggregation-functions)
  - [avg](#avg)
  - [count](#count)
  - [integrate](#integrate)
  - [iqr](#iqr)
  - [last](#last)
  - [max](#max)
  - [median](#median)
  - [min](#min)
  - [percentile](#percentile)
  - [random](#random)
  - [std](#std)
  - [sum](#sum)
- [Комбинирование](#combine-functions)
  - [histogram_avg](#histogram_avg)
  - [histogram_cdfp](#histogram_cdfp)
  - [histogram_count](#histogram_count)
  - [histogram_percentile](#histogram_percentile)
  - [histogram_sum](#histogram_sum)
  - [series_avg](#series_avg)
  - [series_max](#series_max)
  - [series_min](#series_min)
  - [series_percentile](#series_percentile)
  - [series_sum](#series_sum)
- [Ранжирование](#rank-functions)
  - [bottom_avg](#bottom_avg)
  - [bottom_count](#bottom_count)
  - [bottom_last](#bottom_last)
  - [bottom_max](#bottom_max)
  - [bottom_min](#bottom_min)
  - [bottom_sum](#bottom_sum)
  - [top_avg](#top_avg)
  - [top_count](#top_count)
  - [top_last](#top_last)
  - [top_max](#top_max)
  - [top_min](#top_min)
  - [top_sum](#top_sum)
- [Преобразование](#transform-functions)
  - [abs](#abs)
  - [asap](#asap)
  - [ceil](#ceil)
  - [derivative](#derivative)
  - [diff](#diff)
  - [drop_above](#drop_above)
  - [drop_below](#drop_below)
  - [drop_nan](#drop_nan)
  - [exp](#exp)
  - [floor](#floor)
  - [fract](#fract)
  - [heaviside](#heaviside)
  - [integral](#integral)
  - [log](#log)
  - [moving_avg](#moving_avg)
  - [moving_percentile](#moving_percentile)
  - [moving_sum](#moving_sum)
  - [non_negative_derivative](#non_negative_derivative)
  - [pow](#pow)
  - [ramp](#ramp)
  - [replace_nan](#replace_nan)
  - [round](#round)
  - [shift](#shift)
  - [sign](#sign)
  - [sqrt](#sqrt)
  - [trunc](#trunc)
- [Другое](#other-functions)
  - [alias](#alias)
  - [constant_line](#constant_line)
  - [drop_empty_series](#drop_empty_series)

### Агрегация {#aggregation-functions}

Функции агрегации агрегируют значения временного ряда в текущем временном диапазоне.

{% note warning %}

Агрегационные функции принимают в качестве входного аргумента вектор метрик _timeseries_vector_. Он должен содержать только один временной ряд, в противном случае функция вернет ошибку выполнения.

При использовании агрегационных функций убедитесь, что селектор возвращает один временной ряд. При необходимости воспользуйтесь [функциями комбинирования](#combine-functions).

{% endnote %}

#### avg

Возвращает среднее значение (для временных рядов — взвешенное среднее) набора элементов или `NaN` для пустого временного ряда.

Функция **avg** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **avg**(_arg0_: _scalar[]_): _scalar_
* **avg**(_arg0_: _timeseries_vector_): _scalar_

#### count

Возвращает количество точек для метрики или количество вектора чисел.

Функция **count** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **count**(_arg0_: _scalar[]_): _scalar_
* **count**(_arg0_: _timeseries_vector_): _scalar_

#### integrate

Возвращает интегрированную сумму значений или 0 для пустого временного ряда.

Функция **integrate** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **integrate**(_arg0: scalar[]_): _scalar_
* **integrate**(_arg0_: _timeseries_vector_): _scalar_

#### iqr

Возвращает [межквартильный интервал](https://en.wikipedia.org/wiki/Interquartile_range) набора значений.

Функция **iqr** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **iqr**(_arg0_: _scalar[]_): _scalar_
* **iqr**(_arg0_: _timeseries_vector_): _scalar_

#### last

Возвращает последнее значение, отличное от `NaN` или `NaN`, для пустого временного ряда.

Функция **last** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **last**(_arg0_: _scalar[]_): _scalar_
* **last**(_arg0_: _timeseries_vector_): _scalar_

#### max

Возвращает максимальное значение или `NaN` для пустого временного ряда.

Функция **max** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **max**(_arg0_: _scalar[]_): _scalar_
* **max**(_arg0_: _timeseries_vector_): _scalar_

#### median

Возвращает медиану значений или `NaN` для пустого временного ряда.

Функция **median** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **median**(_arg0_: _scalar[]_): _scalar_
* **median**(_arg0_: _timeseries_vector_): _scalar_

#### min

Возвращает минимальное значение или `NaN` для пустого временного ряда.

Функция **min** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **min**(_arg0_: _scalar[]_): _scalar_
* **min**(_arg0_: _timeseries_vector_): _scalar_

#### percentile

Возвращает значение процентиля для набора значений. Уровень процентиля задается в обязательном параметре _level_ в виде числа от 0 до 100.

Функция **percentile** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра *values* (массив чисел, метрика или вектор метрик):

* **percentile**(_level_: _scalar_, _values: scalar[]_): _scalar_
* **percentile**(_level_: _scalar_, _values: timeseries_vector_): _scalar_

#### random

Возвращает случайный элемент из набора значений.

Функция **random** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **random**(_arg0_: _scalar[]_): _scalar_
* **random**(_arg0_: _timeseries_vector_): _scalar_

#### std

Возвращает несмещенную оценку стандартного отклонения для набора значений (или `NaN` для пустого временного ряда), вычисленную по следующей формуле:

$$\begin{array}{c}
s=\sqrt{\frac{1}{n-1}\sum_{i=1}^n\left(x_i-\bar{x}\right)^2}
\end{array}{}
,
$$

где:
* $x_i$ — значение из вектора значений (или точек временного ряда);
* $\bar{x}$ — среднее значение;
* $n$ – количество значений.

Функция **std** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **std**(_arg0_: _scalar[]_): _scalar_
* **std**(_arg0_: _timeseries_vector_): _scalar_

#### sum

Возвращает сумму всех значений из набора или 0 для пустого временного ряда.

Функция **sum** имеет следующие варианты перегрузки функции в зависимости от типа входного параметра _arg0_ (массив чисел, метрика или вектор метрик):

* **sum**(_arg0_: _scalar[]_): _scalar_
* **sum**(_arg0_: _timeseries_vector_): _scalar_

### Комбинирование {#combine-functions}

Функции комбинирования агрегируют вектор метрик в одну метрику или вектор метрик.

#### histogram_avg

**histogram_avg**(*[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Вычисляет среднее значение распределения, заданного гистограммой. Опциональный параметр _bucketLabel_ указывает, в какой метке содержатся значения интервалов гистограммы.

#### histogram_cdfp

Функция **histogram_cdfp** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входных параметров _from_ и _to_ (число или массив чисел):

- **histogram_cdfp**(*[from: number*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_cdfp**(*[from: number*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_cdfp**(*[from: number[]*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_cdfp**(*[from: number[]*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Вычисляет долю значений в гистограмме между интервалами, заданными в опциональных параметрах _from_ и _to_. Если параметры не заданы, используются первый и последний интервал соответственно. Опциональный параметр _bucketLabel_ указывает, в какой метке содержатся значения интервалов гистограммы.

#### histogram_count

Функция **histogram_count** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входных параметров _from_ и _to_ (число или массив чисел):

- **histogram_count**(*[from: number*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number*, *to: number[]*, *bucketLabel: string*], *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number[]*, *to: number*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_count**(*[from: number[]*, *to: number[]*, *bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Вычисляет количество значений в гистограмме между интервалами, заданными в опциональных параметрах _from_ и _to_. Если параметры не заданы, будет использоваться первый и последний интервал соответственно. Опциональный параметр _bucketLabel_ указывает, в какой метке содержатся значения интервалов гистограммы.

#### histogram_percentile

Функция **histogram_percentile** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входных параметров _from_ и _to_ (число или массив чисел):

- **histogram_percentile**(*percentileLevel: number*, *[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*
- **histogram_percentile**(*percentileLevel: number[]*, *[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Вычисляет значения процентиля распределения, заданного гистограммой. Уровень процентиля задается в обязательном параметре _percentileLevel_ в виде одного числа или массива чисел от 0 до 100. Опциональный параметр _bucketLabel_ указывает, в какой метке содержатся значения интервалов гистограммы.

#### histogram_sum

**histogram_sum**(*[bucketLabel: string]*, *source: timeseries_vector*): *timeseries_vector*

Вычисляет сумму значений гистограммы. Опциональный параметр _bucketLabel_ указывает, в какой метке содержатся значения интервалов гистограммы.

#### series_avg

Функция **series_avg** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входного параметра _key_ (строка или массив строк):

- **series_avg**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_avg**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Агрегирует временные ряды в один (или несколько), применяя агрегационную функцию avg (среднее) для каждого момента времени. Опциональный параметр _key_ содержит строку или массив строк со списком меток, по которым выполняется группировка.

Например, запрос `series_avg({...})` в каждой точке вычислит среднее значение среди всех загруженных метрик.

Запрос `series_avg("host", {...})` для каждого значения метки `host` вычислит среднее значение среди всех загруженных метрик.

Запрос `series_avg(["host", "disk"], {...})` для каждой комбинации значений меток `host` и `disk` вычислит среднее значение среди всех загруженных метрик.


#### series_max

Функция **series_max** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входного параметра _key_ (строка или массив строк):

- **series_max**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_max**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Агрегирует временные ряды в один (или несколько), применяя агрегационную функцию max (максимум) для каждого момента времени. Опциональный параметр _key_ содержит строку или массив строк со списком меток, по которым выполняется группировка. Примеры запросов с использованием параметра _key_ смотрите в разделе [series_avg](#series_avg).

#### series_min

Функция **series_min** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входного параметра _key_ (строка или массив строк):

- **series_min**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_min**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Агрегирует временные ряды в один (или несколько), применяя агрегационную функцию min (минимум) для каждого момента времени. Опциональный параметр _key_ содержит строку или массив строк со списком меток, по которым выполняется группировка. Примеры запросов с использованием параметра _key_ смотрите в разделе [series_avg](#series_avg).

#### series_percentile

Функция **series_percentile** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входного параметра _rank_ (число или массив чисел):

- **series_percentile**(*rank: number*, *source: timeseries_vector*): *timeseries_vector*
- **series_percentile**(*rank: number[]*, *source: timeseries_vector*): *timeseries_vector*

Агрегирует временные ряды в один (или несколько), применяя агрегационную функцию percentile (процентиль) для каждого момента времени.

#### series_sum

Функция **series_sum** имеет следующие варианты использования (перегрузки функции) в зависимости от типа входного параметра _key_ (строка или массив строк):

- **series_sum**(*[key: string]*, *source: timeseries_vector*): *timeseries_vector*
- **series_sum**(*[key: string[]]*, *source: timeseries_vector*): *timeseries_vector*

Агрегирует временные ряды в один (или несколько), применяя агрегационную функцию sum (сумма) для каждого момента времени. Опциональный параметр _key_ содержит строку или массив строк со списком меток, по которым выполняется группировка. Примеры запросов с использованием параметра _key_ смотрите в разделе [series_avg](#series_avg).


### Ранжирование {#rank-functions}

Функции ранжирования упорядочивают вектор метрик по значению агрегационной функции в текущем временном окне и возвращают из него несколько первых (верхних) или последних (нижних) временных рядов. Параметр _limit_ указывает, какое количество метрик вернет функция.

#### bottom_avg

**bottom_avg**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным средним значением.

#### bottom_count

**bottom_count**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным количеством значений.

#### bottom_last

**bottom_last**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным последним значением.

#### bottom_max

**bottom_max**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным значением максимума.

#### bottom_min

**bottom_min**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным значением минимума.

#### bottom_sum

**bottom_sum**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с минимальным значением суммы.

#### top_avg

**top_avg**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным средним значением.

#### top_count

**top_count**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным количеством значений.

#### top_last

**top_last**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным последним значением.

#### top_max

**top_max**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным значением максимума.

#### top_min

**top_min**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным значением минимума.

#### top_sum

**top_sum**(*limit: number*, *source: timeseries_vector*): *timeseries_vector*

Возвращает _limit_ метрик с максимальным значением суммы.


### Преобразование {#transform-functions}

Функции преобразования метрик для каждого временного ряда из набора метрик вычисляют в каждой точке новое значение.

#### abs

**abs**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет абсолютное значение.

#### asap

**asap**(*source: timeseries_vector*): *timeseries_vector*

Сглаживает временные ряды по [алгоритму ASAP](http://futuredata.stanford.edu/asap/).
Точки временного ряда усредняются при помощи скользящего среднего с динамическим окном. Ширина окна автоматически выбирается таким образом, чтобы убрать как можно больше шума, сохраняя при этом важную информацию.

#### ceil

**ceil**(*source: timeseries_vector*): *timeseries_vector*

Округляет значения точек вверх до ближайшего целого числа.

#### derivative

**derivative**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет производную: разность между значениями соседних точек, поделенную на интервал между ними.

#### diff

**diff**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет разность между значениями каждой пары соседних точек.

#### drop_above

**drop_above**(*source: timeseries_vector*, *threshold: number*): *timeseries_vector*

Отбрасывает точки со значением выше порога _threshold_ (значение не включается). В отброшенных точках значение метрики будет равно `NaN`.

#### drop_below

**drop_below**(*source: timeseries_vector*, *threshold: number*): *timeseries_vector*

Отбрасывает точки со значением ниже порога _threshold_ (значение не включается). В отброшенных точках значение метрики будет равно `NaN`.

#### drop_nan

**drop_nan**(*source: timeseries_vector*): *timeseries_vector*

Отбрасывает точки со значением `NaN`.

#### exp

Вычисляет экспоненциальную функцию: возводит _e_ в степень, равную значению точек, где _e=2.718281..._ — основание натурального логарифма.

#### floor

**floor**(*source: timeseries_vector*): *timeseries_vector*

Округляет значения точек вниз до ближайшего целого числа.

#### fract

**fract**(*source: timeseries_vector*): *timeseries_vector*

Выделяет вещественную часть значений точек.

#### heaviside

**heaviside**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет [функцию Хевисайда](https://ru.wikipedia.org/wiki/Функция_Хевисайда). Функция равна 1, если значения точек положительные, и равна 0, если значения точек отрицательные.

#### integral

**integral**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет неопределенный интеграл [методом трапеций](https://ru.wikipedia.org/wiki/Метод_трапеций).

#### log

**log**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет натуральный логарифм.

#### moving_avg

**moving_avg**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Вычисляет скользящее среднее с шириной окна _window_.

Например, запрос `moving_avg({...}, 1d)` вернет скользящее среднее с окном в 1 день.

#### moving_percentile

**moving_percentile**(*source: timeseries_vector*, *window: duration*, *rank: number*): *timeseries_vector*

Вычисляет скользящий процентиль: процентиль уровня _rank_ (от 0 до 100) среди точек, попавших в окно шириной _window_.

Например, запрос `moving_percentile({...}, 1h, 99.9)` вернет скользящий 99,9-й процентиль с окном в 1 час.

#### moving_sum

**moving_sum**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Вычисляет скользящую сумму с шириной окна _window_.

Например, запрос `moving_sum({...}, 1d)` вернет скользящую сумму с окном в 1 день.

#### non_negative_derivative

**non_negative_derivative**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет производную: разность между значениями соседних точек, поделенную на интервал между ними. Если значение производной принимает отрицательное значение, вместо него используется значение `NaN`.

#### pow

**pow**(*source: timeseries_vector*, *power: number*): *timeseries_vector*

Вычисляет степенную функцию: возводит значение точек в степень *power*.

#### ramp

**ramp**(*source: timeseries_vector*): *timeseries_vector*

Заменяет точки с отрицательным значением на 0.

#### replace_nan

**replace_nan**(*source: timeseries_vector*, *replace: number*): *timeseries_vector*

Заменяет точки со значением `NaN` на значение `replace`.

#### round

**round**(*source: timeseries_vector*): *timeseries_vector*

Округляет значения до ближайшего целого.

#### shift

**shift**(*source: timeseries_vector*, *window: duration*): *timeseries_vector*

Добавляет к временным меткам точек значение `window`. Эта функция позволяет сравнивать текущие значения метрики со значениями за другой временной интервал.

Например, `shift({...}, 1w)` — вернет метрики со смещением на неделю вперед, то есть в выбранном временном окне будут значения недельной давности.

#### sign

**sign**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет функцию *sgn(x)*. Функция равна 1 для положительных значений точек, 0 — для нулевых значений и -1 — для отрицательных значений.

#### sqrt

**sqrt**(*source: timeseries_vector*): *timeseries_vector*

Вычисляет квадратный корень значения точек.

#### trunc

**trunc**(*source: timeseries_vector*): *timeseries_vector*

Отбрасывает вещественную часть значения точек.


### Другое {#other-functions}

#### alias

**alias**(*source: timeseries_vector*, *arg1: string*): *timeseries_vector*

Переименовывает метрики. В аргументе можно использовать [mustache-шаблонизацию](https://mustache.github.io/) в формате `not_var{{label}}`, чтобы подставить в новое имя метрики значение метки.

#### constant_line

Возвращает постоянную линию, состоящую из двух точек в начале и конце интервала со значением *value*.

**constant_line**(*value: scalar*): *timeseries_vector*

При указании опционального параметра *grid* функция заполняет текущий временной интервал точками со значением *value* и шагом *grid* между точками.

**constant_line**(*value: scalar*, *grid: duration*): *timeseries_vector*

{% note warning %}

Функцию **constant_line** следует использовать только для отображений линий на графике. Использование функции в вычислениях приведет к некорректному результату, так как функция возвращает временной ряд только из двух точек в начале и конце интервала определения.

{% endnote %}

#### drop_empty_series

**drop_empty_series**(*source: timeseries_vector*): *timeseries_vector*

Отбрасывает временные ряды, в которых в заданном временном диапазоне либо нет точек, либо все точки со значением `NaN`.
