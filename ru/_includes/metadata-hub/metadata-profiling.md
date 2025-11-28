* В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_types.title }}** выберите, какие типы метаданных необходимо извлекать из источника.
* (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.profiling.title }}**:

  * Выберите опцию **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.enabled.title }}**, чтобы выполнять профилирование данных, т. е. анализ и сбор статистики об извлекаемых данных.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-level-only_7nYxP }}**, чтобы не выполнять профилирование данных в каждом столбце таблицы. Если опция включена, характеристики данных будут собираться только по таблице в целом.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.max_workers.title }}** укажите количество вычислительных потоков для профилирования.
  * В поле **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.sample_size.title }}** укажите количество строк для выборки при профилировании столбцов. Настройка применяется при включенной опции **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.use_sampling.title }}**.
  * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-size-limit_wgTaU }}** укажите размер таблицы (в ГБ), при превышении которого таблицы исключаются из профилирования.
  * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-row-limit_c8X7A }}** укажите количество строк, при превышении которого таблицы исключаются из профилирования.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-null-count_sAR8k }}**, чтобы получить количество строк со значением `NULL` для каждого столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-count_73gDL }}**, чтобы получить количество уникальных значений для каждого столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-min-value_24EaF }}**, чтобы получить минимальное значение для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-max-value_4D1zy }}**, чтобы получить максимальное значение для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-mean-value_6qPHU }}**, чтобы получить среднее значение для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-median-value_jPJbY }}**, чтобы получить медианное значение для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-stddev-value_p9Gbi }}**, чтобы получить стандартное отклонение для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-quantiles_14ojH }}**, чтобы получить квантили для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-value-frequencies_tag9L }}**, чтобы получить частоту уникальных значений для каждого столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-histogram_dsfNW }}**, чтобы получить гистограмму для каждого числового столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-sample-values_msWXw }}**, чтобы получить примеры значений для каждого столбца.
  * Выберите опцию **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_query-combiner-enabled_mUDtA }}**, чтобы динамически объединять SQL-запросы для ускорения профилирования.
  * В поле **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_limit_nTvrt }}** укажите максимальное количество строк для профилирования. При значении `0` будут профилироваться все строки.

* В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_process.title }}** выберите, каким образом обрабатывать метаданные:
  * Чтобы повысить производительность загрузки, включите опцию **{{ ui-key.data-catalog.console.form.ingestion.MetadataProcessSection.use_file_backed_cache.title }}**.
