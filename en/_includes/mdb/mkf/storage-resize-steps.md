
If the specified threshold is reached, the storage size may increase in different ways depending on the disk type:

* For network HDDs and SSDs, by the higher of the two values: 20 GB or 20% of the current disk size.
* For non-replicated SSDs, by 93 GB.
* For local SSDs, in a platform cluster:

    * **Intel Cascade Lake**, by 100 GB.
    * **Intel Ice Lake**, by {{ local-ssd-v3-step }}.


If the threshold is reached again, the storage size will be automatically increased until it reaches the specified maximum. After that, you can specify a new maximum storage size manually.
