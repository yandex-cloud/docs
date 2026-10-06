You can assign the `datalens.collections.viewer` role to a collection. It allows you to view the info on it and its nested collections and workbooks, as well as view all nested workbook objects. In the {{ datalens-name }} UI, this role is referred to as `Viewer`. You may want to only assign this role through the {{ datalens-name }} UI.

Users with this role can:


* View info on the relevant collection and its nested [workbooks and collections]({{ link-datalens-docs }}/workbooks-collections/).
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.
* View all nested [objects]({{ link-datalens-docs }}/concepts/) of the workbooks related to the appropriate collection and its nested collections.


This role includes the `datalens.collections.limitedViewer` and `datalens.workbooks.viewer` permissions.
