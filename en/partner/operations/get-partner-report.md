---
title: Exporting spending details for a partner account and subaccounts
description: Follow this guide to get a CSV file with spending details for a partner account and subaccounts.
---

# Exporting spending details for a partner account and subaccounts

You can get a CSV file with spending details for a partner account and subaccounts. You can either [download](#single-time-download) the file once or [set up](#set-up-regular-download) its regular export.

## One-time export {#single-time-download}

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![image](../../_assets/console-icons/scales-balanced.svg) **Finance**.
  1. Go to the ![image](../../_assets/console-icons/chart-column.svg) **Subaccount details** tab.
  1. Click **Export as CSV** at the top right.
  1. Select the time period to get the details for.
  1. Click **Download**.

{% endlist %}

{% note info %}

A single CSV export disregards the current filter settings in the details. It covers the entire consumption for the specified period.

{% endnote %}

## Setting up regular export {#set-up-regular-download}

### Getting started {#before-you-begin}

1. If you do not have any [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md). In the folder name, specify the project or client to use the folder.

1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-full-name }}. {{ yandex-cloud }} will save the files with details to this bucket. You can save your details in multiple buckets.

    {% note alert %}
    
    {% include [billing-partner-bucket-alert](../../_includes/billing-partner-bucket-alert.md) %}

    You pay for the size of the detail files stored in {{ objstorage-full-name }} as per the relevant [pricing policy](../../storage/pricing.md).

    {% endnote %}

1. Make sure you have one of the following roles: `billing.accounts.owner`, `billing.accounts.admin`, `billing.accounts.editor`, `billing.accounts.partnerAdmin`.

### Get the expense details {#download-detail}

{% list tabs group=instructions %}

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![image](../../_assets/console-icons/scales-balanced.svg) **Finance**.
  1. Go to the ![image](../../_assets/console-icons/chart-column.svg) **Subaccount details** tab.
  1. At the top right, click **Create regular export**.
  1. In the **Create regular export** window that opens:
     * In the **Bucket** field, enter the name of the bucket to store the CSV file with details.
     * In the **Path within the bucket** field, enter the directory name for the file. It must end with the `/` character.
     * In the **Language** field, select the file language.
     * In the **Details** field, select the type of details: `General` or `Resource`.

         {% note tip %}

         If you select `Resource` for regular export of details, the [`resource_id`](#format) field will allow you to view, among others, the {{ datalens-full-name }}, {{ tracker-full-name }}, and {{ ml-platform-name }} resources  (e.g., [{{ ml-platform-name }} community](../../datasphere/concepts/community.md) IDs).

         {% endnote %}

  1. Optionally, to export data for the previous period, enable the relevant option. In the **Export reports starting from** field that appears, select the start date for exporting reports.
  1. Click **Create**.

{% endlist %}

{% include [billing-partner-detalization-file-info](../../_includes/billing-partner-detalization-file-info.md) %}

## Expense details file format {#format}

An uploaded file with details is a CSV table with comma-separated columns. Each row shows the product consumption level per day for the specified folder.

{% note info %}

The export contains data both for subaccounts and the current partner account.

{% endnote %}

The table contains the following columns:

* `billing_account_id`: [Billing account](../../billing/concepts/billing-account.md) and subaccount ID.
* `billing_account_id`: [Billing account](../../billing/concepts/billing-account.md) and subaccount name.
* `cloud_id`: ID of the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) covered by the details.
* `cloud_name`: Cloud name.
* `folder_id`: Folder ID.
* `folder_name`: Name of the folder at the time of exporting the details. This field may be empty if you deleted the folder before exporting the details.
* `resource_id`: Resource ID, resource name, or subscription ID. Use only for regular export. The value of this field may be empty if the use of the service refers to the entire folder or it does not contain any resources. The services and `resource_id` column values are mapped as follows:
   * {{ compute-name }} and {{ marketplace-name }}: ID of the VM, disk snapshot, disk image, or other resource installed using {{ marketplace-name }}.
   * {{ objstorage-name }}: Bucket name.
   * {{ vpc-name }}: ID of the resource that processes incoming or outgoing traffic.
   * {{ kms-short-name }}: Key ID.
   * {{ network-load-balancer-name }}: Load balancer ID.
   * {{ container-registry-short-name }}: Container ID.
   * {{ k8s }} and {{ dataproc-name }}: Cluster ID.
   * {{ mpg-short-name }}, {{ mch-short-name }}, {{ mmg-short-name }}, {{ mmy-short-name }}, {{ mrd-short-name }}, and {{ mkf-name }}: Host ID in the cluster.
   * {{ message-queue-name }}: Request ID.
   * {{ sf-name }}: Function ID.
   * {{ monitoring-short-name }}, {{ iot-name }}, {{ speechkit-short-name }}, {{ translate-name }}, and {{ vision-short-name }}: Empty value.
   * {{ datalens-short-name }}: {{ datalens-short-name }} instance ID.
   * Technical support: Subscription ID.
* `service_id`: ID of the service the consumed product belongs to.
* `service_name`: Name of the service the consumed product belongs to.
* `sku_id`: Consumed product ID.
* `sku_name`: Product name.
* `date`: Consumption charge date. A date is set as an interval from 0:00 to 23:59 (UTC+3).
* `currency`: Billing account currency. Possible values: `RUB`, `USD`, and `KZT`.
* `pricing_quantity`: Number of product units consumed. The decimal separator is a period.
* `pricing_unit`: Product consumption unit.
* `cost`: Total cost of consumption. The decimal separator is a period.
* `credit`: Total discounts. Not included in the total cost of consumption (`credit`). Always negative. The decimal separator is a period.
* `monetary_grant_credit`: Grant discount, including the platform introduction grant. The decimal separator is a period.
* `volume_incentive_credit`: Consumption volume discount. The decimal separator is a period.
* `cud_credit`: Discount for the [committed](../../billing/concepts/cvos.md) resource volume. The cost of the consumption volume above the committed one equals the sum of the `cost` and `credit` column values. The decimal separator is a period.
* `misc_credit`: Other types of discounts, including discounts for consumption after the platform introduction grant expires but before switching to the paid version. The decimal separator is a period.
* `reward`: Partner discount amount. The decimal separator is a period.
* `label.user_labels.<label_name>`: Labels added to the resources. For information about how to manage labels, see [{#T}](../../resource-manager/operations/manage-labels.md).
* `locale`: Language of each exported line. This field's value determines the `sku_name` column language. The possible values are `en` and `ru`.
* `updated_at`: Date and time of the last line update in [Unix Timestamp](https://www.unixtimestamp.com) format.
* `exported_at`: Date and time when the line was added to the details file.

{% note info %}

Exports made before January 17, 2026 do not contain partner premium data (`reward`).

{% endnote %}


##### See also {#see-also}

* [{#T}](./get-client-stat.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
