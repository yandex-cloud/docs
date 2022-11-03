# Questions about {{ MS }}

#### How do I import data to a {{ MS }} database cluster in {{ mms-short-name }}? {#migrate}

#### What {{ MS }} versions does {{ mms-short-name }} support? {#supported-version}

#### Is DB cluster backup enabled by default? {#backup}

Yes, backup is enabled by default. For {{ MS }} clusters, a full backup is performed once a day, saving all the database cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

#### Are {{ MS }} database cluster connections encrypted? {#encryption}

Connections between a database cluster and an application are always encrypted using SSL. You cannot disable cluster connection encryption.

#### What is a read-only replica in {{ MS }}? {#read-only-instance}

A read-only replica is a host in a {{ MS }} DB cluster that can only be read. Its data is synced with the master host (applies only if the cluster has more than 1 host). You can use a read-only replica to reduce the load on the DB master host with a large number of read requests.

#### What limitations are imposed on {{ MS }} database clusters? {#instance-limitations}

For more information about {{ mms-short-name }} limitations, see [{#T}](../../managed-sqlserver/concepts/limits.md). Characteristics of clusters that can be created using {{ mms-short-name }} are given in [{#T}](../../managed-sqlserver/concepts/instance-types.md).

