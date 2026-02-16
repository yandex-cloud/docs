---
editable: false
sourcePath: en/_api-ref-grpc/ai/dataset/v1/dataset/api-ref/grpc/Dataset/index.md
---

# Foundation Models Dataset Service API, gRPC: DatasetService

A set of methods for managing datasets.

## Methods

#|
||Method | Description ||
|| [Describe](describe.md) | Returns dataset information by dataset id. ||
|| [Validate](validate.md) | Starts dataset validation process. ||
|| [Create](create.md) | Creates dataset. ||
|| [Update](update.md) | Updates dataset. ||
|| [Delete](delete.md) | Deletes dataset. ||
|| [List](list.md) | Lists datasets in specified folder. ||
|| [ListUploadFormats](listUploadFormats.md) | Deprecated. Use ListUploadSchemas. ||
|| [ListUploadSchemas](listUploadSchemas.md) | Lists supported dataset upload formats types and schemas for the specified dataset task type. ||
|| [GetUploadDraftUrl](getUploadDraftUrl.md) | Returns an S3 presigned URL for dataset upload. ||
|| [GetDownloadUrls](getDownloadUrls.md) | Get urls to download dataset ||
|| [StartMultipartUploadDraft](startMultipartUploadDraft.md) | Returns a list of S3 presigned URLs for multipart upload of dataset. ||
|| [FinishMultipartUploadDraft](finishMultipartUploadDraft.md) | Finishes multipart upload of the dataset. ||
|| [ListTypes](listTypes.md) | Returns a list of dataset types ||
|| [GetPreview](getPreview.md) | Returns a preview of dataset types ||
|| [ListOperationsIds](listOperationsIds.md) |  ||
|#