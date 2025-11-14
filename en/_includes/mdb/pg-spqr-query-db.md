1. Create a table named `customers` in the cluster database:

    ```sql
    CREATE TABLE IF NOT EXISTS customers (
        name VARCHAR,
        phone VARCHAR,
        acctbal NUMERIC
    );
    ```

1. Populate the table with data:

    ```sql
    INSERT INTO customers (name, phone, acctbal) VALUES
        ('John Doe', '123-45-67', 1500.50),
        ('Mary Johnson', '222-33-44', 3250.00),
        ('David Smith', '555-66-77', -50.75),
        ('Anna Davis', '111-22-33', 0.00),
        ('Paul Brown', '444-55-66', 780.30);
    ```

1. Get the number of rows in the table:

    ```sql
    SELECT COUNT(*) FROM customers;
    ```

    Result:

    ```sql
    count
    -------
        5
    (1 row)
    ```
