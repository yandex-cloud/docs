# Memory management in {{ mrd-name }}

For user data on the {{ mrd-name }} cluster hosts, {{ mrd-memory-used }} of the total amount of RAM is allocated. The remaining RAM is reserved for the {{ VLK }} process's own needs. You can reduce the amount of RAM allocated for user data by using the [Maxmemory percent](settings-list.md#settings-maxmemory-percent) parameter. This may be helpful if an out-of-memory error occurs in the cluster.

By reserving RAM on the host, you can:

* [Improve the {{ VLK }} process performance and stability](#valkey-performance).
* [Ensure backup stability](#backup-create).

## Improving the performance and stability of the {{ VLK }} process{#valkey-performance}

{{ mrd-name }} cluster hosts use the `vm.overcommit_memory = 0` [Linux kernel setting](https://www.kernel.org/doc/Documentation/vm/overcommit-accounting). The {{ VLK }} process leverages it to minimize the number of swap file accesses. This increases performance and ensures stable operation of the {{ VLK }} process, for example, during [replication](replication.md) and [backups](#backup-create).

## Backup stability {#backup-create}

[Backups](backup.md) in {{ mrd-name }} are created based on a consistent snapshot of the process memory. The snapshot is created by copying the original {{ VLK }} process through the `fork()` system call. 

With `fork()`, you can reduce RAM usage, as the original {{ VLK }} process and its copy share the same memory pages. Reserved RAM and the `vm.overcommit_memory = 0` setting make `fork()` more secure: creating backups does not affect the performance of the main {{ VLK }} process.

`fork()` uses the [Copy-on-Write](https://en.wikipedia.org/wiki/Copy-on-write) mechanism: if a shared memory page is modified, its copy is created, and the changes are written into that copy. So if you write to the cluster while a backup is being created, the updated and new data are going to take up extra RAM space. Therefore, intense writing may deplete host memory even with reserved RAM available. In which case the host's operating system will terminate the {{ VLK }} processes citing _out of memory_. {{ VLK }} will become unavailable on this host, and the replication and backup operations will be interrupted. To avoid this:
* Make sure to [start backups](../operations/update.md#change-additional-settings) when the cluster load is minimum.
* Increase the amount of RAM [by upgrading the host class](../operations/update.md#change-resource-preset).
