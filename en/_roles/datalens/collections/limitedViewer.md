You can assign the `datalens.collections.limitedViewer` role to a collection. It allows you to view info on the collection and its nested collections and workbooks, which includes viewing charts, dashboards, and reports of the nested workbooks. In the {{ datalens-name }} UI, this role is referred to as `Limited viewer`. You may want to only assign this role through the {{ datalens-name }} UI.

Users with this role can:


* View info on the relevant collection and its nested [workbooks and collections]({{ link-datalens-docs }}/workbooks-collections/).
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.
* View [charts]({{ link-datalens-docs }}/concepts/chart/), [dashboards]({{ link-datalens-docs }}/concepts/dashboard), and [reports]({{ link-datalens-docs }}/reports/) nested into the workbooks related to the appropriate collection and its nested collections.


This role includes the `datalens.workbooks.limitedViewer` permissions.
