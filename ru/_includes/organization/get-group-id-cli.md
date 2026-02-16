Чтобы посмотреть список доступных групп, выполните команду, подставив [идентификатор организации](../../organization/operations/organization-get-id.md):

```bash
yc organization-manager organization list --organization-id <идентификатор_организации>
```

Результат:

```text
+----------------------+-----------------------+
|          ID          |          NAME         |
+----------------------+-----------------------+
| ajetvnq2mil8******** | group1-technical-name |
| aje0857jd5ul******** | group2-technical-name |
| ajealo08t37i******** | group3-technical-name |
+----------------------+-----------------------+
```

Из колонки `ID` скопируйте идентификатор нужной организации.