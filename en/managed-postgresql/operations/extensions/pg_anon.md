# Using postgresql_anonymizer in {{ mpg-name }}

The `postgresql_anonymizer` extension allows you to mask or replace personal data or commercial secrets in a {{ PG }} database.

The extension utilizes a declarative approach for anonymization: you can declare masking rules using DDL or set an anonymization strategy in the table definition.

Data anonymization methods:
  
  * [Static masking](https://postgresql-anonymizer.readthedocs.io/en/stable/static_masking/): Replaces sensitive information with other data according to the masking rules. This method makes it impossible to restore the original data.
  * [Generalization](https://postgresql-anonymizer.readthedocs.io/en/stable/generalization/): Replaces a value, e.g., number or date, with a range that contains it.

## Installing postresql_anonymizer in a {{ PG }} cluster {#anon-install}

To install `postgresql_anonymizer` in a {{ PG }} cluster:

1. [Load the shared library](./cluster-extensions.md#libraries-connection) `anon` into your cluster.
1. [Add](./cluster-extensions.md#update-extensions) the `anon` extension to your database.

1. [Assign](../grant.md#grant-role) the `mdb_admin` role to the owner of this database, if not assigned yet.

    You can get the owner's name from the [cluster’s database list](../databases.md#list-db).

To learn more about the `postgresql_anonymizer` extension, see its [official documentation](https://postgresql-anonymizer.readthedocs.io/en/stable/).

## Usage example {#usage-example}

In our example, we are using static masking to replace data with other data according to the masking rules.

1. [Connect to the database](../connect/clients.md#bash) using `psql`.

1. Create a table named `employees` and populate it with data:

    ```sql
    CREATE TABLE employees (
      id SERIAL,
      name TEXT,
      company TEXT,
      code TEXT
    );
    
    INSERT INTO employees
    VALUES
    (111,'Maria Belova','Bank of Saratov','405-657'),
    (222,'Pavel Petrov','Head and Hands','601-245')
    ;
    ```

1. Check the result:

    ```sql
    SELECT * FROM employees;
    ```

    ```text
    id  |       name       |    company      |   code
    ----+------------------+-----------------+-----------
    111 | Maria Belova     | Bank of Saratov |  405-657
    222 | Pavel Petrov     | Head and Hands  |  601-245
    ```

1. Define the masking rules:

    ```sql
    SECURITY LABEL FOR anon ON COLUMN employees.company
    IS 'MASKED WITH FUNCTION anon.fake_company()';

    SECURITY LABEL FOR anon ON COLUMN employees.code
    IS 'MASKED WITH FUNCTION anon.random_zip()';
    ```

1. Replace the data in masked columns:

    ```sql
    SELECT anon.anonymize_database();
    ```

1. Verify that the data in the `company` and `code` columns has changed:

    ```text
    id  |       name       |           company                |   code
    ----+------------------+----------------------------------+---------
    111 | Maria Belova     | Schneider, Phillips and Martinez |  82175
    222 | Pavel Petrov     | White, Hines and Ramos           |  49306
    ```