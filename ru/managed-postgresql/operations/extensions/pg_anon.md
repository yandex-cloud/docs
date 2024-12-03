# Использование postgresql_anonymizer в {{ mpg-name }}

Расширение `postgresql_anonymizer` позволяет замаскировать или заменить в базе данных {{ PG }} персональные данные или информацию, составляющую коммерческую тайну.

Для анонимизации используется декларативный подход: можно объявить правила маскирования с помощью DDL и задать стратегию анонимизации в определении таблицы.

Способы анонимизации данных:
  
  * [Статическое маскирование](https://postgresql-anonymizer.readthedocs.io/en/stable/static_masking/) — заменяет конфиденциальные данные другими в соответствии с правилами маскирования. Восстановить исходные данные невозможно.
  * [Обобщение](https://postgresql-anonymizer.readthedocs.io/en/stable/generalization/) — заменяет значение (число или дату) диапазоном, который содержит это значение.

## Установить расширение postgresql_anonymizer в кластер {{ PG }} {#anon-install}

Чтобы установить расширение `postgresql_anonymizer` в кластер {{ PG }}:

1. [Подключите к кластеру библиотеку общего пользования](./cluster-extensions.md#libraries-connection) с именем `anon`.
1. [Добавьте расширение](./cluster-extensions.md#update-extensions) `anon` к базе данных.

1. [Назначьте владельцу этой базы данных](../grant.md#grant-role) роль `mdb_admin` или `mdb_superuser`, если это еще не сделано.

    Имя владельца можно запросить со [списком баз данных в кластере](../databases.md#list-db).

Подробнее о расширении `postgresql_anonymizer` см. в [официальной документации](https://postgresql-anonymizer.readthedocs.io/en/stable/).

## Пример использования {#usage-example}

В примере используется статическое маскирование: данные заменяются другими по правилам маскирования.

1. [Подключитесь к базе данных](../connect.md#bash) с помощью утилиты `psql`.

1. Создайте таблицу `employees` и наполните ее данными:

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

1. Проверьте результат:

    ```sql
    SELECT * FROM employees;
    ```

    ```text
    id  |       name       |    company      |   code
    ----+------------------+-----------------+-----------
    111 | Maria Belova     | Bank of Saratov |  405-657
    222 | Pavel Petrov     | Head and Hands  |  601-245
    ```

1. Объявите правила маскирования:

    ```sql
    SECURITY LABEL FOR anon ON COLUMN employees.company
    IS 'MASKED WITH FUNCTION anon.fake_company()';

    SECURITY LABEL FOR anon ON COLUMN employees.code
    IS 'MASKED WITH FUNCTION anon.random_zip()';
    ```

1. Замените данные в замаскированных столбцах:

    ```sql
    SELECT anon.anonymize_database();
    ```

1. Убедитесь, что данные в столбцах `company` и `code` изменились:

    ```text
    id  |       name       |           company                |   code
    ----+------------------+----------------------------------+---------
    111 | Maria Belova     | Schneider, Phillips and Martinez |  82175
    222 | Pavel Petrov     | White, Hines and Ramos           |  49306
    ```