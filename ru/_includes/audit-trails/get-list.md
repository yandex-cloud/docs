Получите список трейлов:

```bash
yc audit-trails trail list
```

Результат:

```text
+----------------------+--------------+--------+-------------------+
|          ID          |     NAME     | STATUS |      FILTERS      |
+----------------------+--------------+--------+-------------------+
| cnp82sb0phnm******** | trailfromapi | ACTIVE | storage compute   |
|                      |              |        | management.events |
| cnp8v52idttr******** | tf-trail     | ACTIVE | storage compute   |
|                      |              |        | mdb.postgresql    |
| cnpnkcubr529******** | test-2       | ACTIVE | compute           |
+----------------------+--------------+--------+-------------------+
```
