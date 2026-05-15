{% note warning %}

Starting April 20, 2026, you are charged for using S3 Inventory that allows you to export object metadata.

`LIST` and `HEAD` operations run when using S3 Inventory are not charged separately.

You are also charged for `PUT` operations and data storage in the bucket to which metadata is exported.

For more information, see the [{{ objstorage-name }} pricing policy](../../storage/pricing.md).

{% endnote %}