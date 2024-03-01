### Error creating or editing a managed database endpoint {#required-roles}

Error message:

```text
Can't authorize usage of managed <DB_type>, you need permission <get-MDB_permission> to <cluster_folder_ID> folder
```

To create or edit an endpoint of a managed database, you need the service or primitive [`viewer` role](../../../iam/roles-reference.md#viewer) assigned for the folder hosting a cluster of this managed database.


**Solution:**

[Get](../../../iam/operations/roles/grant.md) a service or primitive `viewer` role to work with the cluster.