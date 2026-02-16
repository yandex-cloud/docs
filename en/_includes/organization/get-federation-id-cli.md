To view a list of organizations available to you, run this command by substituting the [organization ID](../../organization/operations/organization-get-id.md):

```bash
yc organization-manager organization list --organization-id <organization_ID>
```

Result:

```text
+----------------------+-----------------------------+-------------------------+--------+
|          ID          |            NAME             |          TITLE          | LABELS |
+----------------------+-----------------------------+-------------------------+--------+
| bpf1smsil5q0******** | org1-technical-name         | Organization One        |        |
| bpf2c65rqcl8******** | org2-technical-name         | Organization Two        |        |
| bpfaidqca8vd******** | org3-technical-name         | Organization Three      |        |
+----------------------+-----------------------------+-------------------------+--------+
```

Copy the ID of the organization you need from the `ID` column.