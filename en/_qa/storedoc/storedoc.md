#### Why should I use {{ SD }} in {{ mmg-short-name }} rather than a self-managed installation on a virtual machine? {#storedoc-advantages-vm}

{{ mmg-short-name }} automates routine database maintenance:

- Rapid database deployment with necessary resources available.
- Data backup.
- Regular software updates.
- Providing fault tolerance for database clusters.
- Database usage monitoring and statistics.


#### What happens to the cluster if one of its hosts fails? {#node-out}

A database cluster with more than one replica will remain operational during a host failure.

Data loss can only occur if the sole host in the cluster fails.


#### Can I deploy a {{ SD }} cluster in multiple availability zones? {#multiple-az}

Yes, a database cluster may include hosts distributed across different availability zones and geographic regions.


#### What is the backup procedure for {{ SD }} clusters? {#backup}

Backups are created every 24 hours and retained for 7 days after creation. Data can only be restored to the point at which the backup was created.


#### How does replication work in {{ SD }}? {#replication}

{{ mmg-short-name }} uses the standard {{ SD }} replication mechanism: if a cluster has more than one active host, a primary server is automatically elected to process write requests.



#### What limitations apply to {{ SD }} database clusters? {#cluster-limitations}

For details on {{ mmg-name }} limitations, see [Quotas and limits](../../storedoc/concepts/limits.md).

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth and reduce the risk of throttling, expand the storage size when [updating your cluster](../../storedoc/operations/update.md#change-disk-size).

For storage using the `network-hdd` disk type, we recommend switching to `network-ssd` or `network-ssd-nonreplicated` via a [cluster restore](../../storedoc/operations/cluster-backups.md#restore) from backup.

#### How do I access the system collection local.oplog.rs? {#oplog-permission}

To grant a user read access to the `oplog`, assign them the `mdbReplication` role in the `admin` database. To do this, run the following command in the {{ yandex-cloud }} CLI:

```bash
{{ yc-mdb-mg }} user update <username> \
  --cluster-name <cluster_name> \
  --permission database=admin,role=mdbReplication,role=<other_role>,... \
  --permission database=<other_DB_name>,role=<role>,...
```

When running this command, include both existing and new roles to prevent the removal of the user’s current permissions.

#### Can I connect to cluster hosts over SSH or get superuser privileges on them? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get a revocation check error when obtaining an SSL certificate via PowerShell? {#get-ssl-error}

Complete error message:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This indicates that the verification of the website’s certificate against the revocation list failed during the connection attempt.

To fix this error:

* Make sure your corporate network policies are not blocking the verification.
* Run the following command with the `--ssl-no-revoke` flag:

  ```powershell
   mkdir $HOME\.mongodb; curl.exe --ssl-no-revoke -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```