# Where to see consumption costs for individual resources?

## Issue description {#case-description}

You need to find out the funds you spent on a certain resource (for example, a VM instance) during a month, day, or another period.

## Solution {#case-resolution}

For your analytical tasks, you can build a [dashboard in Yandex DataLens](../../../billing/operations/dashboard.md).

1. Go to [Yandex DataLens](https://datalens.yandex.ru/connections).
2. Click **"Create connection"**.
3. Select the **Yandex Cloud Billing** connector.
4. Name the connection. You can set any name.
5. Select **Yandex Cloud Billing Dashboard**.
6. Click the **Resources** tab.
7. Click **...** to the right of the **Resource total cost** table name and select **Edit**.
8. In the filters, select **Resource ID** with the **Belongs to a set** operation.
9. In the **Available** field, specify the IDs of filtered resources (they will be shown in the column on the right).
10. Click **Apply filter**. In the **Cost** column, you will see the amounts of funds spent on specific IDs.

You can find out the resource IDs in the management console. You can also export all resource IDs via the [YC CLI](../../../cli/quickstart.md).