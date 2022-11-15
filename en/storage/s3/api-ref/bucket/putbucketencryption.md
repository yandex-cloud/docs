# putBucketEncryption method

Adds encryption to the bucket. By default, the objects added to the bucket are encrypted with the specified [{{ kms-short-name }} key](../../../../kms/concepts/key.md). For more information about bucket encryption, see [{#T}](../../../concepts/encryption.md).

## Request {#request}

```
PUT /{bucket}?encryption HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |


### Headers {#request-headers}
Use only [common request headers](../common-request-headers.md) in requests.

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data schema {#response-scheme}

```
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

| Element | Description |
----- | -----
| `ApplyServerSideEncryptionByDefault` | Sets default encryption for the object, if other encryption parameters are omitted in the request.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault`. |
| `KMSMasterKeyID` | ID of the [{{ kms-short-name }} key](../../../../kms/concepts/key.md).<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\KMSMasterKeyID`. |
| `Rule` | Encryption policy on the server side. <br/><br/>Encryption is defined by the `KMSMasterKeyID` and `SSEAlgorithm` elements.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule`. |
| `ServerSideEncryptionConfiguration` | Encryption configuration used for new objects in the bucket by default.<br/><br/>Path: `ServerSideEncryptionConfiguration`. |
| `SSEAlgorithm` | The encryption algorithm. Available values: `aws:kms`.<br/><br/>Path: `ServerSideEncryptionConfiguration\Rule\ApplyServerSideEncryptionByDefault\SSEAlgorithm`. |
