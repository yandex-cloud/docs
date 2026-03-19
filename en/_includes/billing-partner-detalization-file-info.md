A new file with details is created in the bucket daily. The file name contains the prefix and date that details are collected for. The file is overwritten and updated with new data every hour.

The information can be updated in any daily file within a month.

{% note tip %}

Files with details from buckets are not deleted automatically, but you can configure scheduled deletion. For more information, see [Object lifecycle](../storage/concepts/lifecycles.md) ({{ objstorage-name }} refers to files in a bucket as _objects_).

{% endnote %}