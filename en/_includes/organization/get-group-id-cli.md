To view a list of available groups, run this command by specifying the [organization ID](../../organization/operations/organization-get-id.md):

```bash
yc organization-manager organization list --organization-id <organization_ID>
```

Result:

```text
+----------------------+-----------------------+
|          ID          |          NAME         |
+----------------------+-----------------------+
| ajetvnq2mil8******** | group1-technical-name |
| aje0857jd5ul******** | group2-technical-name |
| ajealo08t37i******** | group3-technical-name |
+----------------------+-----------------------+
```

Copy the ID of the organization you need from the `ID` column.