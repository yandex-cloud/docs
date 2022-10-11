### Duplicate rows in a target database {#duplicates}

Possible cause:

* A target database contains pre-transfer data.

   **Solution:** delete the data from the target database before the transfer is activated or set the `Drop` cleanup policy in the target endpoint.

* There is no primary key in the target database tables.

   **Solution:** make sure the tables in the target database have primary keys.
