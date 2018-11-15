# Set service account access rights

This section describes how to assign a [role](../../concepts/access-control/roles.md ) for a [ service account](../../concepts/users/service-accounts.md) as a resource. To assign a role for another resource  to the service account, follow the instructions [[!TITLE]](assign-role-for-sa.md).

You can't set service account access rights via the management console. You can [assign a role for a folder](../../../resource-manager/operations/folder/set-access-bindings.md) hosting the service account.

---

**[!TAB CLI]**

Assign the user (subject) a role for the service account in your default folder:

```
yc iam service-account add-access-binding <SERVICE-ACCOUNT-NAME>|<SERVICE-ACCOUNT-ID> \
    --role <ROLE-ID> \
    --subject <SUBJECT-TYPE>:<SUBJECT-ID>
```

where:

* `<SERVICE-ACCOUNT-NAME>`  is the name of the service account the subject is assigned a role for. You can enter a service account by its name or identifier.
* `<SERVICE-ACCOUNT-ID>` is the service account identifier.
* `<ROLE-ID>` is the identifier of the role (for example, `[!KEYREF roles-cloud-owner]`).
* `<SUBJECT-TYPE>` is the type of the subject: `system`, ` userAccount`  or ` serviceAccount`. For more information about subjects, see [[!TITLE]](../../concepts/users/users.md).
* `<SUBJECT-ID>` is the identifier of the subject assigned the role.

For example, assign a user the `editor` role for the `myrobot` service account:

```
yc iam service-account add-access-binding myrobot \
    --role editor \
    --subject userAccount:ajeptmgeb3f2q56bifci
```

If the service account belongs to a different folder, you can specify the folder using the `--folder-id` or `folder-name` flags:

```
yc iam service-account add-access-binding myrobot \
    --role editor \
    --subject userAccount:ajeptmgeb3f2q56bifci \
    --folder-name yet-another-folder
```

**[!TAB API]**

To assign a role for the service account, use the `SetAccessBindings`  method for the `ServiceAccount` resource.

---

