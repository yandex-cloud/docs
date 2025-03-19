# getBucketEncryption method

Returns information about bucket encryption. For more information about bucket encryption, see [{#T}](../../../concepts/encryption.md).

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```http
GET /{bucket}?encryption HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Headers {#request-headers}
Use only [common headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```xml
<ServerSideEncryptionConfiguration>
   <Rule>
      <ApplyServerSideEncryptionByDefault>
         <KMSMasterKeyID>string</KMSMasterKeyID>
         <SSEAlgorithm>string</SSEAlgorithm>
      </ApplyServerSideEncryptionByDefault>
   </Rule>
   ...
</ServerSideEncryptionConfiguration>
```

Element | Description
----- | -----
`ApplyServerSideEncryptionByDefault` | Sets default encryption for the object, if other encryption parameters are not specified in the request.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault`.
`KMSMasterKeyID` | [{{ kms-short-name }} key](../../../../kms/concepts/key.md) ID.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\KMSMasterKeyID`.
`Rule` | Server-side encryption policy. <br/><br/>The encryption is defined by `KMSMasterKeyID` and `SSEAlgorithm`.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule`.
`ServerSideEncryptionConfiguration` | Default encryption configuration for new objects in the bucket.<br/><br/>Path: `ServerSideEncryptionConfiguration`.
`SSEAlgorithm` | Encryption algorithm that takes the `aws:kms` value.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}