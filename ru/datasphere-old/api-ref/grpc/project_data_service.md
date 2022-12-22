---
editable: false
---

# DataSphere API v1, gRPC: ProjectDataService

A set of methods for managing data of the Project resource.

| Call | Description |
| --- | --- |
| [UploadFile](#UploadFile) | Uploads a file to the specified project. |
| [DownloadFile](#DownloadFile) | Downloads the specified file from the specified project. |

## Calls ProjectDataService {#calls}

## UploadFile {#UploadFile}

Uploads a file to the specified project.

**rpc UploadFile (stream [UploadFileRequest](#UploadFileRequest)) returns ([UploadFileResponse](#UploadFileResponse))**

### UploadFileRequest {#UploadFileRequest}

Field | Description
--- | ---
message | **oneof:** `metadata` or `chunk`<br>
&nbsp;&nbsp;metadata | **[FileMetadata](#FileMetadata)**<br>Metadata of the file to upload. 
&nbsp;&nbsp;chunk | **bytes**<br>Byte chunk of the file to upload. 


### FileMetadata {#FileMetadata}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource associated with the file. The maximum string length in characters is 200.
path | **string**<br>File path. 
size_bytes | **int64**<br>File size in bytes. 


### UploadFileResponse {#UploadFileResponse}

Field | Description
--- | ---
metadata | **[FileMetadata](#FileMetadata)**<br>Metadata of the uploaded file. 


## DownloadFile {#DownloadFile}

Downloads the specified file from the specified project.

**rpc DownloadFile ([DownloadFileRequest](#DownloadFileRequest)) returns (stream [DownloadFileResponse](#DownloadFileResponse))**

### DownloadFileRequest {#DownloadFileRequest}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource to download the file from. The maximum string length in characters is 200.
file_path | **string**<br>Required. Path of the file to download. 


### DownloadFileResponse {#DownloadFileResponse}

Field | Description
--- | ---
message | **oneof:** `metadata` or `chunk`<br>
&nbsp;&nbsp;metadata | **[FileMetadata](#FileMetadata)**<br>Metadata of the downloaded file. 
&nbsp;&nbsp;chunk | **bytes**<br>Byte chunk of the downloaded file. 


### FileMetadata {#FileMetadata1}

Field | Description
--- | ---
project_id | **string**<br>Required. ID of the Project resource associated with the file. The maximum string length in characters is 200.
path | **string**<br>File path. 
size_bytes | **int64**<br>File size in bytes. 


