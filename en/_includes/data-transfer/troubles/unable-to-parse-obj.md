### Unable to parse an object name {#unable-to-parse-obj}

Error message:

```text
failed to list and filter tables in source:
filter failed: unable to filter transfer objects:
unable to parse obj: <any.object.name>:
identifier '<any.object.name>' contains 3 parts instead of maximum two
```

This error occurs if the list of objects to transfer has a name split by two or more periods.

**Solution:** Enclose the object name in double quotes, e.g., `"<any.object.name>"`.