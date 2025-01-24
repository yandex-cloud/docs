Your storage may have insufficient maximum [IOPS and bandwidth](../compute/concepts/storage-read-write.md) to process the current number of requests. In this case, [throttling](../compute/concepts/storage-read-write.md#throttling) occurs, which degrades the entire cluster performance.

The maximum IOPS and bandwidth values increase by a fixed value when the storage size increases by a certain step. The step and increment values depend on the disk type:

| Disk type                  | Step, GB | Max IOPS increase (read/write) | Max bandwidth increase (read/write), MB/s |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-hdd`               | 256     | 300/300                            | 30/30                                         |
| `network-ssd`               | 32      | 1,000/1,000                          | 15/15                                         |
| `network-ssd-nonreplicated`, `network-ssd-io-m3` | 93      | 28,000/5,600                         | 110/82                                        |