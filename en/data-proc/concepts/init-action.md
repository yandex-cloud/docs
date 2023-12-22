# Initialization scripts

When [creating a cluster](../operations/cluster-create.md), you can specify host initialization scripts. This can be useful to automatically install or update software you need to run [jobs](./jobs.md). Each script will be run under the `root` superuser only once, when the host is started for the first time.

In the first line of the script file, specify the full path to the interpreter, e.g., `#!/bin/sh` or `#!/usr/bin/python`.

You can specify the script URI as `https://`, `http://`, `hdfs://`, and `s3a://`. For `s3a://`, at least one of the following conditions must be met:

* The [bucket ACL](../../storage/operations/buckets/edit-acl.md) must allow a cluster service account to perform read operations.
* The cluster service account must have the `storage.viewer` role [assigned](../../iam/operations/sa/assign-role-for-sa.md).
* The access to the bucket must be [public](../../storage/operations/buckets/bucket-availability.md).

## Environment variables {#env-variables}

You can use these environment variables in your initialization scripts:

* `CLUSTER_ID`: Cluster ID.
* `S3_BUCKET`: Name of the linked {{ objstorage-full-name }} bucket.
* `ROLE`: Host role (`masternode`, `computenode`, or `datanode`).
* `CLUSTER_SERVICES`: [Component list](../concepts/environment).
* `MAX_WORKER_COUNT`: Maximum number of hosts in data storage and processing subclusters.
* `MIN_WORKER_COUNT`: Minimum number of hosts in data storage and processing subclusters.

For example, to run a part of a script only on the `masternode` host, check the value of the `ROLE` environment variable:

```bash
if [[ "${ROLE}" == "masternode" ]]; then
   ...
fi
```

## Script initialization errors {#errors}

If the script failed and the cluster switched to `DEAD`:


1. View logs in [{{ cloud-logging-full-name }}](../../logging/operations/read-logs.md) or on cluster hosts in the `/var/log/yandex/dataproc-init-actions.log` file.



1. Correct the error.
1. [Delete](../operations/cluster-delete.md) this cluster and [create](../operations/cluster-create.md) a new one.

If the initialization script returns an error on an existing cluster (such as when adding a subcluster) and recreating the cluster disrupts your workflow, you can fix the error manually:

1. Connect to the problematic host and perform the steps required to resolve the issue.
1. Run the script that marks the initialization script execution results as successful:

   ```bash
   sudo /opt/yandex/complete_init_action.py
   ```

1. Check the initialization script results in the `/home/dataproc-agent/dataproc-init-acts/states.json` file on the master host.

### Syntax errors {#syntax-errors}

To check a script for syntax errors, download the script file manually and run it:

1. Connect to the cluster host.
1. Download the script file from the storage through the link used when creating the cluster, e.g.:

   ```bash
   wget <HTTP_link_to_script_file>
   ```

1. Run the script.

If any error occurs during the script run, you will see an error message in the console.

For instance, an error may occur because of incompatible formats. Since the script runtime environment is Linux (Ubuntu), scripts created in Windows may end with an error saying `^M: bad interpreter` due to using the `CR/LF` newline character (in Linux, it is `LF`). To fix the error, run the following command:

{% list tabs %}

- Bash

   ```bash
   sed -i -e 's/\r$//' <script_file_name>
   ```

- PowerShell

   ```powershell
   $file = "<script_file_name>>"; $text = [IO.File]::ReadAllText($file) -replace "`r`n", "`n"; [IO.File]::WriteAllText($file, $text)
   ```

{% endlist %}