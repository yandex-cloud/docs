{% note info %}

{{ ml-platform-name }} использует системные переменные для работы с кластером {{ dataproc-name }}. Не переопределяйте значения следующих переменных:
* `sc`
* `spark`
* `HiveContext`
* `StreamingContext`
* `SqlContext`

{% endnote %}