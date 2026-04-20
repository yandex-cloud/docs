If you have not selected a data export for a previous period, the first details will be dated with the date of creating the regular export. A new file with details is created in the bucket daily. The file name contains a prefix and the date covered by the details. The file gets overwritten and updated with new data every hour.

The information in any daily file can be updated within a month.

{% note tip %}

Files with details are not deleted from the bucket automatically; however, you can schedule them to be deleted from time to time. For more information, see [Object lifecycle](../storage/concepts/lifecycles.md) ({{ objstorage-name }} refers to files in a bucket as _objects_).

{% endnote %}
