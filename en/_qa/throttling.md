Perhaps, the maximum storage [IOPS and bandwidth](../compute/concepts/storage-read-write.md) values are insufficient for processing the current number of requests. In this case, [throttling](../compute/concepts/storage-read-write.md#throttling) is triggered and the performance of the entire cluster degrades.

The maximum IOPS and bandwidth values increase by a fixed value when the storage size increases by a certain step. The step and increment values depend on the disk type:

| Disk type | Step, GB | Max IOPS increase (read/write) | Max bandwidth increase (read/write), MB/s |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-hdd` | 256 | 300/300 | 30/30 |
| `network-ssd` | 32 | 1,000/1,000 | 15/15 |
| `network-ssd-nonreplicated` | 93 | 28,000/5,600 | 110/82 |
