To access a {{ k8s }} cluster, use its name or unique ID that you can get by using this command:

```bash
yc managed-kubernetes cluster list
```

Result:

```bash
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
|          ID          |   NAME   |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    |   INTERNAL ENDPOINT   |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
| cati493bu7ia******** | k8s-demo | 2019-11-20 11:26:36 | HEALTHY | RUNNING | https://84.201.174.147/ | https://192.168.0.27/ |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
```
