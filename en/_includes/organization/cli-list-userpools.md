To get a list of pools in an organization, provide its [ID](../../organization/operations/organization-get-id.md) in this command:

```bash
yc organization-manager idp userpool list \
  --organization-id <organization_ID>
```

Result:

```text
+----------------------+--------------+-------------+----------------------+---------------------+
|          ID          |     NAME     | DESCRIPTION |   ORGANIZATION ID    |     CREATED AT      |
+----------------------+--------------+-------------+----------------------+---------------------+
| ek0o6g0irskn******** | sample-pool1 |             | bpf2c65rqcl8******** | 2025-05-17 10:01:04 |
| ek03mf01jr4z******** | sample-pool2 |             | bpf2c65rqcl8******** | 2025-06-28 16:30:23 |
+----------------------+--------------+-------------+----------------------+---------------------+
```