Get a list of reserved instance pools in the default folder:

```bash
yc compute reserved-instance-pool list
```

Result:

```text
+----------------------+------------+---------------+------+
|          ID          |    NAME    |    ZONE ID    | SIZE |
+----------------------+------------+---------------+------+
| fv48qa9iiq19******** | test-pool1 | {{ region-id }}-a |    1 |
| fv42fbsrso94******** | test-pool2 | {{ region-id }}-a |    1 |
+----------------------+------------+---------------+------+
```