### Why does a permission error occur? {#permission-error}

Check that the user has been granted rights:
* To the {{ datalens-short-name }} `datalens.instances.user` or `datalens.instances.admin  instance`.
* To the dashboard and all related objects (connection, chart, and dataset):
   * To view the dashboard and related charts.
   * To execute all datasets and connections associated with the dashboard.

By setting up [dashboard permissions](../../datalens/operations/dashboard/manage-access.md) you can assign permissions to all related objects.

To assign permissions to all of your users, use the **All** group. For federated users, you can grant access only to the **All** group.

For more information about permissions to {{ datalens-short-name }} objects, see the [documentation](../../datalens/security/index.md#permissions).



