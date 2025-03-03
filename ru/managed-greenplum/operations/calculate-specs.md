# Расчет конфигурации кластера

В этом разделе приведены рекомендации для расчета оптимальной конфигурации кластера для типовой нагрузки при использовании {{ mgp-name }} в качестве корпоративного [хранилища данных](https://ru.wikipedia.org/wiki/Хранилище_данных).

## Конфигурация хостов-сегментов {#segment}

Хосты-сегменты предназначены для хранения данных и обработки запросов к ним, поэтому требовательны к ресурсам. При выборе конфигурации хостов-сегментов отталкивайтесь от предполагаемого объема хранимых данных без учета сжатия (в гигабайтах).

* Рекомендуемый размер хранилища для хостов-сегментов:

    ```text
    <объем_данных_без_сжатия> × 1,5
    ```

    Формула справедлива при использовании стандартного сжатия (zstd) первого уровня (см. раздел [Создание колоночных таблиц](../concepts/tables.md#create-columnar-table)). Она учитывает [зеркалирование данных](../concepts/index.md), пространство под временные файлы при выполнении тяжелых запросов и свободное пространство, необходимое СУБД.

* Рекомендуемый суммарный объем оперативной памяти хостов-сегментов:

    ```text
    <объем_данных_без_сжатия> ÷ 8
    ```

* Рекомендуемое суммарное количество ядер vCPU хостов-сегментов:

    ```text
    <объем_данных_без_сжатия> ÷ 80
    ```

* Рекомендуемое количество хостов-сегментов в кластере:

    Рекомендуется создавать как можно больше хостов-сегментов с меньшим количеством ресурсов на каждом хосте, если их суммарные характеристики не ниже рассчитанных значений. Это поможет минимизировать последствия при выходе одного хоста из строя.

    При этом учтите, что при масштабировании кластера:

    * Новые хосты будут иметь ту же конфигурацию (объем памяти, количество ядер vCPU и количество сегментов на хост), что и хосты-сегменты при создании кластера.
    * Нельзя добавить менее двух новых хостов-сегментов.

* Рекомендуемое количество сегментов на хост зависит от двух параметров:

    * Количество ядер vCPU на хосте:

        * 8 ≤ vCPU < 32 — 4 сегмента.
        * 32 ≤ vCPU < 64 — 4-8 сегментов.
        * vCPU ≥ 64 — 8-16 сегментов.

        При таких значениях каждому сегменту выделяется минимум одно ядро vCPU, и еще минимум по одному ядру задействуют реплики — их количество совпадает с количеством сегментов.

        Большее количество сегментов позволяет быстрее выполнять длинные запросы, обеспечивая лучший параллелизм для одного запроса. Меньшее количество — оставляет больше ресурсов каждому сегменту и позволяет выполнять более требовательные к памяти запросы и больше запросов одновременно.

        При высокой ожидаемой конкурентности — от нескольких десятков до сотни одновременно выполняющихся запросов — выбирайте количество сегментов на хост ближе к нижнему пределу.

    * Количество файлов в базе данных.

        Рекомендуется, чтобы количество файлов на хосте не превышало 100 000:

        ```text
        <количество_сегментов_на_хост> ≤ 100 000 ÷ <количество_файлов_в_БД>
        ```

        Количество файлов можно грубо оценить по количеству таблиц в базе данных: на каждую [таблицу без кластеризованных индексов](../concepts/tables.md) (heap) приходится как минимум 3 файла, а на таблицу, оптимизированную для добавления (append-optimized) — около 7. При этом для партиционированных таблиц каждая партиция рассматривается как отдельная таблица, а для колоночно-ориентированных — каждая колонка.

* Необходимый объем оперативной памяти на каждый серверный процесс {{ GP }} — не меньше 20 МБ. Значение этого показателя рассчитывается по формуле:

    ```text
    <объем_RAM_хоста-сегмента> ÷ (<Max_connections> × <количество_сегментов_на_хост>)
    ```

    Где `Max_connections` — [настройка СУБД](../../managed-greenplum/concepts/settings-list.md#setting-max-connections) {{ GP }}.

    Если рассчитанное значение будет меньше 20 МБ, то при создании, изменении или восстановлении кластера возникнет [ошибка](../qa/cluster-hosts.md#memory-limit). Чтобы избежать ее, выберите класс хостов-сегментов с таким объемом оперативной памяти, при котором рассчитанное по формуле значение будет не меньше 20 МБ.

### Пример конфигурации хостов-сегментов {#segment-example}

Для хранения и обработки 20 480 ГБ (20 ТБ) несжатых данных понадобится кластер со следующими характеристиками хостов-сегментов:

* Размер хранилища: 20 480 ГБ × 1,5 = 30 720 ГБ.
* Объем оперативной памяти: 20 480 ГБ ÷ 8 = 2 560 ГБ.
* Количество ядер vCPU: 20 480 ГБ ÷ 80 = 256.

Это соответствует, например, двадцати хостам `{{ i2.2xlarge }}` с 4 сегментами на хост или десяти хостам `{{ i2.4xlarge }}` с 8 сегментами на хост. Подробнее о классах хостов см. в разделе [Доступные классы хостов](../concepts/instance-types.md#available-flavors).

## Конфигурация хостов-мастеров {#master}

Хосты-мастеры предназначены для обработки подключений и координации работы сегментов. Такие хосты не хранят и не обрабатывают данные, поэтому они менее требовательны к производительности.

Для хостов-мастеров рекомендуется использовать тот же [тип дисков](../concepts/storage.md), что и для хостов-сегментов.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
