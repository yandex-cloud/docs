# CORS configuration of buckets

{{ objstorage-name }} lets you manage bucket [CORS configurations](../../../concepts/cors.md). To upload the CORS configuration to {{ objstorage-name }}, you need to create an XML document as described in this section. You can obtain a document in this format by downloading an existing configuration.

General configuration format:

```xml
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

Element | Description
----- | -----
`CORSConfiguration` | Root element of a CORS configuration. Cannot contain more than 100 elements `CORSRule`<br/><br/>Path: `/CORSConfiguration`.
`CORSRule` | Rule for filtering incoming requests to the resource. Each rule must contain at least one `AllowedMethod` and `AllowedOrigin` element.<br/><br/>Path: `/CORSConfiguration/CORSRule`.
`ID` | Unique rule ID (maximum 255 characters).<br/><br/>Optional. You can use it to search for a rule in a file.<br/><br/>Path: `/CORSConfiguration/CORSRule/ID`.
`AllowedMethod` | HTTP method (`PUT`, `GET`, `HEAD`, `POST`, `DELETE`) that can be used in a cross-domain request. Each method should be specified in a separate element. Specify at least one method.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedMethod`.
`AllowedOrigin` | Website that allows sending cross-domain requests to a bucket. Specify at least one `AllowedOrigin` element.<br/><br/>May contain no more than one `*` character. Examples: `http://*.example.com`, `*`.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedOrigin`.
`AllowedHeader` | Header allowed in a request to an object. If multiple headers are allowed, specify each one in a separate `AllowedHeader` element. You can use a single `*` character in the header name to define a template, e.g., `<AllowedHeader>*</AllowedHeader>` means that all headers are allowed.<br/><br/>A request with the [options](../object/options.md) method contains `Access-Control-Request-Headers`. {{ objstorage-name }} maps the headers provided in `Access-Control-Request-Headers` with a set of `AllowedHeader` and responds to `options` with a list of allowed ones.<br/><br/>Path: `/CORSConfiguration/CORSRule/AllowedHeader`.
`MaxAgeSeconds` | Time in seconds during which the browser should cache the result of an object request using the [options](../object/options.md) method.<br/><br/>Path: `/CORSConfiguration/CORSRule/MaxAgeSeconds`.
`ExposeHeader` | Header that can be displayed in a JavaScript app in the browser. If multiple headers are allowed, specify each of them in a separate element.<br/><br/>When sending a request to an object, the JavaScript client can only use the headers specified in the `ExposeHeader` elements.<br/><br/>Path: `/CORSConfiguration/CORSRule/ExposeHeader`.


## Example {# example}

The following configuration allows you to send cross-domain requests from the `http://www.example.com` website using the `PUT`, `POST`, and `DELETE` methods without any header restrictions.

```xml
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