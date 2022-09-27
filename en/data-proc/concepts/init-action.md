# Initialization scripts

When [creating a cluster](../operations/cluster-create.md), you can specify host initialization scripts. This can be useful to automatically install or update software needed to run [jobs](./jobs.md). Each script will be executed on behalf of the superuser `root` only once when the host is started for the first time.

In the first line of the script file, specify the full path to the interpreter, for example, `#!/bin/sh` or `#!/usr/bin/python`.

You can specify a script's URI as `https://`, `http://`, `hdfs://`, and `s3a://`. For `s3a://`, at least one of the following conditions must be met:

* A [bucket ACL](../../storage/operations/buckets/edit-acl.md) must permit a cluster service account to perform read operations.
* A cluster service account must be [assigned the role](../../iam/operations/sa/assign-role-for-sa.md) `storage.viewer`.
* Access to a bucket must be [public](../../storage/operations/buckets/bucket-availability.md).

## Environment variables {#env-variables}

The following environment variables are available for use in initialization scripts:

* `CLUSTER_ID`: Cluster ID.
* `S3_BUCKET`: Name of the linked {{ objstorage-full-name }} bucket.
* `ROLE`: Host role (`masternode`, `computenode`, or `datanode`).
* `CLUSTER_SERVICES`: [Component list](../concepts/environment).
* `MAX_WORKER_COUNT`: Maximum number of hosts in data storage and processing subclusters.
* `MIN_WORKER_COUNT`: Minimum number of hosts in data storage and processing subclusters.

For example, to execute a part of a script only on the `MASTERNODE` host, check the value of the `ROLE` environment variable:

```bash
if [[ "${ROLE}" == "masternode" ]]; then
   ...
fi
```

## Script initialization errors {#errors}

If the script execution ends with an error:


1. View logs in [{{ cloud-logging-full-name }}](../../logging/operations/read-logs.md) or on cluster hosts in the file `/var/log/yandex/dataproc-init-actions.log`.



1. Correct the error.
1. [Delete](../operations/cluster-delete.md) this cluster and [create](../operations/cluster-create.md) a new one.
