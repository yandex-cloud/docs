---
title: Tutorials for building a data platform based on {{ yandex-cloud }}
description: This page provides a list of tutorials for building a data platform based on {{ yandex-cloud }} using various DBMS.
---


# Building a data platform based on {{ yandex-cloud }}


## Data migration and DBMS version upgrades {#migration}

Migration is a task that involves transferring data from one storage system to another, e.g., from on-premises databases to managed cloud databases, between clusters, or with a change of the DBMS type. The tutorials in this group describe migration scenarios for {{ MY }}, {{ PG }}, {{ CH }}, {{ GP }}, {{ MG }}, {{ ydb-short-name }}, {{ OS }}, and other systems, as well as database version upgrades with minimal downtime.

{% cut "Full list of tutorials" %}

* [{#T}](rdbms-to-clickhouse.md)
* [{#T}](mysql-data-migration/index.md)
* [{#T}](postgresql-data-migration.md)
* [{#T}](valkey-data-migration.md)
* [{#T}](mmy-to-mysql-migration.md)
* [{#T}](mysql-to-clickhouse.md)
* [{#T}](greenplum-to-postgresql.md)
* [{#T}](clickhouse-migration.md)
* [{#T}](ch-to-mch-migration.md)
* [{#T}](mos-migration-from-standalone.md)
* [{#T}](mos-migration-from-standalone.md)
* [{#T}](storedoc-data-migration.md)
* [{#T}](yds-obj-migration.md)
* [{#T}](rds-to-mpg.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](mmy-to-mpg.md)
* [{#T}](mpg-to-mmy.md)
* [{#T}](mmy-to-mgp.md)
* [{#T}](mmy-to-mpg.md)
* [{#T}](mpg-to-mmy.md)
* [{#T}](objs-mmy-migration.md)
* [{#T}](bigquery-to-clickhouse.md)
* [{#T}](mmy-ydb-migration.md)
* [{#T}](mmy-objs-migration.md)
* [{#T}](greenplum-to-clickhouse.md)
* [{#T}](postgresql-versions.md)
* [{#T}](storedoc-versions.md)
* [{#T}](hdfs-cluster-migration.md)
* [{#T}](zk-kraft-kafka-migration.md)

{% endcut %}


## Replication and streaming data change capture {#replication}

Replication and CDC (Change Data Capture) are processes for continuous tracking of changes at the source and delivering them to the target in real time. The tutorials of this group describe the configuration of cross-cluster replication, change capture with the help of Debezium, and delivery of data streams to target systems.

{% cut "Full list of tutorials" %}

* [{#T}](debezium-mmy.md)
* [{#T}](debezium-mpg.md)
* [{#T}](mpg-ydb-replication.md)
* [{#T}](ydb-mkf-replication.md)
* [{#T}](debezium-yq.md)
* [{#T}](sync-mysql.md)
* [{#T}](outbound-replication.md)
* [{#T}](mpg-replication-overview.md)
* [{#T}](schema-registry-cdc-debezium-kafka.md)

{% endcut %}


## Data loading and delivery {#loading-delivery}

The tutorials describe architectural patterns for building data streams: from sources (external databases, files, logs, brokers) to storage systems and back. They cover scenarios including streaming via {{ DS }}, event delivery from {{ KF }} and {{ RMQ }}, batch loading, and end-to-end transfer via {{ data-transfer-name }}. 

{% cut "Full list of tutorials" %}

* [{#T}](data-ingestion.md)
* [{#T}](log-ingestion.md)
* [{#T}](message-broker.md)
* [{#T}](insert-data-ch.md)
* [{#T}](fetch-data-from-mkf.md)
* [{#T}](fetch-data-from-rabbitmq.md)
* [{#T}](use-ksqldb-with-mkf.md)
* [{#T}](yds-to-kafka.md)
* [{#T}](mkf-yds-stream.md)
* [{#T}](mkf-ydb-stream.md)
* [{#T}](yds-to-clickhouse.md)
* [{#T}](yds-to-ydb.md)
* [{#T}](ydb-to-yds.md)
* [{#T}](mkf-to-mpg.md)
* [{#T}](managed-kafka-to-greenplum.md)
* [{#T}](kafka-connector.md)
* [{#T}](kafka-connect.md)
* [{#T}](data-transfer-mkf.md)
* [{#T}](data-transfer-mmy.md)
* [{#T}](data-transfer-mpg.md)
* [{#T}](data-transfer-mkf-mch.md)
* [{#T}](data-transfer-mkf-mmg.md)
* [{#T}](data-transfer-mkf-mmy.md)
* [{#T}](data-transfer-mkf-mos.md)
* [{#T}](data-transfer-direct-to-mch.md)
* [{#T}](managed-greenplum.md)
* [{#T}](managed-mysql.md)
* [{#T}](managed-mysql-to-mysql.md)
* [{#T}](managed-postgresql.md)
* [{#T}](storedoc.md)
* [{#T}](mmy-to-yds.md)
* [{#T}](mpg-to-yds.md)

{% endcut %}


## Integration and exchange between data storage and processing systems {#integration}

The tutorials of this group describe bidirectional data exchange between heterogeneous storage and computing systems: {{ CH }}, {{ GP }}, {{ PG }}, {{ ydb-short-name }}, {{ OS }}, {{ objstorage-name }}, and external DBMSs via JDBC. The scenarios include delivering data from analytical clusters to relational databases, data exchange between {{ objstorage-name }} and managed database services, and integration between {{ OS }} and other storage solutions.

{% cut "Full list of tutorials" %}

* [{#T}](dp-mch-data-exchange.md)
* [{#T}](data-processing-to-data-processing.md)
* [{#T}](s3-data-processing-ch.md)
* [{#T}](data-processing-and-kafka.md)
* [{#T}](jdbc-ch-to-sql-server-integration.md)
* [{#T}](jdbc-ch-to-oracle-integration.md)
* [{#T}](spark-objstorage-integration.md)
* [{#T}](mpg-pg-clickhouse-extension.md)
* [{#T}](object-storage-to-clickhouse.md)
* [{#T}](object-storage-to-greenplum.md)
* [{#T}](object-storage-to-postgresql.md)
* [{#T}](object-storage-to-ydb.md)
* [{#T}](opensearch-to-clickhouse.md)
* [{#T}](opensearch-to-greenplum.md)
* [{#T}](opensearch-to-ydb.md)
* [{#T}](opensearch-to-object-storage.md)
* [{#T}](postgresql-to-opensearch.md)
* [{#T}](ydb-to-clickhouse.md)
* [{#T}](mpg-to-objstorage.md)
* [{#T}](ydb-to-object-storage.md)

{% endcut %}


## Analytical calculations {#analytical}

Tutorials on how to run analytical jobs: {{ SPRK }}, PySpark, {{ metastore-name }}, MapReduce. This includes scenarios for remote running of jobs, data reading and writing, {{ SPRK }} integration with {{ metastore-name }} and {{ ml-platform-short-name }}, and loading data from relational sources via Sqoop.

{% cut "Full list of tutorials" %}

* [{#T}](hive-job-basics.md)
* [{#T}](mapreduce-job-basics.md)
* [{#T}](pyspark-job-basics.md)
* [{#T}](spark-job-basics.md)
* [{#T}](how-to-use-hive.md)
* [{#T}](run-spark-job.md)
* [{#T}](remote-run-job.md)
* [{#T}](spark-simple-rw-job.md)
* [{#T}](yt-run-spark-job.md)
* [{#T}](metastore-and-spark.md)
* [{#T}](metastore-import.md)
* [{#T}](spark-and-datasphere.md)
* [{#T}](sqoop-mmy.md)
* [{#T}](sqoop-mpg.md)

{% endcut %}


## Pipeline orchestration {#pipeline-orchestration}

Tutorials on describing the automation and planning the execution of data processing jobs using {{ AF }}. These scenarios include auto-running jobs, use of the Python SDK inside a DAG, joint execution of {{ AF }} and {{ SPRK }}, and setting up email notifications in the event of pipeline failures.

{% cut "Full list of tutorials" %}

* [{#T}](airflow-auto-tasks.md)
* [{#T}](using-python-sdk-in-airflow.md)
* [{#T}](airflow-and-spark.md)
* [{#T}](airflow-spark-min.md)
* [{#T}](data-processing-and-airflow.md)
* [{#T}](airflow-test-smtp-notification.md)

{% endcut %}


## Storage, archiving, and data lifecycle {#storage-archiving}

Tutorials on data lifecycle management in storage systems: hybrid storage, sharding, cold storage policies and index rotation in {{ OS }}, retention policies, data archiving.

{% cut "Full list of tutorials" %}

* [{#T}](clickhouse-hybrid-storage.md)
* [{#T}](clickhouse-sharding.md)
* [{#T}](storedoc-sharding.md)
* [{#T}](opensearch-cold-storage-policy.md)
* [{#T}](opensearch-index-policy.md)
* [{#T}](greenplum-yezzey.md)
* [{#T}](retention-policy.md)
* [{#T}](kafka-topic-s3-sync-private.md)

{% endcut %}


## Performance and diagnostics {#productivity-diagnostics}

Bottleneck diagnostics, profiling, and troubleshooting performance issues in DBMSs and processing services. These scenarios will help you quickly isolate and fix issues related to load and query execution speed.

{% cut "Full list of tutorials" %}

* [{#T}](mpg-performance-problems.md)
* [{#T}](mpg-profiling.md)
* [{#T}](profiling-mmy.md)
* [{#T}](storedoc-profiling.md)
* [{#T}](postgresql-glibc-collation-issues.md)

{% endcut %}


## Monitoring, logs, audit, billing {#monitoring-logs}

Tutorials on how to process and analyze various types of telemetry including audit logs, {{ cloud-logging-name }} logs, and detailed billing files, how to set up {{ OS }} notifications and work with Jupyter Notebook in conjunction with {{ yq-full-name }}.

{% cut "Full list of tutorials" %}

* [{#T}](audit-log-processing.md)
* [{#T}](cloud-logging-processing.md)
* [{#T}](billing-detail-files-processing.md)
* [{#T}](opensearch-email-notifications.md)
* [{#T}](jupyter-yq.md)

{% endcut %}


## Security and access {#security-and-access}

Scenarios for configuring secure access to data platform resources: authentication to {{ OS }} via SAML and Keycloak, secret management when running PySpark jobs and via {{ connection-manager-name }}, and setting up DNS peering for a private {{ CH }} network.

{% cut "Full list of tutorials" %}

* [{#T}](opensearch-saml-keycloak.md)
* [{#T}](job-pyspark-secret-access.md)
* [{#T}](conn-man-secret-access.md)
* [{#T}](clickhouse-dns-peering.md)

{% endcut %}


## Data schema management {#data-management}

{{ schema-registry-name }} is a service made to store and manage message schemas in Avro, JSON Schema, and Protobuf formats. The scenarios include creating and configuring a managed {{ schema-registry-name }}, working with REST APIs, and integration with Confluent Schema Registry to ensure data compatibility in stream processing.

{% cut "Full list of tutorials" %}

* [{#T}](schema-registry-overview.md)
* [{#T}](managed-schema-registry.md)
* [{#T}](managed-schema-registry-rest.md)
* [{#T}](confluent-schema-registry.md)

{% endcut %}


## Cluster deployment and configuration {#cluster-deployment}

Specialized configuration and deployment scenarios for managed database clusters: installing the {{ KF }} web interface, setting up a web server with a configuration file for the `s3` protocol, initialization in {{ dataproc-short-name }} via init scripts, using a {{ PG }} cluster for 1C, storing PHP sessions in a {{ mrd-name }} cluster, setting up {{ mch-name }} for Graphite, PXF named queries, and connecting a lemmatizer to {{ OS }}.

{% cut "Full list of tutorials" %}

* [{#T}](deploy-kafka-ui.md)
* [{#T}](mgp-config-server-for-s3.md)
* [{#T}](data-processing-init-actions-geesefs.md)
* [{#T}](1c-postgresql.md)
* [{#T}](valkey-as-php-sessions-storage.md)
* [{#T}](clickhouse-for-graphite.md)
* [{#T}](pxf-named-queries.md)
* [{#T}](opensearch-yandex-lemmer.md)
* [{#T}](mos-mcp.md)
* [{#T}](1c-valkey-locks.md)
* [{#T}](../infrastructure-management/yc-valkey-as-1c-cache-storage.md)
* [{#T}](valkey-rag-search.md)

{% endcut %}
