# URI

Type of test data used for describing HTTP `GET` requests. Allows you to set different headers for different requests and specify request tags. Used in Pandora and Phantom load generators.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```
[Header_name: header_value]
uri1 
uri2 tag
```

You can add headers anywhere in the file. They are applied to all URIs specified after the header. The list loops until the required number of requests per second is reached.

When configuring the Pandora load generator using a file, specify the `uri` type in the `ammo` section:

```
config_content:
          pools:
           - id: HTTP
             ammo:
               type: uri
               file: ./ammo.uri
```

When uploading a file with test data via the management console, this is done automatically.