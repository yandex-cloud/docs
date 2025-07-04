* В блоке **Типы метаданных** выберите, какие типы метаданных необходимо извлекать из источника.
* (Опционально) В блоке **Профилирование данных**:
  * Выберите опцию **Включить профилирование**, чтобы выполнять профилирование данных, т. е. анализ и сбор статистики об извлекаемых данных.
  * Выберите опцию **Профилировать только на уровне таблиц**, чтобы не выполнять профилирование данных в каждом столбце таблицы. Если опция включена, характеристики данных будут собираться только по таблице в целом.
  * В поле **Максимум рабочих процессов** укажите количество вычислительных потоков для профилирования.
  * В поле **Размер выборки** укажите количество строк для выборки при профилировании столбцов. Настройка применяется при включенной опции **Использовать выборку**.
  * В поле **Предел размера таблицы** укажите размер таблицы (в ГБ), при превышении которого таблицы исключаются из профилирования.
  * В поле **Предел количества строк таблицы** укажите количество строк, при превышении которого таблицы исключаются из профилирования.
  * Укажите, какие характеристики данных необходимо извлекать из источника:
    * **include_field_null_count** – количество строк со значением `NULL` в таблице или в каждом столбце.
    * **include_field_distinct_count** — количество строк с различными значениями в таблице или в каждом столбце.
    * **include_field_min_value** — минимальное значение по таблице или по каждому столбцу.
    * **include_field_max_value** – максимальное значение по таблице или по каждому столбцу.
    * **include_field_mean_value** — среднее значение по таблице или по каждому столбцу.
    * **include_field_median_value** — медиана по таблице или по каждому столбцу.
    * **include_field_stddev_value** – стандартное отклонение по таблице или по каждому столбцу.
    * **include_field_sample_values** — срезы данных, т. е. несколько значений подряд для каждого столбца.
* В блоке **Обработка метаданных** выберите, каким образом обрабатывать метаданные:
  * Чтобы повысить производительность загрузки, включите опцию **Использовать файловый кеш**.
