### Source data update error {#update-not-supported}

Error message:

```text
Push failed: kind: update not supported
```

{{ objstorage-name }} only supports inserting new data but does not support updating it. If data is updated at the source, the transfer will fail with the above error.

**Solution**: Use sources supporting data insertion only or select a target other than {{ objstorage-name }}.
