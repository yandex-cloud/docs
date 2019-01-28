# Assign a role to a service account

This section describes how to assign a [role](../../concepts/access-control/roles.md)  to a service account for a resource. To assign another user a role to a [service account](../../concepts/users/service-accounts.md) as a resource, follow the instructions in [[!TITLE]](set-access-bindings.md).

In the management console you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

---

**[!TAB Management console]**

To assign a role for the folder where  the service account was created:

[!INCLUDE [grant-role-console-sa](../../../_includes/grant-role-console-sa.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

To assign the service account a role for a resource, run:

```
yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
    --role <ROLE-ID> \
    --subject serviceAccount:<SERVICE-ACCOUNT-ID>
```

where:

* `<SERVICE-NAME>` is the name of the service that the resource belongs to (for example, `resource-manager`).
* `<RESOURCE>` resource category, for example `cloud`.
* `<RESOURCE-NAME>` is the resource name. You can specify a resource by its name or identifier.
* `<RESOURCE-ID>` is the resource identifier.
* `<ROLE-ID>` is the identifier of the role (for example, `[!KEYREF roles-cloud-owner]`).
* `<SERVICE-ACCOUNT-ID>` is the identifier of the service account assigned the role.

For example, to assign the `viewer` role to a service account for a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) `mycloud`:

1. Select a service account (for example, `my-robot`):

    ```
    $ yc iam service-account list
    +----------------------+------------------+-------------------------------+
    |          ID          |       NAME       |          DESCRIPTION          |
    +----------------------+------------------+-------------------------------+
    | aje6o61dvog2h6g9a33s | my-robot         |                               |
    | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
    +----------------------+------------------+-------------------------------+
    ```

1. Assign a role to the `my-robot` service account using its ID:

    ```
    $ yc resource-manager cloud add-access-binding mycloud \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2h6g9a33s
    ```

**[!TAB API]**

To assign a role for the resource to the service account, use the `setAccessBindings` method for the resource that the role applies to.

---

#### What's next

- [[!TITLE]](create-access-key.md)
- [[!TITLE]](set-access-bindings.md)

