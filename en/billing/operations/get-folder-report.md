# Exporting extended usage details

You can get a CSV file with your general or per-resource spending details. You can either [download](#single-time-download) the file once or [set up](#regular-download) its regular export.

## One-time export {#single-time-download}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want the details for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
  1. At the top right, click **More** and select **{{ ui-key.yacloud_org.billing.account.detail.button_download-details }}**.
  1. In the window that opens, select:
     * Export file format: `CSV` or `PDF`.
     * Time period you want the details for.
     * Display language for product names: `{{ ui-key.yacloud_org.billing.account.exports.locale_value_ru-lang }}` or `{{ ui-key.yacloud_org.billing.account.exports.locale_value_en-lang }}`.
     * Detailed view type: `{{ ui-key.yacloud_billing.billing.account.exports.label_not-include-resources }}` or `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}`.
  1. Click **{{ ui-key.yacloud_org.billing.account.detail.popup-export_button_download }}**.

{% endlist %}

## Regular export {#regular-download}

### Getting started {#before-you-begin}

1. If you do not have any [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md). In the folder name, specify the project or client to use the folder.

1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-full-name }}. {{ yandex-cloud }} will save the files with details to this bucket. You can save your details in multiple buckets.

    {% note alert %}
    
    {% include [billing-partner-bucket-alert](../../_includes/billing-partner-bucket-alert.md) %}

    {% endnote %}

1. Optionally, for additional details protection, set up [bucket encryption](../../storage/operations/buckets/encrypt.md).
   To export details to an encrypted bucket, you need a service account that will be handling the export. To manage this service account, the billing account needs the `iam.serviceAccounts.user` role.

1. Verify that your billing account has the roles required for operations involving regular exports.
   To create, stop, or resume regular exports, the user needs one of the following roles:
     * `billing.accounts.editor`
     * `billing.accounts.accountant`
     * `billing.accounts.varWithoutDiscounts`
   
   To view regular exports, the user needs one of the following roles:
     * `billing.accounts.viewer`
     * `billing.accounts.varWithoutDiscount`
  
  For more information, see [Service roles in {{ billing-name }}](../../billing/security/index.md).

### Setting up a regular export {#set-up-regular-download}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want the details for.
  1. Go to the regular export setting:
   
      {% list tabs %}

       - {{ ui-key.yacloud_billing.billing.account.switch_detail }} section
  
         1. In the left-hand panel, select ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
         1. At the top right, click **More** and select **{{ ui-key.yacloud_org.billing.account.detail.button_create-periodic-export }}**.

      - {{ ui-key.yacloud_billing.billing.account.switch_exports }} section

          1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
          1. Click **{{ ui-key.yacloud_billing.billing.account.exports.button_create-periodic-export }}**.

      {% endlist %}

  1. In the window that opens, specify the following:
     * Name of the bucket to store the CSV file with details.
     * If selecting an encrypted bucket, specify an existing service account or create a new one:
  
        {% list tabs %}

          - Existing account
  
              1. In the **{{ ui-key.yacloud_org.billing.account.exports.column_service_account }}** field, specify the service account.
              1. When you see a message about missing roles, click **{{ ui-key.yacloud_org.billing.providers.button_ca-roles-update }}** and wait for a message saying they were successfully added.

          - New account

              1. In the **{{ ui-key.yacloud_org.billing.account.exports.column_service_account }}** field, click **{{ ui-key.yacloud_org.billing.exports.ServiceAccountAddField.addNewServiceAccount  }}**.
              1. Enter a name for the service account.
              1. Click **{{ ui-key.yacloud_org.iam.folder.service-account.popup-robot_button_save }}**.

          {% endlist %}

      {% note info %}

       One service account can handle multiple regular exports. However, [roles](#before-you-begin) must be assigned separately for each encrypted bucket and KMS key.

      {% endnote %}

     * Name of the details file folder. Make sure the last character is `/`.
     * Display language for product names: `{{ ui-key.yacloud_org.billing.account.exports.locale_value_ru-lang }}` or `{{ ui-key.yacloud_org.billing.account.exports.locale_value_en-lang }}`.
     * Detailed view type: `{{ ui-key.yacloud_billing.billing.account.exports.label_not-include-resources }}` or `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}`.

         {% note tip %}

         If you select `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}` for a regular export of details, the [`resource_id`](#format) field will allow you to view the {{ datalens-full-name }}, {{ tracker-full-name }}, and {{ ml-platform-name }} resources (e.g., [{{ ml-platform-name }} community IDs](../../datasphere/concepts/community.md)).

         {% endnote %}

  1. Optionally, to add data for a previous period, enable **{{ ui-key.yacloud_org.billing.account.exports.field_period }}**. In the **{{ ui-key.yacloud_org.billing.account.exports.field_date }}** field that appears, select the desired detailed report start date. You can get data starting from the billing account creation date.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [billing-partner-detalization-file-info](../../_includes/billing-partner-detalization-file-info.md) %}

### Stopping a regular export {#stop-export}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want to stop a regular export for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the regular export and select **Delete**.

{% endlist %}

### Resuming a regular export {#recover-export}

You can resume a `Failed` export. Resolve the error and resume the export:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want to resume an export for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the regular export and select **{{ ui-key.yacloud_billing.billing.account.exports.button_resume-export }}**.

{% endlist %}

### Viewing regular exports {#view-export}

You can view all your regular exports and their info: bucket, prefix, type of detail, status, ID, last modified date, and creation date.

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want to view details for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Select the details file.

{% endlist %}

## Expense details file format {#format}

An uploaded file with details is a CSV table with comma-separated columns. Each row shows the product consumption level per day for the specified folder.

The table contains the following columns:

* `billing_account_id`: [Billing account](../concepts/billing-account.md) ID.
* `billing_account_name`: Billing account name.
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
* `cud_credit`: Discount for the [committed](../concepts/cvos.md) resource volume. The cost of the consumption volume above the committed one equals the sum of the `cost` and `credit` column values. The decimal separator is a period.
* `misc_credit`: Other types of discounts, including discounts for consumption after the platform introduction grant expires but before switching to the paid version. The decimal separator is a period.
* `label.user_labels.<label_name>`: Labels added to the resources. For information about how to manage labels, see [{#T}](../../resource-manager/operations/manage-labels.md).
* `locale`: Language of each exported line. This field's value determines the `sku_name` column language. The possible values are `en` and `ru`.
* `updated_at`: Date and time of the last line update in [Unix Timestamp](https://www.unixtimestamp.com) format.
* `exported_at`: Date and time when the line was added to the details file.

{% cut "Deprecated parameters" %}

* `created_at`: Date and time when the specified consumption charge was made, provided in [Unix Timestamp](https://www.unixtimestamp.com) format.
* `label.system_labels.folder_id`: Folder ID. The value is now displayed in the `folder_id` column.

{% endcut %}


##### See also {#see-also}

* [View usage details for the cloud](./check-charges.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
