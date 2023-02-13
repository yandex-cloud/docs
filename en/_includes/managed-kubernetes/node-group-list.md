To access a node group, use its name or unique ID obtained using the command:

```bash
yc managed-kubernetes node-group list
```

Result:

```bash
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
|          ID          |      CLUSTER ID      |    NAME     |  INSTANCE GROUP ID   |     CREATED AT      | STATUS  | SIZE |
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
| catt3knapbq5o0n134o1 | cati493bu7ian006a5j7 | k8s-demo-ng | cl1tbm76ms7pv6siti7l | 2019-11-20 12:01:02 | RUNNING |    2 |
+----------------------+----------------------+-------------+----------------------+---------------------+---------+------+
```
