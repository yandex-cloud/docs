
You can assign access permissions to users and [user groups](../../organization/operations/create-group.md) for each workbook and collection. [Access permissions](../../datalens/security/roles.md#workbooks-collections-roles) determine what you can do with a workbook or collection. Permissions are inherited as follows:

* Workbook permissions apply to all objects within the workbook.
* Collection permissions apply to all collections and their workbooks, as well as objects within workbooks.

You can grant permissions to individual users or groups of [authenticated](../../iam/concepts/authorization/index.md#authentication) users.

{% note info %}

* You can assign permissions for workbooks and collections to users even if they have yet to accept their [invitation to {{ datalens-short-name }}](../../datalens/security/add-new-user.md).
* Permissions are inherited by all nested objects. You can update the inherited permissions only at the parent object level.

{% endnote %}


