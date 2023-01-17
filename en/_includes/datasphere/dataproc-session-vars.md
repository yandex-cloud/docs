{% note info %}

{{ ml-platform-name }} uses system variables to run {{ dataproc-name }} clusters. Don't override the values of the following variables:
* `sc`
* `spark`
* `HiveContext`
* `StreamingContext`
* `SqlContext`

{% endnote %}