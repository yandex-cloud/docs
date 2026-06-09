# Создание загрузки данных


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


Если в группе безопасности подсети {{ yandex-cloud }} источника метаданных действуют правила, ограничивающие трафик, нужно добавить новое правило для разрешения входящего трафика:

  * по диапазону IP‑адресов CIDR 198.19.0.0/16 — для {{ data-catalog-name }};
  * по порту, который используется для подключения к источнику данных с целью создания загрузки. Например, для сервиса {{ mpg-name }} это порт 6432.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать загрузку.
  1. На панели слева выберите ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Задайте параметры загрузки:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя загрузки.
      * (Опционально) Добавьте описание загрузки.
      * Выберите или создайте источник данных.
      * Задайте конфигурацию загрузки для выбранного источника данных:

         * Выберите расписание запуска загрузки:

            * **{{ ui-key.data-catalog.console.form.cron.Cron.month.title }}** — выберите числа месяца, время начала и окончания загрузки.
            * **{{ ui-key.data-catalog.console.form.cron.Cron.week.title }}** — выберите дни недели, время начала и окончания загрузки.
            
               {% note info %}
            
               По расписанию **{{ ui-key.data-catalog.console.form.cron.Cron.month.title }}** и **{{ ui-key.data-catalog.console.form.cron.Cron.week.title }}** загрузка запускается в указанное время и останавливается, когда новые данные загружены. Если при загрузке данных возникли ошибки, она будет перезапускаться, пока данные не загрузятся или пока не истечет заданное время.
            
               {% endnote %}
            
            * **{{ ui-key.data-catalog.console.form.cron.Cron.day.title }}** — выберите временные интервалы для загрузки.
            * **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}** — для запуска загрузки только вручную.

         * (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}** с помощью регулярных выражений укажите, какие бэкенды и объекты баз данных необходимо включить или исключить из загрузки.

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

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}