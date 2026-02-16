How you pay for shared {{ ml-platform-name }} resources depends on the resource type:

* Storing a [dataset](../../datasphere/concepts/dataset.md) is paid from the billing account of the <q>parent</q> community whose project the dataset belongs to.
* Using secrets, Docker images, and aliases is free of charge.
* Using S3 connectors is free of charge; however, storing objects in a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) is paid from the billing account linked to the cloud hosting that bucket.
* Using [{{ dataproc-name }}](../../datasphere/concepts/data-processing.md) templates is free of charge; however, running a cluster automatically created from a template is paid from the billing account of the cloud hosting that cluster.