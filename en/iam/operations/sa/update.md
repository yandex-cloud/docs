# Edit service account

To change the description of a [service account](../../concepts/users/service-accounts.md), use the CLI or API. The management console only allows you to change the name of the service account at this time.

You can use the management console to immediately add or remove [roles](../../concepts/access-control/roles.md) of a service account for the folder it belongs to. To assign a role for another resource to a service account, use the CLI or API following the instructions [[!TITLE]](assign-role-for-sa.md).

---

**[!TAB Management console]**

1. Select the folder.
2. Select the **Service accounts**  tab.
3. Click ![](../../../_assets/dots.png) next to the service account and select **Edit service account**.
4. Change the name of your service account.
5. Add or remove roles assigned to the service account. The roles will be assigned for the folder where the service account was created.
6. Click **Save**.

**[!TAB CLI]**

Edit a service account in your default folder:

```
yc iam service-account update <SERVICE-ACCOUNT-NAME>|<SERVICE-ACCOUNT-ID> \
    [--new-name <NEW-NAME>] \
    [--description <NEW-DESCRIPTION>] \
```

where:

* `<SERVICE-ACCOUNT-NAME>` is the name of the service account you want to change. You can enter a service account by its name or identifier.

* `<SERVICE-ACCOUNT-ID>` is the service account identifier.

* `<NEW-NAME>` is the new name of the service account.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

* `<NEW-DESCRIPTION>` is the new description of the service account.

For example, you can rename a service account:

```
yc iam service-account update old-name \
    --new-name new-name
```

If the service account belongs to a different folder, you can specify the folder using the `--folder-id` or `folder-name` flags:

```
yc iam service-account update old-name \
    --new-name new-name \
    --folder-name yet-another-folder
```

**[!TAB API]**

To edit the service account, use the `Update` method for the `ServiceAccount` resource.

---

