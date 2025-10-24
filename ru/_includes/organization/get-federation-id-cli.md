Чтобы посмотреть список доступных организаций, выполните команду, подставив [идентификатор организации](../../organization/operations/organization-get-id.md):

```bash
yc organization-manager organization list --organization-id <идентификатор_организации>
```

Результат:

```text
+----------------------+-----------------------------+-------------------------+--------+
|          ID          |            NAME             |          TITLE          | LABELS |
+----------------------+-----------------------------+-------------------------+--------+
| bpf1smsil5q0******** | org1-technical-name         | Organization One        |        |
| bpf2c65rqcl8******** | org2-technical-name         | Organization Two        |        |
| bpfaidqca8vd******** | org3-technical-name         | Organization Three      |        |
+----------------------+-----------------------------+-------------------------+--------+
```

Из колонки `ID` скопируйте идентификатор нужной организации.