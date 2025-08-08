### {{ ES }} version not supported {#elastic-version}

The transfer fails with this error:

```text
failed to execute elasticsearch activate hook: failed to dump source indexes info: unable to get source indexes 
list: failed to fetch schema, index deals : failed to amend schema based on sample data: failed to unmarshal sample 
document, index: deals, err: json: cannot unmarshal number into Go struct field searchResults.hits.total of type 
elastic.total
```

This error occurs if you use {{ ES }} versions lower than 7.x, which are not supported.

**Solution**: Update {{ ES }} to version 7.x or higher.

