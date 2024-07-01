# RAW

Type of test data for the Pandora load generator. Similar to the [PHANTOM](phantom.md) data type. It allows sending any combinations of HTTP requests based on any methods.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```
73 good
GET / HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)

77 bad
GET /abra HTTP/1.0
Host: xxx.tanks.example.com
User-Agent: xxx (shell 1)
```

When configuring the Pandora load generator using a YAML file, specify the `raw` type in the `ammo` section:

```
config_content:
   pools:
   - id: HTTP
      ammo:
         type: raw
         file: ./ammo.raw
```

When uploading a file with test data via the management console, data types and paths are filled in automatically.