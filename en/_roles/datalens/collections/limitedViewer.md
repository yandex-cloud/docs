You can assign the `datalens.collections.limitedViewer` role to a collection. It allows you to view info on the collection and its nested collections and workbooks, which includes viewing charts, dashboards, and reports of the nested workbooks. In the {{ datalens-name }} UI, this role is referred to as `Limited viewer`. You may want to only assign this role through the {{ datalens-name }} UI.

Users with this role can:
* View info on the relevant collection and its nested [workbooks and collections](../../../datalens/workbooks-collections/index.md).
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.
* View [charts](../../../datalens/concepts/chart/index.md), [dashboards](../../../datalens/concepts/dashboard.md), and [reports](../../../datalens/reports/index.md) nested into the workbooks related to the appropriate collection and its nested collections.

This role includes the `datalens.workbooks.limitedViewer` permissions.
