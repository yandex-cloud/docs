
Upon reaching the specified threshold, the storage expands differently depending on the disk type:

* For network HDDs and SSDs, by the higher of the two values: 20 GB or 20% of the current disk size.
* For non-replicated SSDs, by 93 GB.
* For local SSDs, in a cluster based on:

    * **Intel Cascade Lake**, by 100 GB.
    * **Intel Ice Lake**, by {{ local-ssd-v3-step }}.


If the threshold is reached again, the storage will be automatically expanded until it reaches the specified maximum. After that, you can set a new maximum storage size manually.
