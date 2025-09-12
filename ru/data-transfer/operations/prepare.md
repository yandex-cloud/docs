---
title: Как подготовиться к трансферу
description: Из статьи вы узнаете, как подготовиться к трансферу.
---

# Подготовка к трансферу


## Подготовка источника {#source}

### Источники {{ AB }} {#source-airbyte}

#### Источник AWS CloudTrail {#source-aws}

{% include [prepare aws cloud trail db](../../_includes/data-transfer/endpoints/sources/aws-cloudtrail-prepare.md) %}

#### Источник BigQuery {#source-bigquery}

{% include [prepare bigquery db](../../_includes/data-transfer/endpoints/sources/bigquery-prepare.md) %}

#### Источник Microsoft SQL Server {#source-mssql}

{% include [prepare ms sqlserver db](../../_includes/data-transfer/endpoints/sources/ms-sqlserver-prepare.md) %}

#### Источник S3 {#source-s3}

{% include [prepare s3 db](../../_includes/data-transfer/endpoints/sources/s3-prepare.md) %}


### Источник {{ KF }} {#source-kf}

{% include [prepare kafka db](../../_includes/data-transfer/endpoints/sources/kafka.md) %}

### Источник {{ CH }} {#source-ch}

{% include [prepare clickhouse db](../../_includes/data-transfer/endpoints/sources/clickhouse-prepare.md) %}

### Источник {{ GP }} {#source-gp}


{% include [prepare greenplum db](../../_includes/data-transfer/endpoints/sources/greenplum-prepare.md) %}


### Источник {{ MG }} {#source-mg}


{% include [prepare mongo db](../../_includes/data-transfer/endpoints/sources/mongodb-prepare.md) %}

### Источник {{ MY }} {#source-my}

{% include [prepare mysql db](../../_includes/data-transfer/endpoints/sources/mysql-prepare.md) %}

### Источник {{ OS }} {#source-os}

{% include [prepare elasticsearch db](../../_includes/data-transfer/endpoints/sources/opensearch-prepare.md) %}

### Источник Oracle {#source-oracle}

{% include [prepare oracle db](../../_includes/data-transfer/endpoints/sources/oracle-prepare.md) %}

### Источник {{ PG }} {#source-pg}

{% include [prepare db](../../_includes/data-transfer/endpoints/sources/pg-prepare.md) %}



### Источник {{ yds-full-name }} {#source-yds}

{% include [prepare yds db](../../_includes/data-transfer/endpoints/sources/yds-prepare.md) %}


### Источник {{ ydb-full-name }} {#source-ydb}

{% include [prepare yds db](../../_includes/data-transfer/endpoints/sources/ydb-prepare.md) %}


## Подготовка приемника {#target}

### Приемник {{ CH }} {#target-ch}

{% include [prepare clickhouse db](../../_includes/data-transfer/endpoints/targets/clickhouse-prepare.md) %}

### Приемник {{ GP }} {#target-gp}


{% include [prepare greenplum db](../../_includes/data-transfer/endpoints/targets/greenplum-prepare.md) %}


### Приемник {{ MG }} {#target-mg}


{% include [prepare mongodb db](../../_includes/data-transfer/endpoints/targets/mongodb-prepare.md) %}

### Приемник {{ MY }} {#target-my}

{% include [prepare mysql db](../../_includes/data-transfer/endpoints/targets/mysql-prepare.md) %}

### Приемник {{ objstorage-full-name }} {#target-storage}

{% include [prepare object storage db](../../_includes/data-transfer/endpoints/targets/object-storage-prepare.md) %}

### Приемник {{ OS }} {#target-os}

{% include [prepare opensearch db](../../_includes/data-transfer/endpoints/targets/opensearch-prepare.md) %}

### Приемник {{ PG }} {#target-pg}

{% include [prepare postgresql db](../../_includes/data-transfer/endpoints/targets/pg-prepare.md) %}


### Приемник {{ ydb-full-name }} {#target-ydb}

{% include [prepare ydb db](../../_includes/data-transfer/endpoints/targets/ydb-prepare.md) %}


{% include [airbyte-trademark](../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}