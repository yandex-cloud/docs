```bash
yc quota-manager quota-request cancel --id <request_ID> --quota-id=<quota_ID>
```

Where:

* `--id`: ID of the request you need to cancel.
* `--quota-id`: Quota ID in the request. To specify multiple quotas, add multiple `--quota-id` parameters.