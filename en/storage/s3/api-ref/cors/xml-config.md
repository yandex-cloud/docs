# CORS configuration of buckets

{{ objstorage-name }} lets you manage bucket [CORS configurations](../../../concepts/cors.md). To upload the CORS configuration to {{ objstorage-name }}, you need to create an XML document as described in this section. You can obtain a document in this format by downloading an existing configuration.

General configuration format:

```
<CORSConfiguration>
    <CORSRule>
        <AllowedOrigin>URL</AllowedOrigin>
        <AllowedMethod>HTTP_Method</AllowedMethod>
        <AllowedHeader>Header_Name</AllowedHeader>
        ...
    </CORSRule>
    ...
</CORSConfiguration>
```

A configuration may contain up to 100 rules.

## Elements {#elements}

| Element | Description |
----- | -----
| `CORSConfiguration` | Root element of a CORS configuration. It may contain a maximum of 100 `CORSRule` elements.<br/><br/>Path: `/CORSConfiguration`. |
| `CORSRule` | Rule for filtering incoming requests to the resource. Each rule must contain at least one `AllowedMethod` and `AllowedOrigin` element.<br/><br/>Path: `/CORSConfiguration/CORSRule`. |
| `ID` | Unique rule ID (up to 255 characters).<br/><br/>This is an optional parameter. You can use it to search for a rule in a file.<br/><br/>Path: `/CORSConfiguration/CORSRule/ID`. |
| `AllowedMethod` | HTTP method (`PUT`, `GET`, `HEAD`, `POST`, or `DELETE`) that can be used in a cross-domain request. Each method should be specified in a separate element. Specify at least one method.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedMethod`. |
| `AllowedOrigin` | Website that allows sending cross-domain requests to a bucket. Specify at least one `AllowedOrigin` element.<br/><br/>It may contain no more than one `*` character. Examples: `http://*.example.com`, `*`.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedOrigin`. |
| `AllowedHeader` | Header allowed in a request to an object. If multiple headers are allowed, specify each one in a separate `AllowedHeader` element. You can use a single `*` character in the header name to define a template. For example, `<AllowedHeader>*</AllowedHeader>` means that all headers are allowed.<br/><br/>An [options](../object/options.md) request contains the `Access-Control-Request-Headers` header. {{ objstorage-name }} maps the headers passed in `Access-Control-Request-Headers` to the `AllowedHeader` set and returns a list of allowed headers in response to the `options` request.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedHeader`. |
| `MaxAgeSeconds` | Time in seconds during which the results of [options](../object/options.md) requests to resources are cached by the browser.<br/><br/>Path: `/CORSConfiguration/CORSRule/MaxAgeSeconds`. |
| `ExposeHeader` | Header that can be displayed in a JavaScript app in the browser. If multiple headers are allowed, specify each of them in a separate element.<br/><br/>When sending a request to an object, the JavaScript client can only use the headers specified in `ExposeHeader` elements.<br/><br/>Path: `/CORSConfiguration/CORSRule/ExposeHeader`. |


## Example {# example}

This configuration allows you to send cross-domain requests from the `http://www.example.com` website using the `PUT`, `POST`, and `DELETE` methods without any header restrictions.

```
<CORSConfiguration>
    <CORSRule>
        <AllowedOrigin>http://www.example.com</AllowedOrigin>
        <AllowedMethod>PUT</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>DELETE</AllowedMethod>
        <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}