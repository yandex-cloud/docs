# Using pg_cron in {{ mpg-name }}

The [pg_cron](https://github.com/citusdata/pg_cron) extension is a job scheduler allowing you to schedule database tasks and run SQL queries directly within a job.

## Install the pg_cron extension in your {{ PG }} cluster {#pg_cron-install}

To install `pg_cron` in a {{ PG }} cluster:

1. [Load the shared library](./cluster-extensions.md#libraries-connection) `pg_cron` into your cluster.
1. [Enable](./cluster-extensions.md#update-extensions) the `pg_cron` extension in one of your databases. You cannot enable this extension for two databases.

    {% note warning %}

    Installing `pg_cron` will trigger a rolling restart of {{ PG }} on all cluster hosts.

    {% endnote %}

1. [Assign](../grant.md#grant-privilege) the [`mdb_admin` role](../../concepts/roles.md#mdb-admin) to the user who will be managing the jobs.

The database will now contain the `cron` schema with tables and functions required for the extension:

* Tables:

    * `cron.job`: Contains scheduled jobs. You can run `SELECT` queries on this table.
    * `cron.job_run_details`: Contains extension run history. You can run `SELECT`, `UPDATE`, and `DELETE` queries on this table.

* Functions:

    * `schedule`: Creates a job in the database with the installed `pg_cron` extension.
    * `schedule_in_database`: Creates a job in a different database.
    * `unschedule`: Deletes a job.
    * `alter_job`: Alters a job.

To learn more about the `pg_cron` extension, see its [official documentation](https://github.com/citusdata/pg_cron).
