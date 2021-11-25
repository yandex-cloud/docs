### Bash {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y postgresql-client
```

Подключитесь к базе данных:

{% list tabs %}

* Подключение без SSL

  ```bash
  psql "host=c-<идентификатор кластера>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=disable \
        dbname=<имя БД> \
        user=<имя пользователя>"
  ```

* Подключение с SSL

  ```bash
  psql "host=c-<идентификатор кластера>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=verify-full \
        dbname=<имя БД> \
        user=<имя пользователя>"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```

### PowerShell {#powershell}

Перед подключением установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) актуальной версии. Выберите только установку *Command Line Tools*.

Подключитесь к базе данных:

{% list tabs %}

* Подключение без SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=disable `
      dbname=<имя БД> `
      user=<имя пользователя>"
  ```

* Подключение c SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=verify-full `
      dbname=<имя БД> `
      user=<имя пользователя>"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```
