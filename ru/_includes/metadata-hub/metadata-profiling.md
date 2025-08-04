* В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_types.title }}** выберите, какие типы метаданных необходимо извлекать из источника.
* (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.profiling.title }}**:
  * Выберите опцию **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.enabled.title }}**, чтобы выполнять профилирование данных, т. е. анализ и сбор статистики об извлекаемых данных.
  * Выберите опцию **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_level_only.title }}**, чтобы не выполнять профилирование данных в каждом столбце таблицы. Если опция включена, характеристики данных будут собираться только по таблице в целом.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.max_workers.title }}** укажите количество вычислительных потоков для профилирования.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.sample_size.title }}** укажите количество строк для выборки при профилировании столбцов. Настройка применяется при включенной опции **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.use_sampling.title }}**.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_size_limit.title }}** укажите размер таблицы (в ГБ), при превышении которого таблицы исключаются из профилирования.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_row_limit.title }}** укажите количество строк, при превышении которого таблицы исключаются из профилирования.
  * Укажите, какие характеристики данных необходимо извлекать из источника:
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_null_count.title }}** – количество строк со значением `NULL` в таблице или в каждом столбце.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_distinct_count.title }}** — количество строк с различными значениями в таблице или в каждом столбце.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_min_value.title }}** — минимальное значение по таблице или по каждому столбцу.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_max_value.title }}** – максимальное значение по таблице или по каждому столбцу.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_mean_value.title }}** — среднее значение по таблице или по каждому столбцу.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_median_value.title }}** — медиана по таблице или по каждому столбцу.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_stddev_value.title }}** – стандартное отклонение по таблице или по каждому столбцу.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_sample_values.title }}** — срезы данных, т. е. несколько значений подряд для каждого столбца.
* В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_process.title }}** выберите, каким образом обрабатывать метаданные:
  * Чтобы повысить производительность загрузки, включите опцию **{{ ui-key.data-catalog.console.form.ingestion.MetadataProcessSection.use_file_backed_cache.title }}**.
