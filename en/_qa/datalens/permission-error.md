### Why does a permission error occur? {#permission-error}

Check that the user has the following permissions:
* For the {{ datalens-short-name }} instance:`datalens.instances.user` or `datalens.instances.admin`.
* For the dashboard and all related objects (connection, chart, and dataset):
  * Permission to view the dashboard and related charts.
  * Permission to execute all datasets and connections associated with the dashboard.

By setting up [dashboard permissions](../../datalens/operations/dashboard/manage-access.md) you can assign permissions to all related objects.

To assign permissions to all your users, use the **All** group. For federated users, you can grant access only to the **All** group.

For more information about permissions to {{ datalens-short-name }} objects, see the [documentation](../../datalens/security/index.md).
