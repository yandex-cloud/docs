# Get expense details by folder

You can get a CSV file with your general or per-resource spending details.

## Before you start {#before-you-begin}

1. If you do not have any [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create a folder](../../resource-manager/operations/folder/create.md). In the folder name, specify the name of the project or client that is going to use this folder.
1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-full-name }}. {{ yandex-cloud }} will save detail files to this bucket. You can save details in multiple buckets.

   {% note alert %}

   Don't make your bucket public, otherwise anyone can download your expense details from the bucket link.

   {% endnote %}

1. Make sure you have one of the following roles: `billing.accounts.owner`, `billing.accounts.admin`, `billing.accounts.editor`.

## Get expense details {#download-detail}

{% list tabs %}

- Management console

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
   1. In the upper-left corner, click ![image](../../_assets/main-menu.svg) **All services**.
   1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).
   1. Select the account you want to get details for.
   1. On the **Overview** page, go to the **Export details** tab.
   1. Click **Create**.
   1. In the **Create periodic export** window that opens, enter:
      * In the **Bucket** field, the name of the bucket to store the CSV file with details.
      * In the **Directory** field, the name of the directory for the file. The last character must be `/`.
      * Select the language for product names: English or Russian. 
      * Select the type of details: **General** or **Resource**.
   1. Click **Create**.

{% endlist %}

A new file with details is created in the bucket daily. The file name contains the prefix and date that details are collected for. The file is overwritten and updated with new data every hour.

The information can be updated in any daily file within a month.

{% note tip %}

Files with details from buckets aren't deleted automatically, but you can set up a deletion schedule. For more information, see [Object lifecycle](../../storage/concepts/lifecycles.md) ({{ objstorage-name }} refers to files in a bucket as _objects_).

{% endnote %}

## Expense details file format {#format}

An uploaded file with details is a CSV table with comma-separated columns. Each row shows the product consumption level per day for the specified folder.

The table contains the following columns:

* `billing_account_id`: [Billing account](../concepts/billing-account) ID.
* `billing_account_name`: Name of the billing account.
* `cloud_id`: ID of the [cloud](../../resource-manager/concepts/resources-hierarchy#cloud) that details are provided for.
* `cloud_name`: Name of the cloud.
* `folder_id`: ID of the folder.
* `folder_name`: Name of the folder at the time of exporting details. This field value may be empty if you deleted the folder before exporting the details.
* `resource_id`: Resource ID, resource name, or subscription ID. The value of this field may be empty if the use of the service refers to the entire folder or it doesn't contain any resources. Correlation between services and `resource_id` column values:
   * {{ compute-name }} and {{ marketplace-name }}: ID of the VM, disk snapshot, disk image, or other resource installed using {{ marketplace-name }}.
   * {{ objstorage-name }}: Name of the bucket.
   * {{ vpc-name }}: ID of the resource that processes incoming or outgoing traffic.
   * {{ kms-short-name }}: ID of the key.
   * {{ network-load-balancer-name }}: ID of the network load balancer.
   * {{ container-registry-name }}: ID of the container.
   * {{ k8s }} and {{ dataproc-name }}: ID of the cluster.
   * {{ mpg-short-name }}, {{ mch-short-name }}, {{ mmg-short-name }}, {{ mmy-short-name }}, {{ mrd-short-name }} and {{ mkf-name }} — ID of the cluster host.
   * {{ message-queue-name }} : ID of the request.
   * {{ sf-name }} : ID of the function.
   * {{ monitoring-short-name }}, {{ datalens-short-name }}, {{ iot-name }}, {{ speechkit-short-name }}, {{ translate-name }} and {{ vision-short-name }} : An empty value.
   * Technical support: ID of the subscription.
* `service_id`: ID of the service that the consumed product belongs to.
* `service_name`: Name of the service that the consumed product belongs to.
* `sku_id`: ID of the consumed product.
* `sku_name`: Name of the product.
* `date`: Date that the cost of consumption is charged for.
* `currency`: Billing account currency. Possible values: `RUB`, `USD`, and `KZT`.
* `pricing_quantity`: Amount of product units consumed. The decimal separator is a dot.
* `pricing_unit`: Unit of product consumption.
* `cost`: Total cost of consumption. The decimal separator is a dot.
* `credit`: Discount amount. The decimal separator is a dot. 
* `monetary_grant_credit`: Discount from a grant, including the grant for trying the platform. The decimal separator is a dot. 
* `volume_incentive_credit`: Discount for the volume of product consumption. The decimal separator is a dot. 
* `cud_credit`: Discount for the [committed volume](../concepts/cvos.md) of the resource. The cost of consumption in excess of the commitment equals the difference between the `cost` and `credit` column values. The decimal separator is a dot.
* `misc_credit`: Other types of discounts, including discounts for resource consumption after the grant for trying the platform expires, but before switching to the paid version. The decimal separator is a dot. 
* `label.user_labels.<label name>`: Labels set for resources. How to manage tags is described in [Service resource labels](../../overview/concepts/services.md#labels).
* `locale`: Language of each exported line. The value of this field determines the `sku_name` column language. Possible values are `en` and `ru`.
* `updated_at`: Date and time of the last line update in [Unix Timestamp](https://www.unixtimestamp.com) format.
* `exported_at`: Date and time when the line was added to the detail file.


{% cut "Deprecated parameters" %}

* `created_at`: Date and time when the specified cost of consumption was charged. In [Unix Timestamp](https://www.unixtimestamp.com) format.
* `label.system_labels.folder_id`: ID of the folder. The value is now displayed in the `folder_id` column.

{% endcut %}


##### See also

* [View usage details for the cloud](check-charges.md)