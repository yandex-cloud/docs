### Отсутствие прав на работу с подсетями и группами безопасности при создании эндпоинта {#vpc-user}

Текст ошибки:

```text
Create endpoint failed: rpc error: code = PermissionDenied desc = Failed permission check: No permission to use VPC Security Groups: Permission denied
```
или
```text
Failed permission check: No permission to use VPC Subnets: Permission denied
```

**Решение:** назначьте пользователю роль [`vpc.user`](../../../../vpc/security/index.md) на каталог, в котором находится подсеть.
