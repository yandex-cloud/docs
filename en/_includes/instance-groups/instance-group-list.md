```
$ {{ yc-compute-ig }} list
+----------------------+----------------------+---------+--------+------------+--------+
|          ID          |         NAME         | RUNNING | TARGET | PROCESSING | FAILED |
+----------------------+----------------------+---------+--------+------------+--------+
| amc6qgmkv1fjiaoljblh | first-instance-group |       2 |      3 |          1 |      0 |
+----------------------+----------------------+---------+--------+------------+--------+
```

Fields:

| Field | Value |
| ----- | ----- |
| `ID` | The instance group ID. |
| `NAME` | The instance group name. |
| `RUNNING` | Number of virtual machines that work. |
| `TARGET` | Target number of virtual machines. |
| `PROCESSING` | Number of virtual machines that creating, updating, deleting. |
| `FAILED` | Number of virtual machines that failed. |
