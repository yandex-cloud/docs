# PHANTOM

Type of test data for the Phantom load generator. Allows sending any combination of any HTTP requests to the server as is. With this format, you can make complex combinations of requests. It is well suited for generating requests from service logs, but not for manual configuration.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

```
<byte_length> [tag]\n<request>\r\n<request_headers>\r\n\r\n[request_body]\n[\n]<request2_byte_length> [request2_tag]...
```

Note that the length is specified in bytes and not in characters.

Example of a minimal set of test data (line feeds after the query string and header must end with `\r\n`):

```
37
GET / HTTP/1.0
Host: example.com
```

There can be any number of empty lines between requests in a file, as long as there is no header specifying the size.

For sample generators of payloads in this format, see the load testing tool [documentation](https://yandextank.readthedocs.io/en/latest/ammo_generators.html).