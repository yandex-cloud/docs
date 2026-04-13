#### Do I need to run ANALYZE and/or REINDEX and refresh statistics (pg_stat_user_tables and pg_statistic) manually after upgrading the major {{ PG }} version? {#version-update-manual}

You do not need to run `ANALYZE` and/or `REINDEX` and refresh statistics manually after upgrading the major version. This is done automatically after the upgrade.

[Learn more about upgrading the major {{ PG }} version in {{ mpg-name }}](../../managed-postgresql/concepts/upgrade.md).

#### Does {{ mpg-name }} check that the collation version has changed after upgrading the major {{ PG }} version? {#version-update-collation}

`collation` versions do not change when upgrading the major version, so version checks are not performed.

#### How do I access logs and generated scripts after upgrading the major {{ PG }} version?{#version-update-get-logs}

The process logs are not available to users. If a preliminary check (`--check`) or an upgrade fails, the necessary details are displayed in an error message.

#### Can a major version upgrade fail? {#version-update-error}

An upgrade may fail due to conflicts in the data schema, incompatibility of extensions, or stored procedures. The specific reason is shown in the error message.