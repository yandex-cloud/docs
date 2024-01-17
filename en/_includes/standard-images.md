To get a list of available images using the YC CLI, run this command:

```bash
yc compute image list --folder-id standard-images
```

Result:

```text
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
|          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
...
| fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
| fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
| fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
...
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
```
