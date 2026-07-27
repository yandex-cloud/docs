# Creating a {{ PG }} database

If you have a [{{ PG }} cluster](../../concepts/components/postgresql.md) in your [project](../projects/create-project.md), you can create a database in it. Use a `PostgresqlDatabase` resource to define the database. Set the database owner using the `spec.owner` field. It must match an existing {{ PG }} role. For details, see [{#T}](create-user.md).

## Using the CLI {#cli}

1. Create the `PostgresqlDatabase` resource file, e.g., using the `touch postgresqldatabase.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Minimum configuration

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-database-min.md) %}

        The manifest defines only the required fields, such as the cluster name, database name, and owner role.

    - libc locale

        Configuration with the `libc` locale provider and the `locale`, `localeCollate`, and `localeCType` parameters.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-database-libc.md) %}

    - ICU locale

        Configuration with the `icu` locale provider and the `icuLocale` and `icuRules` parameters. Available in {{ PG }} and later.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-database-icu.md) %}

    - builtin locale

        Configuration with the `builtin` locale provider and the `builtinLocale` parameter. Available in {{ PG }} and later.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-database-builtin.md) %}

    - Schemas

        Configuration with managed PostgreSQL schemas.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-database-schemas.md) %}

        In the `spec.schemas` section, describe the database schemas by specifying the name, owner (optional), and state (`present` to create or `absent` to delete).

    {% endlist %}

1. Apply the manifest: `kubectl apply -f postgresqldatabase.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

Once the database is created, you cannot change the `name`, `template`, `encoding`, `localeProvider`, `locale`, `localeCollate`, `localeCType`, `icuLocale`, `icuRules`, `builtinLocale`, or `collationVersion` field.
