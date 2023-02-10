---
editable: false
---

# QuickLinksService

A set of methods for managing quick links.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the quick links for specified project. |
| [Create](#Create) | Creates new quick links for the specified project. |
| [Update](#Update) | Updates the quick links for specified project. |
| [Delete](#Delete) | Deletes the quick links for specified project. |

## Calls QuickLinksService {#calls}

## Get {#Get}

Returns quick links for specified project.

**rpc Get ([GetQuickLinksRequest](#GetQuickLinksRequest)) returns ([QuickLinks](#QuickLinks))**

### GetQuickLinksRequest {#GetQuickLinksRequest}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Required. Project ID.


### QuickLinks {#QuickLinks}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Project ID.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp.
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Modification timestamp.
created_by | **string**<br>ID of the user who created the quick links.
modified_by | **string**<br>ID of the user who modified the quick links.
items[] | **[QuickLinkItem](#QuickLinkItem)**<br>List of quick link items.
etag | **string**<br>Etag of quick links.


### QuickLinkItem {#QuickLinkItem}

Field | Description
--- | ---
Type | **oneof:** `link`, `folder`<br>Quick link type.
&nbsp;&nbsp;link | **[QuickLinkUrlItem](#QuickLinkUrlItem)**<br>URL link item.
&nbsp;&nbsp;folder | **[QuickLinkFolderItem](#QuickLinkFolderItem)**<br>Folder for link items.


### QuickLinkUrlItem {#QuickLinkUrlItem}

Field | Description
--- | ---
title | **string**<br>Title for the link.
url | **string**<br>URL address.


### QuickLinkFolderItem {#QuickLinkFolderItem}

Field | Description
--- | ---
title | **string**<br>Title for the link.
items[] | **[QuickLinkItem](#QuickLinkItem)**<br>List of quick link items.


## Create {#Create}

Creates quick links for specified project.

**rpc Create ([CreateQuickLinksRequest](#CreateQuickLinksRequest)) returns ([QuickLinks](#QuickLinks2))**

### CreateQuickLinksRequest {#CreateQuickLinksRequest}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Required. Project ID.
items[] | **[QuickLinkItem](#QuickLinkItem2)**<br>Required. List of quick link items.


### QuickLinks {#QuickLinks2}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Project ID.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp.
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Modification timestamp.
created_by | **string**<br>ID of the user who created the quick links.
modified_by | **string**<br>ID of the user who modified the quick links.
items[] | **[QuickLinkItem](#QuickLinkItem2)**<br>List of quick link items.
etag | **string**<br>Etag of quick links.


### QuickLinkItem {#QuickLinkItem2}

Field | Description
--- | ---
Type | **oneof:** `link`, `folder`<br>Quick link type.
&nbsp;&nbsp;link | **[QuickLinkUrlItem](#QuickLinkUrlItem2)**<br>URL link item.
&nbsp;&nbsp;folder | **[QuickLinkFolderItem](#QuickLinkFolderItem2)**<br>Folder for link items.


### QuickLinkUrlItem {#QuickLinkUrlItem2}

Field | Description
--- | ---
title | **string**<br>Title for the link.
url | **string**<br>URL address.


### QuickLinkFolderItem {#QuickLinkFolderItem2}

Field | Description
--- | ---
title | **string**<br>Title for the link.
items[] | **[QuickLinkItem](#QuickLinkItem2)**<br>List of quick link items.


## Update {#Update}

Updates quick links for specified project.

**rpc Update ([UpdateQuickLinksRequest](#UpdateQuickLinksRequest)) returns ([QuickLinks](#QuickLinks3))**

### UpdateQuickLinksRequest {#UpdateQuickLinksRequest}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Required. Project ID.
items[] | **[QuickLinkItem](#QuickLinkItem3)**<br>Required. List of quick link items.
etag | **string**<br>Etag of quick links.


### QuickLinks {#QuickLinks3}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Project ID.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp.
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Modification timestamp.
created_by | **string**<br>ID of the user who created the quick links.
modified_by | **string**<br>ID of the user who modified the quick links.
items[] | **[QuickLinkItem](#QuickLinkItem3)**<br>List of quick link items.
etag | **string**<br>Etag of quick links.


### QuickLinkItem {#QuickLinkItem3}

Field | Description
--- | ---
Type | **oneof:** `link`, `folder`<br>Quick link type.
&nbsp;&nbsp;link | **[QuickLinkUrlItem](#QuickLinkUrlItem3)**<br>URL link item.
&nbsp;&nbsp;folder | **[QuickLinkFolderItem](#QuickLinkFolderItem3)**<br>Folder for link items.


### QuickLinkUrlItem {#QuickLinkUrlItem3}

Field | Description
--- | ---
title | **string**<br>Title for the link.
url | **string**<br>URL address.


### QuickLinkFolderItem {#QuickLinkFolderItem3}

Field | Description
--- | ---
title | **string**<br>Title for the link.
items[] | **[QuickLinkItem](#QuickLinkItem3)**<br>List of quick link items.


## Delete {#Delete}

Deletes quick links for specified project.

**rpc Delete ([DeleteQuickLinksRequest](#DeleteQuickLinksRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### DeleteQuickLinksRequest {#DeleteQuickLinksRequest}

Field | Description
--- | ---
container | **oneof:** `project_id`<br>Container id.
&nbsp;&nbsp;project_id | **string**<br>Required. Project ID.