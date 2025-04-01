Reset the desktop password:

```bash
yc desktops desktop reset-password \
  --id <desktop_ID> \
  --user-account-id <user_ID>
```

Where:

* `--id`: Desktop ID.
* `--user-account-id`: ID of the user the desktop is created for.