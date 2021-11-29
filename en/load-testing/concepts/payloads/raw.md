# RAW

A type of payload for the Pandora load generator. Similar to the [PHANTOM](phantom.md) data type.

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

When configuring the Pandora load generator using a file, specify the `raw` type in the `ammo` section:

```
config_content:
          pools:
           - id: HTTP
             ammo:
               type: raw
               file: ./ammo.raw
```

When uploading a file with a payload via the management console, data types and paths are substituted automatically.