View the roles assigned for a resource:

```bash
yc <service_name> <resource_category> list-access-bindings <resource_name_or_ID>
```

Where:

* `<service_name>`: Name of the service the resource belongs to, e.g., `resource-manager`.
* `<resource_category>`: Resource category, e.g., `folder`.
* `<resource_name_or_ID>`: Resource name or ID. You can specify a resource by its name or ID.

For example, you can view the roles and the assignees for the `default` folder:

```bash
yc resource-manager folder list-access-bindings default
```

Result:

```text
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06******** |
| viewer              | userAccount    | aje6o61dvog2******** |
+---------------------+----------------+----------------------+
```

