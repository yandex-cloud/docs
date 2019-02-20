In the management console you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

---

**[!TAB Management console]**

To assign a role for the folder where the service account was created:

[!INCLUDE [grant-role-console-sa](../grant-role-console-sa.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../default-catalogue.md)]

To assign the service account a role for a resource, run:

```
yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
    --role <ROLE-ID> \
    --subject serviceAccount:<SERVICE-ACCOUNT-ID>
```

where:

* `<SERVICE-NAME>` is the name of the service that the resource belongs to (for example, `resource-manager`).
* `<RESOURCE>` is the resource category, for example `cloud`.
* `<RESOURCE-NAME>` is the resource name. You can specify a resource by its name or identifier.
* `<RESOURCE-ID>` is the resource identifier.
* `<ROLE-ID>` is the identifier of the role (for example, `[!KEYREF roles-cloud-owner]`).
* `<SERVICE-ACCOUNT-ID>` is the identifier of the service account assigned the role.

For example, to assign the `viewer` role to a service account for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) `my-folder`:

[!INCLUDE [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md)]

**[!TAB API]**

[!INCLUDE [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md)]

---

