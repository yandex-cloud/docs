
Upon reaching the specified threshold, the storage will be expanded depending on the disk type:

* For network HDDs and SSDs, by the higher of the two values: 20 GB or 20% of the current disk size.
* For non-replicated SSDs and ultra high-speed network SSDs with three replicas, by 93 GB.
* For local SSDs:

    * In an **Intel Broadwell** or **Intel Cascade Lake** cluster, by 100 GB.
    * In an **Intel Ice Lake** cluster, by {{ local-ssd-v3-step }}.


If the threshold is reached again, the storage size will increase until it reaches the specified maximum value. Then, you should increase the maximum storage size. 