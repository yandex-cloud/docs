Посмотрите, какие роли назначены на ресурс:

```bash
yc <service-name> <resource> list-access-bindings <resource-name>|<resource-id>
```

Где:

* `<service-name>` — имя сервиса, которому принадлежит ресурс, например `resource-manager`.
* `<resource>` — категория ресурса, например `folder`.
* `<resource-name>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
* `<resource-id>` — идентификатор ресурса.

Например, посмотрите кому и какие роли назначены на каталог `default`:

```bash
yc resource-manager folder list-access-bindings default
```

Результат:

```
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06siuj5usm |
| viewer              | userAccount    | aje6o61dvog2h6g9a33s |
+---------------------+----------------+----------------------+
```

