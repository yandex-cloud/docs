* Under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_types.title }}**, select the metadata types to extract from the source.
* Optionally, under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.profiling.title }}**:
  * Select **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.enabled.title }}** to perform data profiling, i.e., analysis and collection of statistics on the data being extracted.
  * Select **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_level_only.title }}** to skip data profiling in every table column. With this option on, data characteristics will only be collected for the table as a whole.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.max_workers.title }}** field, specify the number of computing threads for profiling.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.sample_size.title }}** field, specify the number of rows for sampling for column profiling. This setting applies when the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.use_sampling.title }}** option is enabled.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_size_limit.title }}** field, specify the table size in GB above which the table will be excluded from profiling.
  * In the **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.profile_table_row_limit.title }}** field, specify the number of rows above which the table will be excluded from profiling.
  * Specify which data characteristics to extract from the source:
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_null_count.title }}**: Number of `NULL` rows per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_distinct_count.title }}**: Number of rows with different values per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_min_value.title }}**: Minimum value per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_max_value.title }}**: Maximum value per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_mean_value.title }}**: Average value per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_median_value.title }}**: Median value per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_stddev_value.title }}**: Standard deviation per table or column.
    * **{{ ui-key.data-catalog.console.form.ingestion.ProfilingConfigForm.include_field_sample_values.title }}**: Data slices, i.e., several consecutive values for each column.
* Under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.metadata_process.title }}**, select the image for metadata processing:
  * Enable **{{ ui-key.data-catalog.console.form.ingestion.MetadataProcessSection.use_file_backed_cache.title }}** to improve ingestion performance.
