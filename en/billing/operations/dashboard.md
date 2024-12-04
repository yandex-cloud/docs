---
title: View service usage details in {{ datalens-full-name }}
description: Follow this guide to view {{ datalens-name }} service usage details.
---

# View service usage details in {{ datalens-full-name }}


You can view information on your {{ yandex-cloud }} service usage by building a dashboard in {{ datalens-full-name }}.

## Create a connection {#create-connection}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the account you want to get details for.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/chart-area-stacked.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}** and click **{{ ui-key.yacloud_billing.billing.account.detail.button_move-to-datalens }}**.
  1. Click **Create connection**.
  1. In the window that opens, specify the connection name and click **Create**.
  1. Select **{{ yandex-cloud }} Billing Dashboard** in the list.
  1. Go to the **Resources** tab.
  1. In the **Usage date** field, select the period in question. A date is defined as an interval from 0:00 to 23:59 (UTC+3).
  1. Click ![options-grey](../../_assets/console-icons/ellipsis.svg) next to the **Resource total cost** chart and select **Edit**.
  1. In the editor that opens:
      1. Under **Columns**, delete the **Cost** and **Credit** columns.
      1. Under **Filters**, select the **Resouce ID** filter and configure it:
          1. In the **Operation** field, specify **Belongs to a set**.
          1. In the **Available** field, select the IDs of the relevant resources.
          1. Click **Apply filter**.

  As a result, you should see the cost of using resources for the specified period.

{% endlist %}

## Open the dashboard {#open-dashboard}

Go to the **All objects** tab and open the **{{ yandex-cloud }} Billing Dashboard**. You can change the dashboard settings if needed. Learn more about [dashboards](../../datalens/concepts/dashboard.md).

The dashboard is updated with new data regularly. The information for any day can be updated within a month.
