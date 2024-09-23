# putBucketEncryption method

Adds encryption to the bucket. By default, objects added to the bucket are encrypted with the specified [{{ kms-short-name }}](../../../../kms/concepts/key.md) key. For more information about bucket encryption, see [{#T}](../../../concepts/encryption.md).

## Request {#request}

```http
PUT /{bucket}?encryption HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in your requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

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
`Rule` | Encryption policy on the server side. <br/><br/>The encryption is defined with `KMSMasterKeyID` and `SSEAlgorithm`.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule`.
`ServerSideEncryptionConfiguration` | Encryption configuration used for new objects in the bucket by default. <br/><br/>Path: `ServerSideEncryptionConfiguration`.
`SSEAlgorithm` | Encryption algorithm. The only possible value is `aws:kms`.><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}