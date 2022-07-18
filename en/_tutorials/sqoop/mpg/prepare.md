1. [Connect to the](../../../managed-postgresql/operations/connect.md) `db1` database of the {{ mpg-full-name }} cluster on behalf of `user1`.
1. Add test data to the database. The example uses a simple table with people's names and ages:
   1. Create a table:

      ```sql
      CREATE TABLE persons (
          Name VARCHAR(30) NOT NULL,
          Age INTEGER DEFAULT 0,
          PRIMARY KEY (Name)
      );
      ```

   1. Populate the table with data:

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
