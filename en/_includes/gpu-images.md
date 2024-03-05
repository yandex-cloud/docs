To get a list of available images, run the following command:

```bash
yc compute image list --folder-id standard-images
```

Result:

```text
+----------------------+----------------------------------+-----------------------+----------------------+--------+
|          ID          |               NAME               |         FAMILY        |     PRODUCT IDS      | STATUS |
+----------------------+----------------------------------+-----------------------+----------------------+--------+
...
| fdv7ooobjfl3******** | windows-2016-gvlk-gpu-1548913814 | windows-2016-gvlk-gpu | dqnnc72gj2is******** | READY  |
| fdv4f5kv5cvf******** | ubuntu-1604-lts-gpu-1549457823   | ubuntu-1604-lts-gpu   | dqnnb6dc7640******** | READY  |
...
+----------------------+----------------------------------+-----------------------+----------------------+--------+
```
