# View service usage details in {{ datalens-full-name }}

You can view information on your {{ yandex-cloud }} service usage by building a dashboard in {{ datalens-full-name }}.

## Create a connection {#create-connection}

{% list tabs %}

- Management console

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. Select the billing account you need from the list.
   1. In the **{{ ui-key.yacloud.billing.account.switch_detail }}** tab, click **{{ ui-key.yacloud.billing.account.detail.button_move-to-datalens }}**.
   1. Click **Create connection**.
   1. In the window that opens, specify the connection name and click **Create**.
   1. Select **{{ yandex-cloud }} Billing Dashboard** in the list.
   1. Click the **Resources** tab.
   1. In the **Usage date** field, select the period in question. Dates are set as a range from 0:00 to 23:59 (UTC+3).
   1. Click ![options-grey](../../_assets/options-grey.svg) next to the **Resource total cost** chart and select **Edit**.
   1. In the editor that opens:
      1. Under **Columns**, delete the **Cost** and **Credit** columns.
      1. Under **Chart filters**, select the **Resouce ID** filter and configure it:
         1. In the **Operation** field, specify **Belongs to a set**.
         1. In the **Available** field, select the IDs of the relevant resources.
         1. Click **Apply**.

   As a result, you should see the cost of using resources for the specified period.

{% endlist %}

## Open the dashboard {#open-dashboard}

Go to the **All objects** tab and open the **{{ yandex-cloud }} Billing Dashboard**. You can change the dashboard settings if needed. Learn more about [dashboards](../../datalens/concepts/dashboard.md).

The dashboard is updated with new data regularly. The information for any day can be updated within a month.
