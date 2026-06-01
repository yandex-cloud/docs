The `datalens.collections.admin` role is assigned for a collection and enables managing this collection and access to it, as well as all its nested collections, workbooks, and all objects within such workbooks. In the {{ datalens-name }} UI, this role is referred to as `Admin`. We recommend assigning this role only via the {{ datalens-name }} UI.

Users with this role can:
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection and for its nested [collections and workbooks](../../../datalens/workbooks-collections/index.md), as well as modify such access permissions.
* View info on the appropriate collection and its nested collections and workbooks.
* Edit the appropriate collection and all its nested collections and workbooks.
* Create copies of the appropriate collection's nested workbooks.
* Move and delete the relevant collection and all its nested collections and workbooks.
* Create new collections and workbooks within the relevant collection.
* View and edit all nested [objects](../../../datalens/concepts/index.md#component-interrelation) of the workbooks pertaining to the appropriate collection and its nested collections.
* [Embed](../../../datalens/security/private-embedded-objects.md) private objects nested into workbooks related to the relevant collection and its nested ones, to websites and apps.
* [Publish](../../../datalens/concepts/datalens-public.md#how-to-publish) objects nested into the workbooks related to the appropriate collection and its nested collections.

This role includes the `datalens.collections.editor` and `datalens.workbooks.admin` permissions.
