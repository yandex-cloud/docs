#### Why should I use {{ SD }} in {{ mmg-short-name }} rather than my own VM-based installation? {#storedoc-advantages-vm}

{{ mmg-short-name }} automates routine database maintenance:

- Quick DB deployment with the required available resources.
- Data backup.
- Regular software updates.
- Ensuring DB cluster fault tolerance.
- Database usage monitoring and statistics.


#### What happens to a cluster if one of its hosts fails? {#node-out}

If there are more than one replica in the database cluster, it will continue working if a host fails.

The only way data may be lost is if the cluster's only host fails.


#### Can I deploy a {{ SD }} cluster in multiple availability zones? {#multiple-az}

Yes. A database cluster may consist of hosts that reside in different availability zones and even different availability regions.


#### What is the backup procedure for {{ SD }} clusters? {#backup}

Backups are created every 24 hours and retained for seven days. You can only restore data as of the backup creation time.


#### How does replication work for {{ SD }}? {#replication}

{{ mmg-short-name }} uses the standard {{ SD }} replication mechanism: if a cluster has more than one active host, one of them is automatically selected as the primary server to handle write requests.



#### What limitations are there for {{ SD }} database clusters? {#cluster-limitations}

For more info on limitations in {{ mmg-name }}, see the [Quotas and limits](../../storedoc/concepts/limits.md) section.

#### Why is my cluster slow even though there are still some computing resources to spare? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when [updating your cluster](../../storedoc/operations/update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../../storedoc/operations/cluster-backups.md#restore) from a backup.

#### How do I get access to the local.oplog.rs service collection? {#oplog-permission}

To grant a user read access to `oplog`, assign them the `mdbReplication` role in the `admin` database. Do it by executing the following command in the {{ yandex-cloud }} CLI:

```bash
{{ yc-mdb-mg }} user update <username> \
  --cluster-name <cluster_name> \
  --permission database=admin,role=mdbReplication,role=<other_role>,... \
  --permission database=<other_DB_name>,role=<role>,...
```

To avoid deleting user roles that are already assigned, list both the existing and new roles in the command.

#### Can I connect to cluster hosts over SSH or get superuser privileges on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get a revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means, when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure the corporate network settings do not block the check.
* Run the following command with the `--ssl-no-revoke` parameter:

  ```powershell
   mkdir $HOME\.mongodb; curl.exe --ssl-no-revoke -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```