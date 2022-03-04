### Bash {#bash}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y postgresql-client
```

Connect to a database:

{% list tabs %}

- Connecting without using SSL

  ```bash
  psql "host=c-<cluster ID>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=disable \
        dbname=<DB name> \
        user=<username>"
  ```

- Connecting via SSL

  ```bash
  psql "host=c-<cluster ID>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=verify-full \
        dbname=<DB name> \
        user=<username>"
  ```

{% endlist %}

After running the command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```

### PowerShell {#powershell}

Before connecting, install the current version of [{{ PG }} for Windows](https://www.postgresql.org/download/windows/). Select the *Command Line Tools* install only.

Connect to a database:

{% list tabs %}

- Connecting without using SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
      host=c-<cluster ID>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=disable `
      dbname=<DB name> `
      user=<username>"
  ```

- Connecting with SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
      host=c-<cluster ID>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=verify-full `
      dbname=<DB name> `
     user=<username>"
  ```

{% endlist %}

After running the command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```
