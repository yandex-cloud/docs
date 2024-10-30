### Unable to create objects involving extension functions {#extension-functions}

Error message:

```text
Unable to apply DDL of type 'TABLE', <object_name>, error:
failed to push non-row item 0 of kind "pg:DDL" in batch:
Push failed: ERROR: function <schema_name>.<function_name>() does not exist 
(SQLSTATE 42883)
```

In {{ mpg-name }}, you cannot install an extension into a custom schema in a target database. This means the transfer will be interrupted if the user installation of {{ mpg-name }} has extensions installed in a custom schema and these extensions are used in the DDLs of objects you are moving.

**Solution**: check the DDLs of objects whose names appear in the error. If these objects can call a function from a custom schema, manually create DDLs in the target that call functions without specifying a schema. Set the target endpoint cleanup policy to `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` to prevent the transfer from deleting these objects.
