View the list of all routing instances in the folder:

```bash
yc cloudrouter routing-instance list \
  --folder-id <folder_ID>
```

Where `--folder-id` is the [ID of the folder](../../resource-manager/operations/folder/get-id.md) containing the routing instance.

Result:

```text
+----------------------+------+----------+--------------------------------+
|          ID          | NAME |  STATUS  |     PRIVATE CONNECTION ID      |
+----------------------+------+----------+--------------------------------+
| c3lgk007olse******** | ri1  | UPDATING | cf3or586ln29********,          |
|                      |      |          | cf3uj9uph7b6********           |
+----------------------+------+----------+--------------------------------+
```