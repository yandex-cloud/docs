{% note info %}

A service account is only allowed to view a list of buckets in the folder it was created in.

A service account can perform actions with objects in buckets that are created in folders different from the service account folder. To enable this, [assign](../../iam/operations/sa/assign-role-for-sa.md) the service account [roles](../../storage/security/index.md#service-roles) for the appropriate folder or its bucket.

{% endnote %}