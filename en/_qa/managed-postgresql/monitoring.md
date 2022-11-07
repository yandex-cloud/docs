# Monitoring and logs

#### Where can I track my use of disk space to avoid exceeding the 95% read-only limit? {#disk-space}

You can track your disk space:
* In the management console using [cluster status monitoring tools](../../managed-postgresql/operations/monitoring.md#monitoring-cluster).
* In [{{ monitoring-full-name }}]{% if lang == "ru" %}(https://monitoring.cloud.yandex.ru/){% endif %}{% if lang == "en" %}(https://monitoring.cloud.yandex.com/){% endif %} that lets you [set up notifications](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for specified metrics.

#### Are logs stored on the same disk as {{ PG }} data? How are they charged? {#logs-storage}

Logs are stored on different disks than data and rotated automatically. You can view log information using the [CLI](../../cli/) command below:

```
yc managed-postgresql cluster list-logs <cluster ID>
```

Cluster log storage is free of charge.

#### What is WAL and what is it used for? {#wal}

[Write-Ahead Logs]{% if lang == "ru" %}(https://postgrespro.ru/docs/postgresql/12/wal-intro){% endif %}{% if lang == "en" %}(https://postgrespro.com/docs/postgresql/12/wal-intro){% endif %} are required for data writes to disk and for data replication. These are created by write requests and take up disk space until log data is written out to host disks, making DBMS reliable and failure-tolerant.

For more information about {{ PG }}, see the [official documentation]{% if lang == "ru" %}(https://postgrespro.ru/docs/postgresql/12){% endif %}{% if lang == "en" %}(https://postgrespro.com/docs/postgresql/12){% endif %}.

#### What does the Cached parameter mean for {{ PG }} cluster host RAM monitoring? {#cached}

Cached stores cached data. Most operations are performed in random-access memory, since this is where all database information is stored. Caching is applied both to databases and to disks, which may cause the amount of cached data to exceed the storage size.

If the amount of RAM used by applications increases, some of the cache memory may be released.

For more information about caching disk data in Linux, see the [documentation](https://www.linuxatemyram.com/).

#### How do I get notified of critical {{ PG }} cluster parameters? {#notifications}

Use [{{ monitoring-full-name }}]{% if lang == "ru" %}(https://monitoring.cloud.yandex.ru/){% endif %}{% if lang == "en" %}(https://monitoring.cloud.yandex.com/){% endif %} and [set up notifications](../../managed-postgresql/operations/monitoring.md#monitoring-integration) for those parameters that are critical for you.
