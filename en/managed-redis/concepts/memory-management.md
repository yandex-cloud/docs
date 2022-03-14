# Memory management in {{ mrd-name }}

For user data on the {{ mrd-name }} cluster hosts, {{ mrd-memory-used }} of the total amount of RAM is allocated. The remaining RAM is committed to the {{ RD }} process. The amount of RAM available for user data is determined by the `maxmemory` parameter when starting the {{ RD }} process.

By committing RAM on the host, you can:

* [Improve the {{ RD }} process performance and stability](#redis-performance).
* [Ensure backup stability](#backup-create).

## Improving the performance and stability of the {{ RD }} process {#redis-performance}

With committed RAM, you can use, on {{ mrd-name }} cluster hosts, the [Linux kernel setting](https://www.kernel.org/doc/Documentation/vm/overcommit-accounting) `vm.overcommit_memory = 0`. At this setting, the {{ RD }} process minimizes accesses to the swap file and uses committed RAM for its housekeeping operations. This increases performance and ensures stable operation of the {{ RD }} process, for example, during [replication](replication.md) and [backups](#backup-create).

## Backup stability {#backup-create}

[Backups](backup.md) in {{ mrd-name }} are created based on a consistent snapshot of the process memory image. The snapshot is created by copying the original {{ RD }} process through a `fork()` system call.

With `fork()` you can reduce RAM usage because the original {{ RD }} process and its copy share the same memory pages. The committed RAM and `vm.overcommit_memory = 0` setting make `fork()` more secure: creating of copies doesn't affect the main {{ RD }} process performance.

When `fork()` is running, it uses the mechanism of [Copy-on-Write]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Копирование_при_записи){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Copy-on-write){% endif %}: when a shared memory page is modified, its copy is created to write the changes to. That's why, if you write to the cluster during backups, the updated and new data take up more space in memory. So when data writing is intensive, you might run out of RAM on your hosts even if you have the committed RAM. In this case, the host operating system will OOM-terminate the {{ RD }} processes. {{ RD }} will become unavailable on this host, and replication and backup operations will be interrupted. To avoid this:

* [Make sure](../operations/update.md#change-additional-settings) to start backups when the cluster load is minimum.
* Increase the amount of RAM [by upgrading the host class](../operations/update.md#change-resource-preset).

