* Under **Metadata types**, select the metadata types to extract from the source.
* Optionally, under **Data profiling**:
  * Select **Enable profiling** to perform data profiling, i.e., analysis and collection of statistics on extracted data.
  * Select **Profile only at table level** to skip data profiling in every table column. With this option on, data characteristics will only be collected for the table as a whole.
  * In the **Maximum workflows** field, specify the number of computing threads for profiling.
  * In the **Sample size** field, specify the number of rows for sampling for column profiling. This setting applies when the **Use sampling** option is enabled.
  * In the **Table size limit** field, specify table size in GB above which the table will be excluded from profiling.
  * In the **Table row limit** field, specify the number of rows above which the table will be excluded from profiling.
  * Specify which data characteristics to extract from the source:
    * **include_field_null_count**: Number of `NULL` rows per table or per column.
    * **include_field_distinct_count**: Number of rows with different values per table or per column.
    * **include_field_min_value**: Minimum value per table or per column.
    * **include_field_max_value**: Maximum value per table or per column.
    * **include_field_mean_value**: Average value per table or per column.
    * **include_field_median_value**: Median value per table or per column.
    * **include_field_stddev_value**: Standard deviation per table or per column.
    * **include_field_sample_values**: Data slices, i.e., several consecutive values for each column.
* Under **Metadata processing**, select how to process metadata:
  * Enable **Use file cache** to improve ingestion performance.
