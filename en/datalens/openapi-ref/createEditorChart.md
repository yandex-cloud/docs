---
editable: false
---

# DataLens API: 🚧 [Experimental] Create editor chart

Creates the specified Editor chart.

## HTTP request

```
POST https://api.datalens.tech/rpc/createEditorChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "mode": "string",
  "entry": "unknown"
}
```

#|
||Field | Description ||
|| mode | **enum**

- `save`
- `publish` ||
|| entry | One of **[CreateEditorTableNodeEntry](#CreateEditorTableNodeEntry)** \| **[CreateEditorGravityChartsNodeEntry](#CreateEditorGravityChartsNodeEntry)** \| **[CreateEditorMarkdownNodeEntry](#CreateEditorMarkdownNodeEntry)** \| **[CreateEditorAdvancedChartNodeEntry](#CreateEditorAdvancedChartNodeEntry)** \| **[CreateEditorSelectorNodeEntry](#CreateEditorSelectorNodeEntry)** ||
|#

## CreateEditorTableNodeEntry {#CreateEditorTableNodeEntry}

#|
||Field | Description ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| key | **string** 

Key identifier of the entry. ||
|| workbookId | **string** 

ID of the workbook to create the Editor chart. ||
|| name | **string** 

Name of the Editor chart. ||
|| type | **enum**

Required field. For Table Editor charts takes value:

- `table_node` ||
|| data | **[Data](#Data)**

Required field. Chart data. ||
|#

## Annotation {#Annotation}

#|
||Field | Description ||
|| description | **string**

Required field. Description of annotation. ||
|#

## Data {#Data}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|#

## CreateEditorGravityChartsNodeEntry {#CreateEditorGravityChartsNodeEntry}

#|
||Field | Description ||
|| meta | **object** (map<**string**, **unknown**>) 
Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 
Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| key | **string** 

Key identifier of the entry. ||
|| workbookId | **string** 

ID of the workbook to create the Editor chart. ||
|| name | **string** 

Name of the Editor chart. ||
|| type | **enum**

Required field. For D3 Editor charts takes value:

- `d3_node` ||
|| data | **[Data](#Data)**

Required field. Chart data. ||
|#

## CreateEditorMarkdownNodeEntry {#CreateEditorMarkdownNodeEntry}

#|
||Field | Description ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| key | **string** 

Key identifier of the entry. ||
|| workbookId | **string** 

ID of the workbook to create the Editor chart. ||
|| name | **string** 

Name of the Editor chart. ||
|| type | **enum**

Required field. For Markdown Editor charts takes value:

- `markdown_node` ||
|| data | **[Data](#Data-1)**

Required field. Chart data. ||
|#

## Data {#Data-1}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|#

## CreateEditorAdvancedChartNodeEntry {#CreateEditorAdvancedChartNodeEntry}

#|
||Field | Description ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| key | **string** 

Key identifier of the entry. ||
|| workbookId | **string** 

ID of the workbook to create the Editor chart. ||
|| name | **string** 

Name of the Editor chart. ||
|| type | **enum**

Required field. For Advanced Editor charts takes value:

- `advanced-chart_node` ||
|| data | **[Data](#Data-1)**

Required field. Chart data. ||
|#

## CreateEditorSelectorNodeEntry {#CreateEditorSelectorNodeEntry}

#|
||Field | Description ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| key | **string** 

Key identifier of the entry. ||
|| workbookId | **string** 

ID of the workbook to create the Editor chart. ||
|| name | **string** 

Name of the Editor chart. ||
|| type | **enum**

Required field. For Editor JS selectors takes value:

- `control_node` ||
|| data | **[Data](#Data-2)**

Required field. Chart data. ||
|#

## Data {#Data-2}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "entry": "unknown"
}
```

#|
||Field | Description ||
|| entry | One of **[EditorTableNode](#EditorTableNode)** \| **[EditorGravityChartsNode](#EditorGravityChartsNode)** \| **[EditorMarkdownNode](#EditorMarkdownNode)** \| **[EditorAdvancedChartNode](#EditorAdvancedChartNode)** \| **[EditorSelectorNode](#EditorSelectorNode)** ||
|#

## EditorTableNode {#EditorTableNode}

#|
||Field | Description ||
|| version | **enum**

Required field. Editor version.

Аvailable values:

- `1` ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | Any of **null** \| **string** \| **null** 

Key identifier of the entry. ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| createdBy | **string**

Required field. Creator of the entry. ||
|| updatedAt | **string**

Required field. Last update timestamp. ||
|| updatedBy | **string**

Required field. Last updater of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| savedId | **string**

Required field. Saved version ID. ||
|| publishedId | **string \| null**

Required field. Published version ID. ||
|| tenantId | **string**

Required field. Tenant ID. ||
|| hidden | **boolean**

Required field. Indicates if the entry is hidden. ||
|| public | **boolean**

Required field.  Indicates if the entry is public. ||
|| workbookId | Any of **null** \| **string** \| **null** ||
|| scope | **enum**

Required field. Type of the entry.

For charts takes value:

- `widget` ||
|| meta | **object \| null**

Required field. Metadata associated with the entry. ||
|| links | **object \| null** 

Link information. ||
|| annotation | **object \| null** 

Annotation information. ||
|| type | **enum**

Required field. For Table Editor charts takes value:

- `table_node` ||
|| data | **[Data](#Data-3)**

Required field. Chart data. ||
|#

## Data {#Data-3}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|#

## EditorGravityChartsNode {#EditorGravityChartsNode}

#|
||Field | Description ||
|| version | **enum**

Required field.  Editor version.

Аvailable values:

- `1` ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | Any of **null** \| **string** \| **null** 

Key identifier of the entry. ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| createdBy | **string**

Required field. Creator of the entry. ||
|| updatedAt | **string**

Required field. Last update timestamp. ||
|| updatedBy | **string**

Required field. Last updater of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| savedId | **string**

Required field. Saved version ID. ||
|| publishedId | **string \| null**

Required field. Published version ID. ||
|| tenantId | **string**

Required field. Tenant ID. ||
|| hidden | **boolean**

Required field. Indicates if the entry is hidden. ||
|| public | **boolean**

Required field. Indicates if the entry is public. ||
|| workbookId | Any of **null** \| **string** \| **null** 

ID of the workbook the Editor chart belongs to. ||
|| scope | **enum**

Required field. Type of the entry.

For charts takes value:

- `widget` ||
|| meta | **object \| null**

Required field. Metadata associated with the entry. ||
|| links | **object \| null** 

Link information. ||
|| annotation | **object \| null** 

Annotation information. ||
|| type | **enum**

Required field. For D3 Editor charts takes value:

- `d3_node` ||
|| data | **[Data](#Data-3)**

Required field. Chart data. ||
|#

## EditorMarkdownNode {#EditorMarkdownNode}

#|
||Field | Description ||
|| version | **enum**

Required field. Editor version.

Аvailable values:

- `1` ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | Any of **null** \| **string** \| **null** 

Key identifier of the entry. ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| createdBy | **string**

Required field. Creator of the entry. ||
|| updatedAt | **string**

Required field. Last update timestamp. ||
|| updatedBy | **string**

Required field. Last updater of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| savedId | **string**

Required field. Saved version ID. ||
|| publishedId | **string \| null**

Required field.  Published version ID. ||
|| tenantId | **string**

Required field. Tenant ID. ||
|| hidden | **boolean**

Required field. Indicates if the entry is hidden. ||
|| public | **boolean**

Required field. Indicates if the entry is public. ||
|| workbookId | Any of **null** \| **string** \| **null** 

ID of the workbook the Editor chart belongs to. ||
|| scope | **enum**

Required field. Type of the entry.

For charts takes value:

- `widget` ||
|| meta | **object \| null**

Required field. Metadata associated with the entry. ||
|| links | **object \| null** 

Link information. ||
|| annotation | **object \| null** 

Annotation information. ||
|| type | **enum**

Required field. For Markdown Editor charts takes value:

- `markdown_node` ||
|| data | **[Data](#Data-4)**

Required field. Chart data. ||
|#

## Data {#Data-4}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|#

## EditorAdvancedChartNode {#EditorAdvancedChartNode}

#|
||Field | Description ||
|| version | **enum**

Required field. Editor version.

Аvailable values:

- `1` ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | Any of **null** \| **string** \| **null** 

Key identifier of the entry. ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| createdBy | **string**

Required field. Creator of the entry. ||
|| updatedAt | **string**

Required field. Last update timestamp. ||
|| updatedBy | **string**

Required field. Last updater of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| savedId | **string**

Required field. Saved version ID. ||
|| publishedId | **string \| null**

Required field. Published version ID. ||
|| tenantId | **string**

Required field. Tenant ID. ||
|| hidden | **boolean**

Required field. Indicates if the entry is hidden. ||
|| public | **boolean**

Required field.  Indicates if the entry is public. ||
|| workbookId | Any of **null** \| **string** \| **null** 

ID of the workbook the Editor chart belongs to. ||
|| scope | **enum**

Required field. Type of the entry.

For charts takes value:

- `widget` ||
|| meta | **object \| null**

Required field. Metadata associated with the entry. ||
|| links | **object \| null** 

Link information. ||
|| annotation | **object \| null** 

Annotation information. ||
|| type | **enum**

Required field. For Advanced Editor charts takes value:

- `advanced-chart_node` ||
|| data | **[Data](#Data-4)**

Required field. Chart data. ||
|#

## EditorSelectorNode {#EditorSelectorNode}

#|
||Field | Description ||
|| version | **enum**

Required field. Editor version.

Аvailable values:

- `1` ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| key | Any of **null** \| **string** \| **null** 

Key identifier of the entry. ||
|| createdAt | **string**

Required field. Creation timestamp. ||
|| createdBy | **string**

Required field. Creator of the entry. ||
|| updatedAt | **string**

Required field. Last update timestamp. ||
|| updatedBy | **string**

Required field. Last updater of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| savedId | **string**

Required field. Saved version ID. ||
|| publishedId | **string \| null**

Required field. Published version ID. ||
|| tenantId | **string**

Required field. Tenant ID. ||
|| hidden | **boolean**

Required field. Indicates if the entry is hidden. ||
|| public | **boolean**

Required field. Indicates if the entry is public. ||
|| workbookId | Any of **null** \| **string** \| **null** 

ID of the workbook the Editor chart belongs to. ||
|| scope | **enum**

Required field. Type of the entry.

For charts takes value:

- `widget` ||
|| meta | **object \| null**

Required field. Metadata associated with the entry. ||
|| links | **object \| null** 

Link information. ||
|| annotation | **object \| null** 

Annotation information. ||
|| type | **enum**

Required field. For Editor JS selectors takes value:

- `control_node` ||
|| data | **[Data](#Data-5)**

Required field. Chart data. ||
|#

## Data {#Data-5}

#|
||Field | Description ||
|| meta | **string**

Required field. Configuration from the Meta tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|#