Get a list of configurations:

```bash
yc baremetal configuration list
```

Approximate result:

```text
+----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
|          ID          |        NAME         | MEMORYGIB |              CPU               |          DISK DRIVES           | NETWORK BMANDWIDTH GBPS | CPU NUM |
+----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
| ly577w5sepew******** | LA-i108-S-1/10G     |        32 | physical cores: 4, mhz: 2400,  | [ type: SSD count: 2 size_gib: |                      10 |       1 |
|                      |                     |           | name: Xeon D-1521, vendor:     | 838 ]                          |                         |         |
|                      |                     |           | Intel                          |                                |                         |         |
| ly5tdlrmwezt******** | LA-i107-S-1/10G     |        16 | physical cores: 4, mhz: 2400,  | [ type: SSD count: 2 size_gib: |                      10 |       1 |
|                      |                     |           | name: Xeon D-1521, vendor:     | 838 ]                          |                         |         |
|                      |                     |           | Intel                          |                                |                         |         |
| ly527jeaz2nb******** | BA-i202-S           |       128 | physical cores: 8, mhz: 2600,  | [ type: SSD count: 2 size_gib: |                       1 |       2 |
|                      |                     |           | name: Xeon E5-2650V2, vendor:  | 838 ]                          |                         |         |
|                      |                     |           | Intel                          |                                |                         |         |
...
...
| ly52arjxxbl3******** | LA-i114-S           |        64 | physical cores: 8, mhz: 2200,  | [ type: SSD count: 2 size_gib: |                       1 |       2 |
|                      |                     |           | name: Xeon E5-2660, vendor:    | 838 ]                          |                         |         |
|                      |                     |           | Intel                          |                                |                         |         |
+----------------------+---------------------+-----------+--------------------------------+--------------------------------+-------------------------+---------+
```