* Under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_types.title }}**, select the metadata types to extract from the source.
* Optionally, under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.profiling.title }}**:

  * Select **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.enabled.title }}** to perform data profiling, i.e., analysis and collection of statistics on the data being extracted.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-level-only_7nYxP }}** to skip data profiling in every table column. With this option on, data characteristics will only be collected for the table as a whole.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.max_workers.title }}** field, specify the number of computing threads for profiling.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.sample_size.title }}** field, specify the number of rows for sampling for column profiling. This setting applies when the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.use_sampling.title }}** option is enabled.
  * In the **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-size-limit_wgTaU }}** field, specify the table size in GB above which the table will be excluded from profiling.
  * In the **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_profile-table-row-limit_c8X7A }}** field, specify the number of rows above which the table will be excluded from profiling.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-null-count_sAR8k }}** to get the number of rows with `NULL` for each column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-count_73gDL }}** to get the number of unique values for each column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-min-value_24EaF }}** to get the minimum value for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-max-value_4D1zy }}** to get the maximum value for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-mean-value_6qPHU }}** to get the mean value for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-median-value_jPJbY }}** to get the median value for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-stddev-value_p9Gbi }}** to get the standard deviation value for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-quantiles_14ojH }}** to get quantiles for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-distinct-value-frequencies_tag9L }}** to get the frequency of unique values for each column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-histogram_dsfNW }}** to get a histogram for each numeric column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_include-field-sample-values_msWXw }}** to get sample values for each column.
  * Select **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_query-combiner-enabled_mUDtA }}** to dynamically combine SQL queries for faster profiling.
  * In the **{{ ui-key.yacloud.ui.metadata-hub.data-catalog.constants.label_limit_nTvrt }}** field, specify the maximum number of rows to profile. If set to `0`, all rows will be profiled.

* Under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_process.title }}**, select the image for metadata processing:
  * Enable **{{ ui-key.data-catalog.console.form.ingestion.MetadataProcessSection.use_file_backed_cache.title }}** to improve ingestion performance.
