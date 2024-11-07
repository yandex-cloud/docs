Получите идентификатор организации, в которой находится нужный [профиль {{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

```bash
yc organization-manager organization list
```

Результат:

```text
+----------------------+-------------------------+-------------------------+
|          ID          |          NAME           |          TITLE          |
+----------------------+-------------------------+-------------------------+
| bpf1smsil5q0******** | sample-organization1    | Organization 1          |
| bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
| bpf6dne49ue8******** | sample-organization3    | Organization 3          |
+----------------------+-------------------------+-------------------------+
```