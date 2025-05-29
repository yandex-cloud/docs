The `security-deck.admin` role enables managing subscriptions on events of access to organization resources by Yandex Cloud employees, as well as using DSPM profiles and managing data sources and security scans, which includes viewing masked and unprocessed data in the scan results.

Users with this role can:
* Select a [billing account](../../billing/concepts/billing-account.md) in Access Transparency.
* View info on subscriptions on events of access to organization resources by Yandex Cloud employees, as well as create, delete, and cancel deletion of such subscriptions.
* View the list of the events when Yandex Cloud employees access organization resources.
* Approve or disapprove the result of the neural network-driven analysis of the events when Yandex Cloud employees access organization resources.
* View info on DSPM profiles and use them.
* View info on DSPM [data sources](../../security-deck/concepts/dspm.md#data-source), as well as create, modify, use, and delete them.
* Use Yandex Cloud resources in DSPM data sources.
* View info on DSPM [data categories](../../security-deck/concepts/dspm.md#data-categories).
* View info on security [scan](../../security-deck/concepts/dspm.md#scanning) jobs, as well as create, modify, and delete such jobs.
* Run security scan jobs and view their results, as well as info on the detected threats.
* View the [bucket](../../storage/concepts/bucket.md) metadata.

This role includes the `dspm.admin` and `access-transparency.admin` permissions.
