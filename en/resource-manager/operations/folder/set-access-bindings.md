# Set the folder access rights

To grant a user access to all the folder resources, assign them a [role](../../../iam/concepts/access-control/roles.md) for that folder.

## How to assign a role for a folder {#access-to-user}

---

**[!TAB Management console]**

1. In the management console, click ![image](../../../_assets/ugly-sandwich.svg) and go to **Access management**.
2. Select the **Users and roles** tab.
3. Select the user to assign the role to and click **Configure roles**.
4. Select a folder in the **Roles in folders** section and click **Assign role** .
5. Select a role from the list.

**[!TAB CLI]**

1. See the description of the command to assign a role for a folder:

    ```
    $ yc resource-manager folder add-access-binding --help
    ```

2. Select a folder (for example, `my-folder`):

    ```
    $ yc resource-manager folder list
    +----------------------+-----------+--------+--------+
    |          ID          |   NAME    | LABELS | STATUS |
    +----------------------+-----------+--------+--------+
    | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
    +----------------------+-----------+--------+--------+
    ```

3. Choose a [role](../../../iam/concepts/access-control/roles.md):

    ```
    $ yc iam role list
    +--------------------------------+-------------+
    |               ID               | DESCRIPTION |
    +--------------------------------+-------------+
    | admin                          |             |
    | compute.images.user            |             |
    | editor                         |             |
    | ...                            |             |
    +--------------------------------+-------------+
    ```

4. Find out the user's ID from the login or email address. To assign a role to a service account or group of users, see the [examples](#examples) below.

    ```
    $ yc iam user-account get test-user
    id: gfei8n54hmfhuk5nogse
    yandex_passport_user_account:
        login: test-user
        default_email: test-user@yandex.ru
    ```

5. Assign the `editor` role for the `my-robot` folder to a user named `test-user`. In the subject, specify the `userAccount` type and user ID:

    ```
    $ yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfhuk5nogse
    ```

**[!TAB API]**

Use the [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) method for the [Folder](../../api-ref/Folder/index.md) resource. You will need the folder ID and the ID of the user who is assigned the role for the folder.

1. Find out the folder ID using the [list](../../api-ref/Folder/list.md) method:

    ```bash
    $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs

    {
     "folders": [
      {
       "id": "b1g66mft1vopnevbn57j",
       "cloudId": "b1gd129pp9ha0vnvf5g7",
       "createdAt": "2018-10-17T12:44:31Z",
       "name": "my-folder",
       "status": "ACTIVE"
      }
     ]
    }
    ```

2. Find out the user ID from the login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) method:

    ```bash
    $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

    {
     "id": "gfei8n54hmfhuk5nogse",
     "yandexPassportUserAccount": {
      "login": "test-user",
      "defaultEmail": "test-user@yandex.ru"
     }
    }
    ```

3. Assign the `editor` role for the `my-folder` folder to the user. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

    ```bash
    $ curl -X POST \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer <IAM-TOKEN>" \
        -d '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "gfei8n54hmfhuk5nogse",
                    "type": "userAccount"
        }}}]}' \
        https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
    ```

---

## Examples {#examples}

* [[!TITLE]](#multiple-roles)
* [[!TITLE]](#access-to-sa)
* [[!TITLE]](#access-to-all)

### Assign multiple roles {#multiple-roles}

---

**[!TAB Management console]**

Follow the instructions at the [beginning of the section](#access-to-user) and assign multiple roles to the user.

To assign a role to another user, select the user on the [Users and roles](https://console.cloud.yandex.com/iam) tab and click **Configure roles**.

**[!TAB CLI]**

The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

> [!WARNING]
>
> The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

1. Make sure the resource doesn't have any roles that you don't want to lose:

    ```
    $ yc resource-manager folder list-access-binding my-folder
    ```
2. For example, assign a role to multiple users:

    ```
    $ yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
        --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
    ```

**[!TAB API]**

Assign the `editor` role to one user and the `viewer` role to another user:

```bash
$ curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
    "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
            "roleId": "editor",
            "subject": {
                "id": "gfei8n54hmfhuk5nogse",
                "type": "userAccount"
            }
        }
    },{
        "action": "ADD",
        "accessBinding": {
            "roleId": "viewer",
            "subject": {
                "id": "helj89sfj80aj24nugsz",
                "type": "userAccount"
    }}}]}' \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
```

You can also assign roles using the [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) method.

> [!WARNING]
>
> The `setAccessBindings` method completely rewrites the access rights to the resource. All current resource roles will be deleted.

```bash
curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
    "accessBindings": [{
        "roleId": "editor",
        "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
    },{
        "roleId": "viewer",
        "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
    }]}' \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
```

---

### Folder access for a service account {#access-to-sa}

In the management console you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

Allow the service account to manage the folder and its resources:

---

**[!TAB Management console]**

[!INCLUDE [grant-role-console-sa](../../../_includes/grant-role-console-sa.md)]

**[!TAB CLI]**

1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

    ```
    $ yc iam service-account list
    +----------------------+----------+------------------+
    |          ID          |   NAME   |   DESCRIPTION    |
    +----------------------+----------+------------------+
    | ajebqtreob2dpblin8pe | test-sa  | test-description |
    +----------------------+----------+------------------+
    ```

2. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

    ```
    $ yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject serviceAccount:ajebqtreob2dpblin8pe
    ```

**[!TAB API]**

1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

    ```bash
    $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gd129pp9ha0vnvf5g7

    {
     "serviceAccounts": [
      {
       "id": "ajebqtreob2dpblin8pe",
       "folderId": "b1gd129pp9ha0vnvf5g7",
       "createdAt": "2018-10-18T13:42:40Z",
       "name": "test-sa",
       "description": "test-description"
      }
     ]
    }
    ```

2. Assign the `editor` role for the `my-folder` folder to the `test-sa` service account. In the `subject` property, specify the `serviceAccount` type and the `test-sa` ID. In the request URL, specify the ID of the `my-folder` folder as a resource:

```bash
$ curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
    "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
            "roleId": "editor",
            "subject": {
                "id": "ajebqtreob2dpblin8pe",
                "type": "serviceAccount"
    }}}]}' \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
```

---

### Access to a resource for all users {#access-to-all}

You can grant access to a resource to all Yandex.Cloud users. To do this, assign a role to the [system group](../../../iam/concepts/access-control/system-group.md) `allAuthenticatedUsers`.

Allow any authenticated user to view information about the `my-folder` folder and its resources:

---

**[!TAB CLI]**

Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the subject type, specify `system`:

```
$ yc resource-manager folder add-access-binding my-folder \
    --role viewer \
    --subject system:allAuthenticatedUsers
```

**[!TAB API]**

Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the `subject` property, specify the `system` type:

```bash
$ curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
    "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
            "roleId": "viewer",
            "subject": {
                "id": "allAuthenticatedUsers",
                "type": "system"
    }}}]}' \
    https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
```

---

#### What's next

* [[!TITLE]](update.md)
* [[!TITLE]](../../concepts/resources-hierarchy.md)

