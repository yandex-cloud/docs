* Добавлена возможность устанавливать переменные окружения:

    * `HADOOP_HEAPSIZE_MIN` и `HADOOP_HEAPSIZE_MAX` для сервиса `hadoop`:
        * `hadoop.env:HADOOP_HEAPSIZE_MIN`
        * `hadoop.env:HADOOP_HEAPSIZE_MAX`
    * `HADOOP_HEAPSIZE` для сервиса `hive` (доступно только для образов 2.0): `hive.env:HADOOP_HEAPSIZE`.

