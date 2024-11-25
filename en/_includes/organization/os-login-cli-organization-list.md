Get the ID of the organization containing the required OS Login profile of the user or [service account](../../iam/concepts/users/service-accounts.md):

```bash
yc organization-manager organization list
```

Result:

```text
+----------------------+-------------------------+-------------------------+
|          ID          |          NAME           |          TITLE          |
+----------------------+-------------------------+-------------------------+
| bpf1smsil5q0******** | sample-organization1    | Organization 1          |
| bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
| bpf6dne49ue8******** | sample-organization3    | Organization 3          |
+----------------------+-------------------------+-------------------------+
```