# Using pg_cron in {{ mpg-name }}

The [pg_cron](https://github.com/citusdata/pg_cron) extension is a job scheduler that enables you to add scheduled jobs to a database and execute SQL commands directly from a job.

## Install the pg_cron extension in a {{ PG }} cluster {#pg_cron-install}

To install `pg_cron` in a {{ PG }} cluster:

1. [Connect the shared library](./cluster-extensions.md#libraries-connection) named `pg_cron` to your cluster.
1. [Add](./cluster-extensions.md#update-extensions) the `pg_cron` extension to one of the databases. You cannot enable the extension for two databases.

    {% note warning %}

    Installing `pg_cron` will restart {{ PG }} on all cluster hosts one by one.

    {% endnote %}

1. [Add a user](../grant.md#grant-privilege) with the [`mdb_admin` role](../../concepts/roles.md#mdb-admin) or [`mdb_superuser` role](../../concepts/roles.md#mdb-superuser) to manage the jobs.

In the selected database, the `cron` schema with tables and functions required for the extension to work will appear:

* Tables:

    * `cron.job`: Contains scheduled jobs. The `SELECT` command is allowed.
    * `cron.job_run_details`: Contains the history of extension runs. The `SELECT`, `UPDATE`, and `DELETE` commands are allowed.

* Functions:

    * `schedule`: Creates a job in the database where the `pg_cron` extension is installed.
    * `schedule_in_database`: Creates a job in another database.
    * `unschedule`: Deletes a job.
    * `alter_job`: Modifies the job.

To learn more about the `pg_cron` extension, see its [official documentation](https://github.com/citusdata/pg_cron).
