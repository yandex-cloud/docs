# Delete a service account

> [!IMPORTANT]
>
> Deleting a [service account](../../concepts/users/service-accounts.md) is an operation that cannot be undone. You can't restore a deleted service account; you can only [re-create](create.md) it.

---

**[!TAB Management console]**

1. Select a folder.
2. Select the **Service accounts** tab.
3. Click ![image](../../../_assets/options.svg) next to the service account and select **Delete service account**.
4. Confirm the deletion.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the delete service account command:

    ```
    $ yc iam service-account delete --help
    ```

2. Select a service account (for example, `my-robot`):

    ```
    $ yc iam service-account list
    +----------------------+------------------+-------------------------------+
    |          ID          |       NAME       |          DESCRIPTION          |
    +----------------------+------------------+-------------------------------+
    | aje6o61dvog2h6g9a33s | my-robot         |                               |
    | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
    +----------------------+------------------+-------------------------------+
    ```

3. Delete the service account:

    ```
    yc iam service-account delete my-robot
    ```

**[!TAB API]**

To delete a service account, use the [delete](../../api-ref/ServiceAccount/delete.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

---

