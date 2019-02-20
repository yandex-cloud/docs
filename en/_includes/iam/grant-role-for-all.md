You can grant access to a resource to all Yandex.Cloud users. To do this, assign a role to the [system group](../../iam/concepts/access-control/system-group.md) `allAuthenticatedUsers`.

Allow any authenticated user to view information about a folder and its resources:

---

**[!TAB CLI]**

Assign the `viewer` for the `my-folder` folder. Set the subject type to `system` and its ID to `allAuthenticatedUsers`:

```
$ yc resource-manager folder add-access-binding my-folder \
    --role viewer \
    --subject system:allAuthenticatedUsers
```

**[!TAB API]**

1. Create a request body, for example, in a `body.json` file. In `roleId`, assign the `viewer` role. In the `subject` property, specify the `system` type and the `allAuthenticatedUsers` ID:

    **body.json:**

    ```json
    {
    "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
            "roleId": "viewer",
            "subject": {
                "id": "allAuthenticatedUsers",
                "type": "system"
                }
            }
        }]
    }
    ```

1. [!INCLUDE [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md)]

---

