You can assign the `datalens.collections.admin` role to a collection. It allows you to manage the relevant collection and access to it, as well as all its nested collections, workbooks, and all objects within such workbooks. In the DataLens UI, this role is referred to as `Admin`. You may want to only assign this role through the DataLens UI.

Users with this role can:
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the appropriate collection and for its nested [collections and workbooks](../../../datalens/workbooks-collections/index.md), as well as modify such access permissions.
* View info on the relevant collection and its nested collections and workbooks.
* Edit the relevant collection and all its nested collections and workbooks, as well as create copies of it.
* Move and delete the relevant collection and all its nested collections and workbooks.
* Create new collections and workbooks within the relevant collection.
* View and edit all nested [objects](../../../datalens/concepts/index.md#component-interrelation) of the workbooks related to the appropriate collection and its nested collections.
* [Embed](../../../datalens/security/private-embedded-objects.md) the private objects nested into workbooks related to the relevant collection and its nested ones, to websites and apps.
* [Publish](../../../datalens/concepts/datalens-public.md#how-to-publish) the objects nested into the workbooks related to the appropriate collection and its nested collections.

This role includes the `datalens.collections.editor` and `datalens.workbooks.admin` permissions.
