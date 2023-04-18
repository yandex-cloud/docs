### Cannot transfer data {#no-transfer}

An attempt to transfer data from the {{ CH }} source fails with this error:

```text

Syntax error: failed at position 25 ('-'): <error details>. Expected one of: token, Dot, UUID, alias, AS, identifier, FINAL, SAMPLE, INTO OUTFILE, FORMAT, SETTINGS, end of query

```

**Solution:**

{{ data-transfer-full-name }} cannot transfer a database if its name contains a hyphen. You need to rename your database, if you can.