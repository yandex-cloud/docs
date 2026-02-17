---
editable: false
---

# DataLens API: 🚧 [Experimental] Update Editor chart

## HTTP request

Updates the specified Editor chart.

```
POST https://api.datalens.yandex.net/rpc/updateEditorChart
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

Required field.

- `save`
- `publish` ||
|| entry | Type of the Editor chart.

One of **[UpdateEditorTableNodeEntry](#UpdateEditorTableNodeEntry)** \| **[UpdateEditorGravityChartsNodeEntry](#UpdateEditorGravityChartsNodeEntry)** \| **[UpdateEditorMarkdownNodeEntry](#UpdateEditorMarkdownNodeEntry)** \| **[UpdateEditorSelectorNodeEntry](#UpdateEditorSelectorNodeEntry)** \| **[UpdateEditorAdvancedChartNodeEntry](#UpdateEditorAdvancedChartNodeEntry)** \| **[UpdateEditorHighchartsNodeEntry](#UpdateEditorHighchartsNodeEntry)** \| **[UpdateEditorYagrNodeEntry](#UpdateEditorYagrNodeEntry)** \| **[UpdateEditorMetricNodeEntry](#UpdateEditorMetricNodeEntry)** \| **[UpdateEditorMarkupNodeEntry](#UpdateEditorMarkupNodeEntry)** \| **[UpdateEditorYaMapsNodeEntry](#UpdateEditorYaMapsNodeEntry)** \| **[UpdateEditorModuleEntry](#UpdateEditorModuleEntry)** ||
|#

## UpdateEditorTableNodeEntry {#UpdateEditorTableNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
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
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|#

## UpdateEditorGravityChartsNodeEntry {#UpdateEditorGravityChartsNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For D3 Editor charts takes value:

- `d3_node` ||
|| data | **[Data](#Data)**

Required field. Chart data. ||
|#

## UpdateEditorMarkdownNodeEntry {#UpdateEditorMarkdownNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Markdown Editor charts takes value:

- `markdown_node` ||
|| data | **[Data](#Data-1)**

Required field. Chart data. ||
|#

## Data {#Data-1}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|#

## UpdateEditorSelectorNodeEntry {#UpdateEditorSelectorNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor JS selectors takes value:

- `control_node` ||
|| data | **[Data](#Data-2)**

Required field. Chart data. ||
|#

## Data {#Data-2}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|#

## UpdateEditorAdvancedChartNodeEntry {#UpdateEditorAdvancedChartNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Advanced Editor charts takes value:

- `advanced-chart_node` ||
|| data | **[Data](#Data-1)**

Required field. Chart data. ||
|#

## UpdateEditorHighchartsNodeEntry {#UpdateEditorHighchartsNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Highcharts takes value:

- `graph_node` ||
|| data | **[Data](#Data-3)**

Required field. Chart data. ||
|#

## Data {#Data-3}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|| graph | **string**

Required field. Configuration from the library tab (e.g. Highcharts, Yagr, Gravity UI). ||
|#

## UpdateEditorYagrNodeEntry {#UpdateEditorYagrNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Yagr charts takes value:

- `timeseries_node` ||
|| data | **[Data](#Data-3)**

Required field. Chart data. ||
|#

## UpdateEditorMetricNodeEntry {#UpdateEditorMetricNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Metric charts takes value:

- `metric_node` ||
|| data | **[Data](#Data-4)**

Required field. Chart data. ||
|#

## Data {#Data-4}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|#

## UpdateEditorMarkupNodeEntry {#UpdateEditorMarkupNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Markup charts takes value:

- `markup_node` ||
|| data | **[Data](#Data-4)**

Required field. Chart data. ||
|#

## UpdateEditorYaMapsNodeEntry {#UpdateEditorYaMapsNodeEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Yandex Map charts takes value:

- `ymap_node` ||
|| data | **[Data](#Data-5)**

Required field. Chart data. ||
|#

## Data {#Data-5}

#|
||Field | Description ||
|| ymap | **string**

Required field. Configuration from the Ymap tab. ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| secrets | **string** 

Secrets configuration. ||
|#

## UpdateEditorModuleEntry {#UpdateEditorModuleEntry}

#|
||Field | Description ||
|| entryId | **string**

Required field. Unique identifier of the entry. ||
|| revId | **string**

Required field. Version ID for the Editor chart. ||
|| meta | **object** (map<**string**, **unknown**>) 

Metadata associated with the entry. ||
|| links | **object** (map<**string**, **string**>) 

Link information. ||
|| annotation | **[Annotation](#Annotation)**

Required field. Annotation information. ||
|| type | **enum**

Required field. For Editor Modules takes value:

- `module` ||
|| data | **[Data](#Data-6)**

Required field. Chart data. ||
|#

## Data {#Data-6}

#|
||Field | Description ||
|| documentation_en | **string** 

Documentation from the Doc En tab. ||
|| documentation_ru | **string** 

Documentation from the Doc Ru tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
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
|| entry | Type of the Editor chart.

One of **[EditorTableNode](#EditorTableNode)** \| **[EditorGravityChartsNode](#EditorGravityChartsNode)** \| **[EditorMarkdownNode](#EditorMarkdownNode)** \| **[EditorSelectorNode](#EditorSelectorNode)** \| **[EditorAdvancedChartNode](#EditorAdvancedChartNode)** \| **[EditorHighchartsNode](#EditorHighchartsNode)** \| **[EditorYagrNode](#EditorYagrNode)** \| **[EditorMetricNode](#EditorMetricNode)** \| **[EditorMarkupNode](#EditorMarkupNode)** \| **[EditorYaMapsNode](#EditorYaMapsNode)** \| **[EditorModule](#EditorModule)** \| **[EditorLegacyGraph](#EditorLegacyGraph)** \| **[EditorLegacyTable](#EditorLegacyTable)** \| **[EditorLegacyMap](#EditorLegacyMap)** \| **[EditorLegacyManager](#EditorLegacyManager)** \| **[EditorLegacyText](#EditorLegacyText)** \| **[EditorLegacyMetric](#EditorLegacyMetric)** ||
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

Required field. For Table Editor charts takes value:

- `table_node` ||
|| data | **[Data](#Data-7)**

Required field. Chart data. ||
|#

## Data {#Data-7}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
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

Required field. For D3 Editor charts takes value:

- `d3_node` ||
|| data | **[Data](#Data-7)**

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

Required field. For Markdown Editor charts takes value:

- `markdown_node` ||
|| data | **[Data](#Data-8)**

Required field. Chart data. ||
|#

## Data {#Data-8}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
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
|| data | **[Data](#Data-9)**

Required field. Chart data. ||
|#

## Data {#Data-9}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
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

Required field. For Advanced Editor charts takes value:

- `advanced-chart_node` ||
|| data | **[Data](#Data-8)**

Required field. Chart data. ||
|#

## EditorHighchartsNode {#EditorHighchartsNode}

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

Required field. For Editor Highcharts takes value:

- `graph_node` ||
|| data | **[Data](#Data-10)**

Required field. Chart data. ||
|#

## Data {#Data-10}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| controls | **string**

Required field. Configuration from the Controls tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|| graph | **string**

Required field. Configuration from the library tab (e.g. Highcharts, Yagr, Gravity UI). ||
|#

## EditorYagrNode {#EditorYagrNode}

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

Required field. For Editor Yagr charts takes value:

- `timeseries_node` ||
|| data | **[Data](#Data-10)**

Required field. Chart data. ||
|#

## EditorMetricNode {#EditorMetricNode}

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

Required field. For Editor Metric charts takes value:

- `metric_node` ||
|| data | **[Data](#Data-11)**

Required field. Chart data. ||
|#

## Data {#Data-11}

#|
||Field | Description ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| secrets | **string** 

Secrets configuration. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| config | **string**

Required field. Configuration from the Config tab. ||
|#

## EditorMarkupNode {#EditorMarkupNode}

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

Required field. For Editor Markup charts takes value:

- `markup_node` ||
|| data | **[Data](#Data-11)**

Required field. Chart data. ||
|#

## EditorYaMapsNode {#EditorYaMapsNode}

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

Required field. For Editor Yandex Map charts takes value:

- `ymap_node` ||
|| data | **[Data](#Data-12)**

Required field. Chart data. ||
|#

## Data {#Data-12}

#|
||Field | Description ||
|| ymap | **string**

Required field. Configuration from the Ymap tab. ||
|| shared | **string**

Required field. Configuration from the Shared tab. ||
|| params | **string**

Required field. Configuration from the Params tab. ||
|| sources | **string**

Required field. Configuration from the Sources tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|| secrets | **string** 

Secrets configuration. ||
|#

## EditorModule {#EditorModule}

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

Required field. For Editor Modules takes value:

- `module` ||
|| data | **[Data](#Data-13)**

Required field. Chart data. ||
|#

## Data {#Data-13}

#|
||Field | Description ||
|| documentation_en | **string** 

Documentation from the Doc En tab. ||
|| documentation_ru | **string** 

Documentation from the Doc Ru tab. ||
|| prepare | **string**

Required field. Configuration from the Prepare tab. ||
|#

## EditorLegacyGraph {#EditorLegacyGraph}

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

Required field.

- `graph` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#

## EditorLegacyTable {#EditorLegacyTable}

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

Required field.

- `table` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#

## EditorLegacyMap {#EditorLegacyMap}

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

Required field.

- `map` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#

## EditorLegacyManager {#EditorLegacyManager}

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

Required field.

- `manager` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#

## EditorLegacyText {#EditorLegacyText}

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

Required field.

- `text` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#

## EditorLegacyMetric {#EditorLegacyMetric}

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

Required field.

- `metric` ||
|| data | **object** (map<**string**, **string**>)

Required field. Chart data. ||
|#