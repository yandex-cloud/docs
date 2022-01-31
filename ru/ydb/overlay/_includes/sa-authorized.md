```bash
yc iam key create \
  --service-account-name <имя_сервисного_аккаунта> \
  --output <имя_файла>
```

* `--service-account-name` — имя созданного ранее сервисного аккаунта.
* `--output` — имя файла, в который будет сохранен авторизованный ключ, например `sa_authorized.json`.
