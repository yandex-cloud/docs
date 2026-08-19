If the server has no GUI or browser, you will get the following error:

```text
ERROR: fill default credentials: federation id authentication is not supported on this system because the browser can not be opened
```

[Authenticate using a service account](../../cli/operations/authentication/service-account.md). Alternatively, you can use an [SSH tunnel](../../cli/operations/authentication/auth-without-gui.md#linux-vm-auth) or [X11 forwarding](../../cli/operations/authentication/auth-without-gui.md#auth-without-gui).