# Delete service account

> [!IMPORTANT]
>
> Deleting a service account is permanent. You can't restore a deleted service account; you can only [re-create](create.md) it.

---

**[!TAB Management console]**

1. Select the folder.
2. Select the **Service accounts**  tab.
3. Click [](../../../_assets/dots.png) next to the service account and select **Delete service account**.
4. Confirm the deletion.

**[!TAB CLI]**

Delete the service account from your default folder:

```
yc iam service-account delete <SERVICE-ACCOUNT-NAME>|<SERVICE-ACCOUNT-ID>
```

If the service account belongs to a different folder, you can specify the folder using the `--folder-id` or `folder-name` flags:

```
yc iam service-account delete my-robot \
    --folder-name yet-another-folder
```

**[!TAB API]**

To delete a service account, use the `Delete` method for the `ServiceAccount` resource.

---

