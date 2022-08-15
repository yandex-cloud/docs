# pg_cron

The [pg_cron](https://github.com/citusdata/pg_cron) extension is a job scheduler that enables you to add scheduled jobs to a database and execute SQL commands directly from a job.

## Install the pg_cron extension in a {{ PG }} cluster {#pg_cron-install}

To install the `pg_cron` extension in a {{ PG }} cluster:

1. [Enable the shared library](./cluster-extensions.md#libraries-connection) with the name `pg_cron` for a cluster.
1. [Add](./cluster-extensions.md#update-extensions) the `pg_cron` extension to one of the databases. You cannot enable the extension for two databases.

   {% note warning %}

   Installing the `pg_cron` extension will cause {{ PG }} to restart sequentially on all cluster hosts.

   {% endnote %}

1. [Add a user](../grant.md#grant-privilege) with the [`mdb_admin` role](../../concepts/roles.md#mdb-admin) to manage the tasks.

In the selected database, the `cron` schema with tables and functions required for the extension to work will appear:

* Tables:

   * `cron.job`: Contains scheduled jobs. The `SELECT` command is allowed.
   * `cron.job_run_details`: Contains the history of runs. The `SELECT`, `UPDATE`, and `DELETE` commands are allowed.

* Functions:

   * `schedule`: Creates a job in the database where the `pg_cron` extension is installed.
   * `schedule_in_database`: Creates a job in another database.
   * `unschedule`: Deletes a job.
   * `alter_job`: Changes a job.

To learn more about the `pg_cron` extension, see the [official documentation](https://github.com/citusdata/pg_cron).

{% note warning %}

The `schedule_in_database` function is used to create a job in another database even if the user doesn't have the necessary permission. After installing the `pg_cron` extension, the user with the `mdb_admin` role can circumvent access rights restrictions.

{% endnote %}
