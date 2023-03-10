How you pay for shared {{ ml-platform-name }} resources depends on the resource type:

* Storing a [dataset](../../datasphere/concepts/dataset.md) is paid from the billing account of the <q>parent</q> community whose project the dataset belongs to.
* You can use secrets, Docker images, and aliases free-of-charge.
* S3 connectors are free of charge, but, storing objects in {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md) is paid from the billing account linked to the cloud the bucket belongs to.
* You can use [Data Proc](../../datasphere/concepts/data-proc.md) templates free-of-charge. However, running a cluster automatically created from a template is paid from the billing account of the cloud that the cluster belongs to.