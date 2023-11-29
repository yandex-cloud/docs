View the roles assigned for a resource:

```bash
yc <service_name> <resource_category> list-access-bindings <resource_name_or_ID>
```

Where:

* `<service_name>`: Name of the service the resource belongs to, e.g., `resource-manager`.
* `<resource_category`: Resource category, e.g., `folder`.
* `<resource_name_or_ID>`: Name or ID of the resource. You can specify a resource by its name or ID.

For example, you can view what roles were assigned for the `default` folder and to whom:

```bash
yc resource-manager folder list-access-bindings default
```

Output:

```
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06******** |
| viewer              | userAccount    | aje6o61dvog2******** |
+---------------------+----------------+----------------------+
```
