The `datalens.collections.editor` role is assigned for a collection and enables managing it and all its nested collections, workbooks, and all objects within such workbooks. In the {{ datalens-name }} UI, this role is referred to as `Editor`. We recommend assigning this role only via the {{ datalens-name }} UI.

Users with this role can:


* View info on the relevant collection and its nested [collections and workbooks]({{ link-datalens-docs }}/workbooks-collections/).
* Edit and delete the appropriate collection and all its nested collections and workbooks.
* Create copies of the appropriate collection's nested workbooks, as well as export such workbooks.
* Create new collections and workbooks within the relevant collection and all its nested ones.
* View and edit all nested [objects]({{ link-datalens-docs }}/concepts/) of the workbooks pertaining to the appropriate collection and its nested collections.
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection, as well as for its nested collections and workbooks.


This role includes the `datalens.collections.viewer` and `datalens.workbooks.editor` permissions.
