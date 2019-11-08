Посмотрите, какие роли назначены на ресурс:

```
$ yc <SERVICE-NAME> <RESOURCE> list-access-bindings <RESOURCE-NAME>|<RESOURCE-ID>
```
где:
* `<SERVICE-NAME>` — имя сервиса, которому принадлежит ресурс, например `resource-manager`.
* `<RESOURCE>` — категория ресурса, например `folder`.
* `<RESOURCE-NAME>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
* `<RESOURCE-ID>` — идентификатор ресурса.

Например, посмотрите кому и какие роли назначены на каталог `default`:
```
$  yc resource-manager folder list-access-bindings default
+---------------------+----------------+----------------------+
|       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
+---------------------+----------------+----------------------+
| editor              | serviceAccount | ajepg0mjas06siuj5usm |
| viewer              | userAccount    | aje6o61dvog2h6g9a33s |
+---------------------+----------------+----------------------+
```