As soon as one of the specified conditions is met, the storage size will be increased:

* For network HDDs and SSDs, by the higher value of the two: 20 GB or 20% of the current disk size.
* For non-replicated SSDs, by 93 GB.
* For local SSDs:
   * In an **Intel Broadwell** or **Intel Cascade Lake** cluster, by 100 GB.
   * In an **Intel Ice Lake** cluster, by {{ local-ssd-v3-step }}.

The storage size will be automatically increased on repeated triggers until it reaches the specified maximum. After that, you can specify a new maximum storage size manually.
