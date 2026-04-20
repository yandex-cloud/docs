When using {{ metastore-full-name }}, a Hive table may get locked, for example if the script is interrupted.

To remove the lock you can use the following:
* Hive Metastore thrift interface.
* Python script running in the same virtual private network (VPC) as {{ metastore-name }}.

### Removing a lock using a Python script {#unlock-tables-script}

{% note warning %}

{{ metastore-name }} is only accessible via a private VPC IP address and does not have a public DNS name. This provides additional security but requires all services connecting to {{ metastore-name }} to be in the same VPC or have configured network access.

{% endnote %}

To remove retention:

1. Connect to a VM or service that is in the same VPC as {{ metastore-name }}.

1. Install the dependencies:

   ```bash
   pip install click
   pip install hive-metastore-client
   ```

1. Create a file named `unlock.py` and paste the following script to it:

   {% cut "unlock.py" %}

   ```python
   import click

   from hive_metastore_client import HiveMetastoreClient
   from thrift_files.libraries.thrift_hive_metastore_client.ttypes import ShowLocksRequest, UnlockRequest


   class MetastoreClient:
       def __init__(self, metastore_hostname, metastore_port):
           self.metastore_hostname = metastore_hostname
           self.metastore_port = metastore_port
           self.metastore_client = HiveMetastoreClient(metastore_hostname, metastore_port)

       def show_locks(self, db_name, table):
           with self.metastore_client as metastore_client:
               req = ShowLocksRequest(dbname=db_name, tablename=table)
               return metastore_client.show_locks(req)

       def unlock(self, lock_id):
           with self.metastore_client as metastore_client:
               req = UnlockRequest(lockid=lock_id)
               return metastore_client.unlock(req)


   @click.group()
   @click.option(
       "--host",
       required=True,
       help="Metastore host",
   )
   @click.option(
       "--port",
       type=int,
       help="Metastore port",
       default=9083,
   )
   @click.pass_context
   def cli(ctx, host: str, port: int):
       """Hive Metastore CLI."""
       ctx.obj = MetastoreClient(host, port)


   @cli.command("show-locks")
   @click.argument("db_name", required=True)
   @click.argument("table", required=True)
   @click.pass_obj
   def show_locks(client: MetastoreClient, db_name, table):
       """Show locks for table."""
       result = client.show_locks(db_name, table)
       click.echo(result)


   @cli.command("unlock")
   @click.argument("lock_id", required=True, type=int)
   @click.pass_obj
   def unlock(client: MetastoreClient, lock_id):
       """Unlock by lock id."""
       result = client.unlock(lock_id)
       click.echo(result)


   if __name__ == "__main__":
       cli()
   ```

   {% endcut %}

1. To view the list of locks, run this script:

    ```bash
    python unlock.py --host <metastore-host> show-locks <db-name> <table-name>
    ```

    Where:

    * `<metastore-host>`: {{ metastore-name }} private IP address.

       To learn the IP address:
       1. Go to the [resource folder]({{ link-console-main }}) page.
       1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
       1. In the left-hand panel, select ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

    * `<db-name>`: Database name.
    * `<table-name>`: Table name.

1. To remove the lock, run this script:

    ```bash
    python unlock.py --host <metastore-host> unlock <lock-id>
    ```

    Where:

    * `<metastore-host>`: {{ metastore-name }} private IP address.
    * `<lock-id>`: Lock ID.