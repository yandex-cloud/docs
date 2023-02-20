# Getting expense details by folder

Getting expense details by folder is currently in the testing phase.

## Before you begin

If you don't have any folders yet, you can create a folder using the [instructions](../resource-manager/operations/folder/create.md). In the folder name, we recommend specifying the name of the project or client that uses this folder. We recommend adding clear names to the folder name, like the project you're working on or the client that uses the folder.

## Get expense details

To get expense details by folder:

1. [Create a bucket](../storage/operations/buckets/create.md) in {{ objstorage-name }}. {{ yandex-cloud }} will save detail files to this bucket. You can save details in multiple buckets.

   {% note alert %}

   Don't make your bucket public, otherwise anyone can download your expense details from the bucket link.

   {% endnote %}

1. Open the bucket in the management console and copy the link to it from the address bar. The link to the bucket has the following format:

   ```
   {{ link-console-main }}/folders/<FOLDER-ID/storage/bucket/<BUCKET-NAME>
   ```
1. Send an email to your account manager or the [support team]({{ link-console-support }}/create-ticket) with a request for adding billing details by folder and specify:
   * Link to one or more buckets.
   * Prefix that a group of files with expense details should have.

     If you want to save multiple groups of detail files in a single bucket, specify a unique prefix for each group. For example, for a group of files with details by resource, you can use a prefix like `yc-billing-export-with-resources` and for a group of files without resource details — `yc-billing-export`.
   * Language to display product names in. Possible values: English or Russian.
   * Indicate whether you need details by resource.

     If yes, a column named `resource_id` appears in the table. You can get resource details starting from August 1, 2020. No information is provided for earlier periods.
1. Wait for a message saying that the bucket is activated. The support team activates the bucket within a day.
1. Download CSV files with details from the bucket.

   A new file with details is created in the bucket daily. The file name contains the prefix and date that details are collected for. The file is overwritten and updated with new data every hour.

{% note tip %}

Files with details from buckets aren't deleted automatically, but you can set up a deletion schedule. For more information, see [Object lifecycle](../storage/concepts/lifecycles.md) ({{ objstorage-name }} refers to files in a bucket as _objects_).

{% endnote %}

## Expense details file format {#format}

An uploaded file with details is a CSV table with comma-separated columns. Each row shows the product consumption level per day for the specified folder.

The table contains the following columns:

* `billing_account_id`: [Billing account](../billing/concepts/billing-account.md) ID.
* `billing_account_name`: Name of the billing account.
* `cloud_id`: ID of the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) that details are provided for.
* `cloud_name`: Name of the cloud.
* `folder_id`: ID of the folder.
* `folder_name`: Name of the folder at the time of exporting details.
* `resource_id`: Resource ID, resource name, or subscription ID. The value of this field may be empty if the use of the service refers to the entire folder or it doesn't contain any resources. Correlation between services and `resource_id` column values:
   * {{ compute-name }} and {{ marketplace-name }}: ID of the VM, disk snapshot, disk image, or other resource installed using {{ marketplace-name }}.
   * {{ objstorage-name }}: Name of the bucket.
   * {{ vpc-name }}: ID of the resource that processes incoming or outgoing traffic.
   * {{ kms-short-name }}: ID of the key.
   * {{ network-load-balancer-name }}: ID of the network load balancer.
   * {{ container-registry-short-name }}: ID of the container.
   * {{ k8s }} and {{ dataproc-name }}: ID of the cluster.
   * {{ mpg-short-name }}, {{ mch-short-name }}, {{ mmg-short-name }}, {{ mmy-short-name }}, {{ mrd-short-name }}, and {{ mkf-name }}: ID of the cluster host.
   * {{ message-queue-name }}: ID of the request.
   * {{ sf-name }}: ID of the function.
   * {{ monitoring-short-name }}, {{ datalens-short-name }}, {{ iot-name }}, {{ speechkit-short-name }}, {{ translate-name }}, and {{ vision-short-name }}: An empty value.
   * Technical support: ID of the subscription.
* `service_id`: ID of the service that the consumed product belongs to.
* `service_name`: Name of the service that the consumed product belongs to.
* `sku_id`: ID of the consumed product.
* `sku_name`: Name of the product.
* `date`: Date that the cost of consumption is charged for.
* `currency`: Billing account currency. Possible values: `RUB` and `USD`.
* `pricing_quantity`: Amount of product units consumed. The decimal separator is a dot.
* `pricing_unit`: Unit of product consumption.
* `cost`: Total cost of consumption. The decimal separator is a dot.
* `credit`: Discount amount. The decimal separator is a dot.
* `monetary_grant_credit`: Discount from a grant, including the grant for trying the platform. The decimal separator is a dot.
* `volume_incentive_credit`: Discount for the volume of product consumption. For example, for consuming 5% vCPU. The decimal separator is a dot.
* `cud_credit`: Discount for a fixed resource consumption volume. The cost of consumption over the fixed volume is equal to the difference between the `cost` and `credit` column values. The decimal separator is a dot.
* `misc_credit`: Other types of discounts, including discounts for resource consumption after the grant for trying the platform expires, but before switching to the paid version. The decimal separator is a dot.
* `label.user_labels.<label name>`: Labels set for resources. For information about how to manage labels, see [{#T}](label-management.md).
* `locale`: Language of each exported line. The value of this field determines the `sku_name` column language. Possible values: `en` and `ru`.
* `updated_at`: Date and time of the last line update in [Unix Timestamp](https://www.unixtimestamp.com) format.
* `exported_at`: Date and time when the line was added to the detail file.

{% cut "Deprecated parameters" %}

* `created_at`: Date and time when the specified cost of consumption was charged. In [Unix Timestamp](https://www.unixtimestamp.com) format.
* `label.system_labels.folder_id`: ID of the folder. The value is now displayed in the `folder_id` column.

{% endcut %}

##### See also

* [View usage details for the cloud](../billing/operations/check-charges.md)
* [Billing documentation in {{ yandex-cloud }}](../billing/)
