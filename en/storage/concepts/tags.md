# Labels

A _label_ is a key-value pair used for logical bucket and object labeling.

{% include [labels-tags](../../_includes/storage/labels-tags.md) %}

## Bucket labels {#bucket-tags}

Buckets support {{ resmgr-full-name }} [labels](../../resource-manager/concepts/labels.md).


You can view spending details for buckets or other resources of {{ yandex-cloud }} [services](../../resource-manager/concepts/labels.md#services) marked with a specific label. For example, using labels, you can view expenses for a particular project or corporate department.

You can view expenses for the labeled resources in a CSV [file with usage details](../../billing/operations/get-folder-report.md#format) and on the [{{ datalens-full-name }} dashboard](../../billing/operations/dashboard.md).


{% include [tags-restrictions](../../_includes/tags-restrictions.md) %}

* Labels prefixed with `aws:` in the key are reserved for {{ objstorage-name }}. These labels are not counted in the total number of bucket labels. You cannot delete or modify them.

## Object labels {#object-tags}

You can work with object labels in the [management console]({{ link-console-main }}) as well as in the [YC CLI](../../cli/quickstart.md), [AWS CLI](../tools/aws-cli.md), [{{ TF }}]({{ tf-provider-resources-link }}/storage_bucket), and [S3 API](../s3/index.md).

Object label operation limits are as follows:

* Maximum number of labels per object: 10.
* Label key parameters:
  * Up to 128 characters long.
  * May contain Latin letters, numbers, spaces, and these characters: `+`, `-`, `=`, `.`, `_`, `:`, `/`, and `@`.
* Label value parameters:
  * Up to 256 characters long.
  * May contain Latin letters, numbers, spaces, and these characters: `+`, `-`, `=`, `.`, `_`, `:`, `/`, and `@`.
* Labels prefixed with `aws:` in the key are reserved for {{ objstorage-name }}. These labels are not counted in the total number of object labels. You cannot delete or modify them.

#### See also {#see-also}

* [{#T}](../operations/buckets/tagging.md)
* [{#T}](../operations/objects/tagging.md)
