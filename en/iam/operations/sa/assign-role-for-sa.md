# Assign role to service account

This section describes how to assign a [role](../../concepts/access-control/roles.md)  to a service account for a resource. To assign a role for a [service account](../../concepts/users/service-accounts.md) as a resource, follow the instructions [[!TITLE]](set-access-bindings.md).

In the management console you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

---

**[!TAB Management console]**

To assign a role for the folder where  the service account was created:

1. Select the folder.
2. Select the **Service accounts**  tab.
3. Click ![](../../../_assets/dots.png) next to the service account and select **Edit service account**.
4. Click **Add role** and select a role.
5. Click **Save**.

**[!TAB CLI]**

To assign the service account a role for a resource, run:

```
yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
    --role <ROLE-ID> \
    --subject serviceAccount:<SERVICE-ACCOUNT-ID>
```

where:

* `<SERVICE-NAME>` is the name of the service that the resource belongs to (for example, `resource-manager`).
* `<RESOURCE>` is the resource category (for example, `cloud`).
* `<RESOURCE-NAME>` is the resource name. You can specify a resource by its name or identifier.
* `<RESOURCE-ID>` is the resource identifier.
* `<ROLE-ID>` is the identifier of the role (for example, `[!KEYREF roles-cloud-owner]`).
* `<SERVICE-ACCOUNT-ID>` is the identifier of the service account assigned the role.

For example, assign the `viewer` role to the service account for the `mycloud` cloud:

```
yc resource-manager cloud add-access-binding mycloud \
    --role viewer \
    --subject serviceAccount:ajeptmgeb3f2q56bifci
```

**[!TAB API]**

To assign a role for the resource to the service account, use the `SetAccessBindings` method for the resource that the role applies to.

---

