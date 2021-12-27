# URI

A type of payload used for describing HTTP `GET` requests. Lets you set different headers for different requests and specify request tags. Used in Pandora and Phantom load generators.

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

This is done automatically when uploading a file with a payload via the management console.