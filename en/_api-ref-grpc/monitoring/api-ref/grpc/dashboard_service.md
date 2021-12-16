---
editable: false
---

# DashboardService

A set of methods for managing dashboards.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified dashboard. |
| [List](#List) | Retrieves the list of dashboards in the specified folder. |
| [Create](#Create) | Creates a new dashboard in the specified folder. |
| [Update](#Update) | Updates the specified dashboard. |
| [Delete](#Delete) | Deletes the specified dashboard. |
| [ListOperations](#ListOperations) | Lists operations for the specified dashboard. |

## Calls DashboardService {#calls}

## Get {#Get}

Returns the specified dashboard.

**rpc Get ([GetDashboardRequest](#GetDashboardRequest)) returns ([Dashboard](#Dashboard))**

### GetDashboardRequest {#GetDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. Required. Dashboard ID. The maximum string length in characters is 50.


### Dashboard {#Dashboard}

Field | Description
--- | ---
id | **string**<br>Dashboard ID. 
folder_id | **string**<br>Folder ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Dashboard name. 
description | **string**<br>Dashboard description. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization)**<br>Dashboard parametrization. 


### Widget {#Widget}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries}

Field | Description
--- | ---
targets[] | **[Target](#Target)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme}



### StandardColorScheme {#StandardColorScheme}



### GradientColorScheme {#GradientColorScheme}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


## List {#List}

Retrieves the list of dashboards in the specified folder.

**rpc List ([ListDashboardsRequest](#ListDashboardsRequest)) returns ([ListDashboardsResponse](#ListDashboardsResponse))**

### ListDashboardsRequest {#ListDashboardsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Required. Folder ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of dashboards to return. If unspecified, at most 100 dashboards will be returned. The maximum value is 1000; values above 1000 will be coerced to 1000. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDashboardResponse.next_page_token] returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>The filter expression. Currently you can use filtering only on [Dashboard.name](#Dashboard1) field. The maximum string length in characters is 1000.


### ListDashboardsResponse {#ListDashboardsResponse}

Field | Description
--- | ---
dashboards[] | **[Dashboard](#Dashboard1)**<br>List of dashboards. 
next_page_token | **string**<br>Token to retrieve the next page of results, or empty if there are no more results in the list. 


### Dashboard {#Dashboard1}

Field | Description
--- | ---
id | **string**<br>Dashboard ID. 
folder_id | **string**<br>Folder ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Dashboard name. 
description | **string**<br>Dashboard description. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget1)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization1)**<br>Dashboard parametrization. 


### Widget {#Widget1}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition1)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget1)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget1)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget1)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition1}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget1}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget1}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget1}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries1)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings1)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides1)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings1)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries1}

Field | Description
--- | ---
targets[] | **[Target](#Target1)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target1}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings1}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings1)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings1)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings1)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings1}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme1)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme1)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme1)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme1}



### StandardColorScheme {#StandardColorScheme1}



### GradientColorScheme {#GradientColorScheme1}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings1}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis1}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings1}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis1)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis1)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides1}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings1)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings1}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings1}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization1}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter1)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter1}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter1)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter1)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter1)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter1}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter1}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter1}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


## Create {#Create}

Creates a new dashboard in the specified folder.

**rpc Create ([CreateDashboardRequest](#CreateDashboardRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDashboardMetadata](#CreateDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Dashboard](#Dashboard2)<br>

### CreateDashboardRequest {#CreateDashboardRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Required. Folder ID. The maximum string length in characters is 50.
name | **string**<br>Required. Dashboard name. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Dashboard description. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget2)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization2)**<br>Dashboard parametrization. 


### Widget {#Widget2}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition2)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget2)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget2)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget2)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition2}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget2}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget2}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget2}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries2)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings2)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides2)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings2)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries2}

Field | Description
--- | ---
targets[] | **[Target](#Target2)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target2}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings2}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings2)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings2)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings2)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings2}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme2)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme2)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme2)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme2}



### StandardColorScheme {#StandardColorScheme2}



### GradientColorScheme {#GradientColorScheme2}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings2}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis2}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings2}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis2)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis2)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides2}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings2)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings2}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings2}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization2}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter2)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter2}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter2)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter2)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter2)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter2}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter2}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter2}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDashboardMetadata](#CreateDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Dashboard](#Dashboard2)>**<br>if operation finished successfully. 


### CreateDashboardMetadata {#CreateDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>Dashboard ID. 


### Dashboard {#Dashboard2}

Field | Description
--- | ---
id | **string**<br>Dashboard ID. 
folder_id | **string**<br>Folder ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Dashboard name. 
description | **string**<br>Dashboard description. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget3)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization3)**<br>Dashboard parametrization. 


### Widget {#Widget3}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition3)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget3)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget3)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget3)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition3}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget3}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget3}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget3}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries3)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings3)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides3)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings3)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries3}

Field | Description
--- | ---
targets[] | **[Target](#Target3)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target3}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings3}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings3)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings3)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings3)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings3}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme3)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme3)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme3)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme3}



### StandardColorScheme {#StandardColorScheme3}



### GradientColorScheme {#GradientColorScheme3}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings3}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis3}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings3}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis3)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis3)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides3}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings3)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings3}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings3}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization3}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter3)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter3}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter3)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter3)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter3)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter3}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter3}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter3}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


## Update {#Update}

Updates the specified dashboard.

**rpc Update ([UpdateDashboardRequest](#UpdateDashboardRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDashboardMetadata](#UpdateDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Dashboard](#Dashboard3)<br>

### UpdateDashboardRequest {#UpdateDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. Required. Dashboard ID. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Dashboard resource are going to be updated. 
name | **string**<br>Required. Dashboard name. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Dashboard description. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget4)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization4)**<br>Dashboard parametrization. 


### Widget {#Widget4}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition4)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget4)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget4)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget4)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition4}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget4}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget4}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget4}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries4)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings4)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides4)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings4)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries4}

Field | Description
--- | ---
targets[] | **[Target](#Target4)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target4}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings4}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings4)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings4)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings4)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings4}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme4)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme4)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme4)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme4}



### StandardColorScheme {#StandardColorScheme4}



### GradientColorScheme {#GradientColorScheme4}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings4}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis4}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings4}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis4)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis4)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides4}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings4)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings4}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings4}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization4}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter4)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter4}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter4)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter4)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter4)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter4}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter4}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter4}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDashboardMetadata](#UpdateDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Dashboard](#Dashboard3)>**<br>if operation finished successfully. 


### UpdateDashboardMetadata {#UpdateDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>Dashboard ID. 


### Dashboard {#Dashboard3}

Field | Description
--- | ---
id | **string**<br>Dashboard ID. 
folder_id | **string**<br>Folder ID. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Dashboard name. 
description | **string**<br>Dashboard description. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
title | **string**<br>Dashboard title. 
widgets[] | **[Widget](#Widget5)**<br>List of dashboard widgets. 
parametrization | **[Parametrization](#Parametrization5)**<br>Dashboard parametrization. 


### Widget {#Widget5}

Field | Description
--- | ---
position | **[LayoutPosition](#LayoutPosition5)**<br>Required. Widget layout position. 
widget | **oneof:** `text`, `title` or `chart`<br>Required. Widget data.
&nbsp;&nbsp;text | **[TextWidget](#TextWidget5)**<br>Text widget. 
&nbsp;&nbsp;title | **[TitleWidget](#TitleWidget5)**<br>Title widget. 
&nbsp;&nbsp;chart | **[ChartWidget](#ChartWidget5)**<br>Chart widget. 


### LayoutPosition {#LayoutPosition5}

Field | Description
--- | ---
x | **int64**<br>Required. X-axis top-left corner coordinate. 
y | **int64**<br>Required. Y-axis top-left corner coordinate. 
w | **int64**<br>Required. Weight. 
h | **int64**<br>Required. Height. 


### TextWidget {#TextWidget5}

Field | Description
--- | ---
text | **string**<br>Text. 


### TitleWidget {#TitleWidget5}

Field | Description
--- | ---
text | **string**<br>Title text. 
size | enum **TitleSize**<br>Title size. <ul><li>`TITLE_SIZE_XS`: Extra small size.</li><li>`TITLE_SIZE_S`: Small size.</li><li>`TITLE_SIZE_M`: Middle size.</li><li>`TITLE_SIZE_L`: Large size.</li><ul/>


### ChartWidget {#ChartWidget5}

Field | Description
--- | ---
id | **string**<br>Required. Chart ID. 
queries | **[Queries](#Queries5)**<br>Queries. 
visualization_settings | **[VisualizationSettings](#VisualizationSettings5)**<br>Visualization settings. 
series_overrides[] | **[SeriesOverrides](#SeriesOverrides5)**<br>Override settings. 
name_hiding_settings | **[NameHidingSettings](#NameHidingSettings5)**<br>Name hiding settings. 
description | **string**<br>Chart description in dashboard (not enabled in UI). 
title | **string**<br>Chart widget title. 
display_legend | **bool**<br>Enable legend under chart. 
freeze | enum **FreezeDuration**<br>Fixed time interval for chart. <ul><li>`FREEZE_DURATION_HOUR`: Last hour.</li><li>`FREEZE_DURATION_DAY`: Last day = last 24 hours.</li><li>`FREEZE_DURATION_WEEK`: Last 7 days.</li><li>`FREEZE_DURATION_MONTH`: Last 31 days.</li><ul/>


### Queries {#Queries5}

Field | Description
--- | ---
targets[] | **[Target](#Target5)**<br>Required. List of targets. 
downsampling | **[Downsampling](#Downsampling)**<br>Required. Downsampling settings. 


### Target {#Target5}

Field | Description
--- | ---
query | **string**<br>Required. Query. 
text_mode | **bool**<br>Text mode. 
hidden | **bool**<br>Checks that target is visible or invisible. 


### VisualizationSettings {#VisualizationSettings5}

Field | Description
--- | ---
type | enum **VisualizationType**<br>Visualization type. <ul><li>`VISUALIZATION_TYPE_UNSPECIFIED`: Not specified (line by default).</li><li>`VISUALIZATION_TYPE_LINE`: Line chart.</li><li>`VISUALIZATION_TYPE_STACK`: Stack chart.</li><li>`VISUALIZATION_TYPE_COLUMN`: Points as columns chart.</li><li>`VISUALIZATION_TYPE_POINTS`: Points.</li><li>`VISUALIZATION_TYPE_PIE`: Pie aggregation chart.</li><li>`VISUALIZATION_TYPE_BARS`: Bars aggregation chart.</li><li>`VISUALIZATION_TYPE_DISTRIBUTION`: Distribution aggregation chart.</li><li>`VISUALIZATION_TYPE_HEATMAP`: Heatmap aggregation chart.</li><ul/>
normalize | **bool**<br>Normalize. 
interpolate | enum **Interpolate**<br>Interpolate. <ul><li>`INTERPOLATE_UNSPECIFIED`: Not specified (linear by default).</li><li>`INTERPOLATE_LINEAR`: Linear.</li><li>`INTERPOLATE_LEFT`: Left.</li><li>`INTERPOLATE_RIGHT`: Right.</li><ul/>
aggregation | enum **SeriesAggregation**<br>Aggregation. <ul><li>`SERIES_AGGREGATION_UNSPECIFIED`: Not specified (avg by default).</li><li>`SERIES_AGGREGATION_AVG`: Average.</li><li>`SERIES_AGGREGATION_MIN`: Minimum.</li><li>`SERIES_AGGREGATION_MAX`: Maximum.</li><li>`SERIES_AGGREGATION_LAST`: Last non-NaN value.</li><li>`SERIES_AGGREGATION_SUM`: Sum.</li><ul/>
color_scheme_settings | **[ColorSchemeSettings](#ColorSchemeSettings5)**<br>Color scheme settings. 
heatmap_settings | **[HeatmapSettings](#HeatmapSettings5)**<br>Heatmap settings. 
yaxis_settings | **[YaxisSettings](#YaxisSettings5)**<br>Y axis settings. 
title | **string**<br>Inside chart title. 
show_labels | **bool**<br>Show chart labels. 


### ColorSchemeSettings {#ColorSchemeSettings5}

Field | Description
--- | ---
scheme | **oneof:** `automatic`, `standard` or `gradient`<br>
&nbsp;&nbsp;automatic | **[AutomaticColorScheme](#AutomaticColorScheme5)**<br>Automatic color scheme. 
&nbsp;&nbsp;standard | **[StandardColorScheme](#StandardColorScheme5)**<br>Standard color scheme. 
&nbsp;&nbsp;gradient | **[GradientColorScheme](#GradientColorScheme5)**<br>Gradient color scheme. 


### AutomaticColorScheme {#AutomaticColorScheme5}



### StandardColorScheme {#StandardColorScheme5}



### GradientColorScheme {#GradientColorScheme5}

Field | Description
--- | ---
green_value | **string**<br>Gradient green value. 
yellow_value | **string**<br>Gradient yellow value. 
red_value | **string**<br>Gradient red value. 
violet_value | **string**<br>Gradient violet_value. 


### HeatmapSettings {#HeatmapSettings5}

Field | Description
--- | ---
green_value | **string**<br>Heatmap green value. 
yellow_value | **string**<br>Heatmap yellow value. 
red_value | **string**<br>Heatmap red value. 
violet_value | **string**<br>Heatmap violet_value. 


### Yaxis {#Yaxis5}

Field | Description
--- | ---
type | **YaxisType**<br>Type. 
title | **string**<br>Title or empty. 
min | **string**<br>Min value in extended number format or empty. 
max | **string**<br>Max value in extended number format or empty. 
unit_format | **UnitFormat**<br>Unit format. 
precision | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Tick value precision (null as default, 0-7 in other cases). 


### YaxisSettings {#YaxisSettings5}

Field | Description
--- | ---
left | **[Yaxis](#Yaxis5)**<br>Left Y axis settings. 
right | **[Yaxis](#Yaxis5)**<br>Right Y axis settings. 


### SeriesOverrides {#SeriesOverrides5}

Field | Description
--- | ---
type | **oneof:** `name` or `target_index`<br>Required. Series selection type.
&nbsp;&nbsp;name | **string**<br>Series name. 
&nbsp;&nbsp;target_index | **string**<br>Target index. 
settings | **[SeriesOverrideSettings](#SeriesOverrideSettings5)**<br>Required. Override settings. 


### SeriesOverrideSettings {#SeriesOverrideSettings5}

Field | Description
--- | ---
name | **string**<br>Series name or empty. 
color | **string**<br>Series color or empty. 
type | **SeriesVisualizationType**<br>Type. 
stack_name | **string**<br>Stack name or empty. 
grow_down | **bool**<br>Stack grow down. 
yaxis_position | **YaxisPosition**<br>Yaxis position. 


### NameHidingSettings {#NameHidingSettings5}

Field | Description
--- | ---
positive | **bool**<br>True if we want to show concrete series names only, false if we want to hide concrete series names. 
names[] | **string**<br>Series names to show or hide. 


### Parametrization {#Parametrization5}

Field | Description
--- | ---
parameters[] | **[Parameter](#Parameter5)**<br>Parameters. 
selectors | **string**<br>Predefined selectors. 


### Parameter {#Parameter5}

Field | Description
--- | ---
name | **string**<br>Parameter identifier. 
title | **string**<br>UI-visible title of the parameter. 
data | **oneof:** `label_values`, `custom` or `text`<br>Parameter data.
&nbsp;&nbsp;label_values | **[LabelValuesParameter](#LabelValuesParameter5)**<br>Label values parameter. 
&nbsp;&nbsp;custom | **[CustomParameter](#CustomParameter5)**<br>Custom parameter. 
&nbsp;&nbsp;text | **[TextParameter](#TextParameter5)**<br>Text parameter. 
hidden | **bool**<br>UI-visibility. 


### LabelValuesParameter {#LabelValuesParameter5}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. 
selectors | **string**<br>Required. Selectors to select metric label values. 
label_key | **string**<br>Required. Label key to list label values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### CustomParameter {#CustomParameter5}

Field | Description
--- | ---
values[] | **string**<br>Required. List of parameter values. 
multiselectable | **bool**<br>Specifies the multiselectable values of parameter. 
default_values[] | **string**<br>Default values. 


### TextParameter {#TextParameter5}

Field | Description
--- | ---
default_value | **string**<br>Default value. 


## Delete {#Delete}

Deletes the specified dashboard.

**rpc Delete ([DeleteDashboardRequest](#DeleteDashboardRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDashboardMetadata](#DeleteDashboardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDashboardRequest {#DeleteDashboardRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. Required. Dashboard ID. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDashboardMetadata](#DeleteDashboardMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDashboardMetadata {#DeleteDashboardMetadata}

Field | Description
--- | ---
dashboard_id | **string**<br>Dashboard ID. 


## ListOperations {#ListOperations}

Lists operations for the specified dashboard.

**rpc ListOperations ([ListDashboardOperationsRequest](#ListDashboardOperationsRequest)) returns ([ListDashboardOperationsResponse](#ListDashboardOperationsResponse))**

### ListDashboardOperationsRequest {#ListDashboardOperationsRequest}

Field | Description
--- | ---
dashboard_id | **string**<br>Required. ID of the dashboard to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDashboardOperationsResponse.next_page_token](#ListDashboardOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDashboardOperationsResponse.next_page_token](#ListDashboardOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListDashboardOperationsResponse {#ListDashboardOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified dashboard. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDashboardOperationsRequest.page_size](#ListDashboardOperationsRequest), use the `next_page_token` as the value for the [ListDashboardOperationsRequest.page_token](#ListDashboardOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


