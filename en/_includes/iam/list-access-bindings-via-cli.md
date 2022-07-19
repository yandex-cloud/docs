View the roles assigned for a resource:

```bash
yc <service-name> <resource> list-access-bindings <resource-name>|<resource-id>
```

Where:

* `<service-name>`: The name of the service that the resource belongs to (for example, `resource-manager`).
* `<resource>`: The resource category, such as `folder`.
* `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
* `<resource-id>`: The resource ID.

For example, you can view what roles were assigned for the `default` folder and to whom:

```bash
yc resource-manager folder list-access-bindings default
```

Result:
```
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06siuj5usm |
| viewer              | userAccount    | aje6o61dvog2h6g9a33s |
+---------------------+----------------+----------------------+
```
