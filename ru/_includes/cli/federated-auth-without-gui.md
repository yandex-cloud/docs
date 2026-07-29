В случае отсутствия на сервере графического интерфейса и браузера возникает ошибка:

```text
ERROR: fill default credentials: federation id authentication is not supported on this system because the browser can not be opened
```

[Аутентифицируйтесь сервисным аккаунтом](../../cli/operations/authentication/service-account.md). Также вы можете использовать [SSH-туннель](../../cli/operations/authentication/auth-without-gui.md#linux-vm-auth) или [форвардинг X11](../../cli/operations/authentication/auth-without-gui.md#auth-without-gui).