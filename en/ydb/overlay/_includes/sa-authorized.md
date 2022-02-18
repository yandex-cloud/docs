```bash
yc iam key create \
  --service-account-name <service_account_name> \
  --output <filename>
```

* `--service-account-name`: Name of the previously created service account.
* `--output`: Name of the file where the authorized key is saved, such as `sa_authorized.json`.
