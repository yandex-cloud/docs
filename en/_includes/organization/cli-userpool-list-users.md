To get the IDs and other information about pool users, provide the pool ID in the following command:

```bash
yc organization-manager idp user list \
  --userpool-id <user_pool_ID>
```

Result:

```text
+----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
|          ID          |                USERNAME                | FULL NAME |     USERPOOL ID      | IS ACTIVE |     CREATED AT      |
+----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
| aje3i1gq49n3******** | test-user1@test.ru.idp.yandexcloud.net | User 1    | ek0o6g0irskn******** | true      | 2025-10-07 10:41:54 |
| aje0j5mts02t******** | test-user2@test.ru.idp.yandexcloud.net | User 2    | ek0o6g0irskn******** | false     | 2025-07-16 11:18:57 |
+----------------------+----------------------------------------+-----------+----------------------+-----------+---------------------+
```