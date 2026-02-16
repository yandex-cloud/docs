
Upon reaching the specified threshold, the storage expands with the increase size depending on the disk type:

* For network HDDs and SSDs, the increase is the larger of these two values: 20 GB or 20% of the current disk size.
* For non-replicated SSDs and ultra-fast network SSDs with triple replication, the increase is 93 GB.
* For local SSDs:

    * In an **Intel Broadwell** or **Intel Cascade Lake** cluster, the increase is 100 GB.
    * In **Intel Ice Lake** cluster, the increase is {{ local-ssd-v3-step }}.


If the threshold is triggered again, the storage size will automatically increase once more. This process will repeat until the storage size reaches the specified maximum. After that, you can specify a new maximum storage size manually.
