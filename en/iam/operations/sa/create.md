# Create service account

---

**[!TAB Management console]**

1. Select the folder.

2. Select the **Service accounts**  tab.

3. Click **Create service account**.

4. Enter the name of the service account.

5. You can immediately assign the service account the [role](../../concepts/access-control/roles.md) for the folder where it is created.
To do this, click **Add role** and select a role.

    To assign a role for another resource, use the CLI or API following the instructions [[!TITLE]](assign-role-for-sa.md).

6. Click **Add**.

**[!TAB CLI]**

Create a service account in your default folder:

```
yc iam service-account create --name <SERVICE-ACCOUNT-NAME>
```

where:

* `<SERVICE-ACCOUNT-NAME>`  is the name of the service account.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

You can create a service account in another folder using the `-- folder-id` or `folder-name` flags:

```
yc iam service-account create --name my-robot \
    --folder-name yet-another-folder
```

You can add any description to the service account using the `-- description` flag:

```
yc iam service-account create --name my-robot \
    --description "this is my favorite service account"
```

**[!TAB API]**

To create a service account, use the `Create` method for the `ServiceAccount` resource.

---

