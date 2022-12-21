# Requested database column does not exist

`ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST`

Nonexistent field used.

Possible causes:

* A new field was added to the data source but the dataset has not been updated. To update the dataset, click [Update fields](../../operations/dataset/update-field.md).

* When building a dataset from a {{ CH }} connection, a SQL subquery is used. If this is the case, set an alias for the selected fields.

   Example:

   ```sql
   SELECT DISTINCT
     id as offer_id,
     upper(proposed_meta)
     FROM
   ```

   {{ datalens-short-name }} may incorrectly identify the `upper(proposed_meta)` field, so you need to set an alias for it:

   ```sql
   SELECT DISTINCT
     id as offer_id,
     upper(proposed_meta) as upper_proposed_meta
     FROM
   ```

* When building a dataset, the SQL subquery makes an implicit reference to the selected fields (`SELECT * FROM`). To avoid an error, explicitly list the required fields in the `SELECT` clause.
