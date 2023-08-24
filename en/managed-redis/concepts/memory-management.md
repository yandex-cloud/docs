# Memory management in {{ mrd-name }}

For user data on the {{ mrd-name }} cluster hosts, {{ mrd-memory-used }} of the total amount of RAM is allocated. The remaining RAM is committed to the {{ RD }} process. The amount of RAM available for user data is determined by the `maxmemory` parameter when starting the {{ RD }} process.

By committing RAM on the host, you can:

* [Improve the {{ RD }} process performance and stability](#redis-performance).
* [Ensure backup stability](#backup-create).

## Improving the performance and stability of the {{ RD }} process {#redis-performance}

{{ mrd-name }} cluster hosts use the `vm.overcommit_memory = 0` [Linux kernel setting](https://www.kernel.org/doc/Documentation/vm/overcommit-accounting). The {{ RD }} process leverages it to minimize the number of swap file accesses. This increases performance and ensures stable operation of the {{ RD }} process, for example, during [replication](replication.md) and [backups](#backup-create).

## Backup stability {#backup-create}

[Backups](backup.md) in {{ mrd-name }} are created based on a consistent snapshot of the process memory image. The snapshot is created by copying the original {{ RD }} process through the `fork()` system call.

With `fork()`, you can reduce RAM usage, as the original {{ RD }} process and its copy share the same memory pages. The committed RAM and the `vm.overcommit_memory = 0` setting make `fork()` more secure, since creating copies does not affect the main {{ RD }} process performance.

When `fork()` is running, it uses the [Copy-on-Write](https://en.wikipedia.org/wiki/Copy-on-write) feature: when a shared memory page is modified, its copy is created to write the changes to. This is why, if you write anything to the cluster during backups, the updated and new data take up more space in terms of memory. This means, when data writing is intensive, you might run out of RAM on your hosts even if you have the committed RAM. In this case, the host operating system will terminate the {{ RD }} processes with the out-of-memory (OOM) error. {{ RD }} will become unavailable on this host, and the replication and backup operations will be interrupted. To avoid this:
* Make sure to [start backups](../operations/update.md#change-additional-settings) when the cluster load is minimum.
* Increase the amount of RAM [by upgrading the host class](../operations/update.md#change-resource-preset).
