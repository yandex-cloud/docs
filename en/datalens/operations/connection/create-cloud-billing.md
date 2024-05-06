# Creating a {{ yandex-cloud }} Billing connection

You can only access statistics in the billing accounts where you have the `{{ roles-viewer }}`, `{{ roles-editor }}`, or `{{ roles-admin }}` role. For more information, refer to [Access management](../../../billing/security/index.md#primitive-roles).
Access to a billing account is granted to a user or service account [on the list of users](../../../billing/security/index.md#set-member-role) of the selected account. For more information, refer to the [detailed guide](../../../billing/security/index.md#set-role).

To create a {{ yandex-cloud }} Billing connection:

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.
1. Select a **{{ yandex-cloud }} Billing** connection.
1. Select **Automatically create a dashboard, charts, and a dataset on the connection** if you want to get a ready-to-use {{ yandex-cloud }} Billing Dashboard with a dataset and a set of charts.
1. Click **Create connection**. If you use a new {{ datalens-short-name }} object model with [workbooks and collections](../../../datalens/workbooks-collections/index.md), select or create a workbook to save the connection to.
1. Enter the connection name and click **Create**.