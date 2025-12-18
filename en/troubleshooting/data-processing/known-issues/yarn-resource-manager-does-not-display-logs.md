# No logs in the YARN Resource Manager web UI after running jobs


## Issue description {#issue-description}

You cannot view logs for a completed job in the YARN Resource Manager web UI of your {{ dataproc-name }} cluster; however, you see the logs when running a job. When trying to view logs, you get this message:

```
Failed redirect for container_....

Failed while trying to construct the redirect url to the log server. Log Server url may not be configured
Local Logs:
java.lang.Exception: Unknown container. Container either has not started or has already completed or doesn't belong to this node at all.
```

## Solution {#issue-resolution}

Log aggregation is enabled on clusters by default. After a container completes its jobs, its logs are transferred to HDFS. The YARN UI only displays logs when they are placed directly in the node file system. We can suggest a few workarounds:

* Get logs from HDFS using this command:

  ```
  sudo -u hdfs hadoop fs -ls /var/log/yarn/
  ```

* Get logs via the YARN CLI:

  ```
  yarn logs -applicationId
  ```

* Configure log export to S3:

  ```
  yc dataproc cluster update <id_cluster> \
        --property "yarn:yarn.nodemanager.remote-app-log-dir=s3a://<bucket>/yarn-logs/"
        --property "yarn:yarn.log-aggregation.retain-seconds=-1"
  ```

{% note warning %}

The `--property` option will reset all component properties that were not explicitly provided, to their default values. To save the properties you updated, list them in your request along with the ones you want to update.

{% endnote %}

Enable log aggregation to view logs for an application that has ended in the UI. You can do this using the following CLI command:

```
yc dataproc cluster update your_cluster --property yarn:yarn.log-aggregation-enable=false
```
