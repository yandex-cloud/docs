The `security-deck.viewer` role enables viewing info on the events of access to organization resources by Yandex Cloud employees, as well as on DSPM resources, scan jobs, and the number of detected security threats. With this role, you cannot view masked and unprocessed data.

Users with this role can:
* View the list of the events when Yandex Cloud employees access organization resources.
* Approve or disapprove the result of the neural network-driven analysis of the events when Yandex Cloud employees access organization resources.
* View info on DSPM profiles.
* View info on DSPM [data sources](../../security-deck/concepts/dspm.md#data-source).
* View info on security [scan](../../security-deck/concepts/dspm.md#scanning) jobs.
* View scan results and the info on the detected threats.

This role includes the `dspm.viewer` and `access-transparency.viewer` permissions.
