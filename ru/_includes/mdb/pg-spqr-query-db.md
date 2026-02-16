1. Создайте таблицу `customers` в БД кластера:

    ```sql
    CREATE TABLE IF NOT EXISTS customers (
        name VARCHAR,
        phone VARCHAR,
        acctbal NUMERIC
    );
    ```

1. Наполните таблицу данными:

    ```sql
    INSERT INTO customers (name, phone, acctbal) VALUES
        ('Иван Иванов', '123-45-67', 1500.50),
        ('Мария Смирнова', '222-33-44', 3250.00),
        ('Дмитрий Кузнецов', '555-66-77', -50.75),
        ('Анна Орлова', '111-22-33', 0.00),
        ('Павел Сидоров', '444-55-66', 780.30);
    ```

1. Запросите количество строк в таблице:

    ```sql
    SELECT COUNT(*) FROM customers;
    ```

    Результат:

    ```sql
    count
    -------
        5
    (1 row)
    ```
