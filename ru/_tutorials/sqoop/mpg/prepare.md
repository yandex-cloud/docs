1. [Подключитесь к базе данных](../../../managed-postgresql/operations/connect.md) `db1` кластера {{ mpg-full-name }} от имени пользователя `user1`.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица с именами и возрастом людей:
    1. Создайте таблицу:

        ```sql
        CREATE TABLE persons (
            Name VARCHAR(30) NOT NULL,
            Age INTEGER DEFAULT 0,
            PRIMARY KEY (Name)
        );
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO persons (Name, Age) VALUES
            ('Anna', 19),
            ('Michael', 65),
            ('Fred', 28),
            ('Alsou', 50),
            ('Max', 27),
            ('John', 34),
            ('Dmitry', 42),
            ('Oleg', 19),
            ('Alina', 20),
            ('Maria', 28);
        ```
