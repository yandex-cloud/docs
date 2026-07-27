# Editing a {{ PG }} database

If you have a {{ PG }} database in your [cluster](../../concepts/components/postgresql.md), you can edit its settings.

## Using the CLI {#cli}

1. Open the `PostgresqlDatabase` resource, e.g., by running this command: `kubectl edit PostgresqlDatabase <resource_name> -n <project_name>`.
1. Edit the parameters:

    * `spec.owner`: Database owner role.
    * `spec.allowConnections`: Permission to connect to the database.
    * `spec.connectionLimit`: Limit on simultaneous connections. If set to `-1`, there is no limit.
    * `spec.isTemplate`: Use the database as a template to create other databases.
    * `spec.tablespace`: Default tablespace.
    * `spec.schemas`: List of managed schemas. To delete a schema, set the value to `state: absent` or delete the item from the list.

1. Apply the manifest: `kubectl apply -f postgresqldatabase.yaml -n <project_name>`.

Once the database is created, you cannot change the `name`, `template`, `encoding`, `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`, or `collationVersion` field.
