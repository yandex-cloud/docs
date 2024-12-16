How you pay for shared {{ ml-platform-name }} resources depends on the resource type:

* Storing a [dataset](../../datasphere/concepts/dataset.md) is paid from the billing account of the <q>parent</q> community whose project the dataset belongs to.
* You can use secrets, Docker images, and aliases free-of-charge.
* S3 connectors are free of charge; however, storing objects in a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) is paid from the billing account linked to the cloud the bucket belongs to.
* You can use [{{ dataproc-name }}](../../datasphere/concepts/data-processing.md) templates free of charge. However, running a cluster automatically created from a template is paid from the billing account of the cloud that the cluster belongs to.