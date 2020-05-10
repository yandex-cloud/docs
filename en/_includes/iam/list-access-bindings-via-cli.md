View the roles assigned for a resource:

```
$ yc <SERVICE-NAME> <RESOURCE> list-access-bindings <RESOURCE-NAME>|<RESOURCE-ID>
```

where:

* `<SERVICE-NAME>` is the name of the service that the resource belongs to (for example, `resource-manager`).
* `<RESOURCE>` is the category of the resource, such as `folder`.
* `<RESOURCE-NAME>` is the name of the resource. You can specify a resource by its name or ID.
* `<RESOURCE-ID>` is the resource ID.

For example, you can view what roles were assigned for the `default` folder and to whom:

```
$  yc resource-manager folder list-access-bindings default
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06siuj5usm |
| viewer              | userAccount    | aje6o61dvog2h6g9a33s |
+---------------------+----------------+----------------------+
```

