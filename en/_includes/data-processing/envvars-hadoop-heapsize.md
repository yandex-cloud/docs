* Added support for environment variables:

    * `HADOOP_HEAPSIZE_MIN` and `HADOOP_HEAPSIZE_MAX` for the `hadoop` service:
        * `hadoop.env:HADOOP_HEAPSIZE_MIN`
        * `hadoop.env:HADOOP_HEAPSIZE_MAX`
    * `HADOOP_HEAPSIZE` for `hive` (available only for 2.0 images): `hive.env:HADOOP_HEAPSIZE`.

