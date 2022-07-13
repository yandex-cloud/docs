---
editable: false
---

# Method update
Updates the specified dashboard.
 

 
## HTTP request {#https-request}
```
PATCH https://monitoring.{{ api-host }}/monitoring/v3/dashboards/{dashboardId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dashboardId | <p>Required. Required. Dashboard ID.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "name": "string",
  "description": "string",
  "labels": "object",
  "title": "string",
  "widgets": [
    {
      "position": {
        "x": "string",
        "y": "string",
        "w": "string",
        "h": "string"
      },

      // `widgets[]` includes only one of the fields `text`, `title`, `chart`
      "text": {
        "text": "string"
      },
      "title": {
        "text": "string",
        "size": "string"
      },
      "chart": {
        "id": "string",
        "queries": {
          "targets": [
            {
              "query": "string",
              "textMode": true,
              "hidden": true
            }
          ],
          "downsampling": {
            "gridAggregation": "string",
            "gapFilling": "string",

            // `widgets[].chart.queries.downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`
            "maxPoints": "string",
            "gridInterval": "string",
            "disabled": true,
            // end of the list of possible fields`widgets[].chart.queries.downsampling`

          }
        },
        "visualizationSettings": {
          "type": "string",
          "normalize": true,
          "interpolate": "string",
          "aggregation": "string",
          "colorSchemeSettings": {

            // `widgets[].chart.visualizationSettings.colorSchemeSettings` includes only one of the fields `automatic`, `standard`, `gradient`
            "automatic": {},
            "standard": {},
            "gradient": {
              "greenValue": "string",
              "yellowValue": "string",
              "redValue": "string",
              "violetValue": "string"
            },
            // end of the list of possible fields`widgets[].chart.visualizationSettings.colorSchemeSettings`

          },
          "heatmapSettings": {
            "greenValue": "string",
            "yellowValue": "string",
            "redValue": "string",
            "violetValue": "string"
          },
          "yaxisSettings": {
            "left": {
              "type": "string",
              "title": "string",
              "min": "string",
              "max": "string",
              "unitFormat": "string",
              "precision": "integer"
            },
            "right": {
              "type": "string",
              "title": "string",
              "min": "string",
              "max": "string",
              "unitFormat": "string",
              "precision": "integer"
            }
          },
          "title": "string",
          "showLabels": true
        },
        "seriesOverrides": [
          {
            "settings": {
              "name": "string",
              "color": "string",
              "type": "string",
              "stackName": "string",
              "growDown": true,
              "yaxisPosition": "string"
            },

            // `widgets[].chart.seriesOverrides[]` includes only one of the fields `name`, `targetIndex`
            "name": "string",
            "targetIndex": "string",
            // end of the list of possible fields`widgets[].chart.seriesOverrides[]`

          }
        ],
        "nameHidingSettings": {
          "positive": true,
          "names": [
            "string"
          ]
        },
        "description": "string",
        "title": "string",
        "displayLegend": true,
        "freeze": "string"
      },
      // end of the list of possible fields`widgets[]`

    }
  ],
  "parametrization": {
    "parameters": [
      {
        "name": "string",
        "title": "string",
        "hidden": true,
        "description": "string",

        // `parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`
        "labelValues": {
          "selectors": "string",
          "labelKey": "string",
          "multiselectable": true,
          "defaultValues": [
            "string"
          ],
          "folderId": "string"
        },
        "custom": {
          "values": [
            "string"
          ],
          "multiselectable": true,
          "defaultValues": [
            "string"
          ]
        },
        "text": {
          "defaultValue": "string"
        },
        "integerParameter": {
          "defaultValue": "string",
          "unitFormat": "string"
        },
        "doubleParameter": {
          "defaultValue": "number",
          "unitFormat": "string"
        },
        "textValues": {
          "defaultValues": [
            "string"
          ]
        },
        // end of the list of possible fields`parametrization.parameters[]`

      }
    ],
    "selectors": "string"
  },
  "etag": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br><p>Required. Dashboard name.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Dashboard description.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>Existing set of ``labels`` is completely replaced by the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
title | **string**<br><p>Dashboard title.</p> 
widgets[] | **object**<br><p>List of dashboard widgets.</p> 
widgets[].<br>position | **object**<br>Required. Widget layout position.
widgets[].<br>position.<br>x | **string** (int64)<br><p>Required. X-axis top-left corner coordinate.</p> 
widgets[].<br>position.<br>y | **string** (int64)<br><p>Required. Y-axis top-left corner coordinate.</p> 
widgets[].<br>position.<br>w | **string** (int64)<br><p>Required. Weight.</p> 
widgets[].<br>position.<br>h | **string** (int64)<br><p>Required. Height.</p> 
widgets[].<br>text | **object**<br>Text widget. <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br>
widgets[].<br>text.<br>text | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Text.</p> 
widgets[].<br>title | **object**<br>Title widget. <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br>
widgets[].<br>title.<br>text | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Title text.</p> 
widgets[].<br>title.<br>size | **string**<br><p>Title size.</p> <p>Title size.</p> <ul> <li>TITLE_SIZE_XS: Extra small size.</li> <li>TITLE_SIZE_S: Small size.</li> <li>TITLE_SIZE_M: Middle size.</li> <li>TITLE_SIZE_L: Large size.</li> </ul> 
widgets[].<br>chart | **object**<br>Chart widget. <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br>
widgets[].<br>chart.<br>id | **string**<br><p>Required. Chart ID.</p> 
widgets[].<br>chart.<br>queries | **object**<br><p>Queries.</p> <p>Query settings.</p> 
widgets[].<br>chart.<br>queries.<br>targets[] | **object**<br><p>Required. List of targets.</p> 
widgets[].<br>chart.<br>queries.<br>targets[].<br>query | **string**<br><p>Required. Query.</p> 
widgets[].<br>chart.<br>queries.<br>targets[].<br>textMode | **boolean** (boolean)<br><p>Text mode.</p> 
widgets[].<br>chart.<br>queries.<br>targets[].<br>hidden | **boolean** (boolean)<br><p>Checks that target is visible or invisible.</p> 
widgets[].<br>chart.<br>queries.<br>downsampling | **object**<br><p>Required. Downsampling settings.</p> <p>List of available aggregate functions for downsampling.</p> 
widgets[].<br>chart.<br>queries.<br>downsampling.<br>gridAggregation | **string**<br>Function that is used for downsampling.<br><ul> <li>GRID_AGGREGATION_MAX: Max value.</li> <li>GRID_AGGREGATION_MIN: Min value.</li> <li>GRID_AGGREGATION_SUM: Sum of values.</li> <li>GRID_AGGREGATION_AVG: Average value.</li> <li>GRID_AGGREGATION_LAST: Last value.</li> <li>GRID_AGGREGATION_COUNT: Total count of points.</li> </ul> 
widgets[].<br>chart.<br>queries.<br>downsampling.<br>gapFilling | **string**<br>Parameters for filling gaps in data.<br><ul> <li>GAP_FILLING_NULL: Returns ``null`` as a metric value and ``timestamp`` as a time series value.</li> <li>GAP_FILLING_NONE: Returns no value and no timestamp.</li> <li>GAP_FILLING_PREVIOUS: Returns the value from the previous time interval.</li> </ul> 
widgets[].<br>chart.<br>queries.<br>downsampling.<br>maxPoints | **string** (int64) <br>`widgets[].chart.queries.downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Maximum number of points to be returned.</p> 
widgets[].<br>chart.<br>queries.<br>downsampling.<br>gridInterval | **string** (int64) <br>`widgets[].chart.queries.downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Time interval (grid) for downsampling in milliseconds. Points in the specified range are aggregated into one time point.</p> 
widgets[].<br>chart.<br>queries.<br>downsampling.<br>disabled | **boolean** (boolean) <br>`widgets[].chart.queries.downsampling` includes only one of the fields `maxPoints`, `gridInterval`, `disabled`<br><br><p>Disable downsampling.</p> 
widgets[].<br>chart.<br>visualizationSettings | **object**<br><p>Visualization settings.</p> <p>Visualization settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>type | **string**<br><p>Visualization type.</p> <p>Chart visualization type.</p> <ul> <li>VISUALIZATION_TYPE_UNSPECIFIED: Not specified (line by default). - VISUALIZATION_TYPE_LINE: Line chart.</li> <li>VISUALIZATION_TYPE_STACK: Stack chart.</li> <li>VISUALIZATION_TYPE_COLUMN: Points as columns chart.</li> <li>VISUALIZATION_TYPE_POINTS: Points.</li> <li>VISUALIZATION_TYPE_PIE: Pie aggregation chart.</li> <li>VISUALIZATION_TYPE_BARS: Bars aggregation chart.</li> <li>VISUALIZATION_TYPE_DISTRIBUTION: Distribution aggregation chart.</li> <li>VISUALIZATION_TYPE_HEATMAP: Heatmap aggregation chart.</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>normalize | **boolean** (boolean)<br><p>Normalize.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>interpolate | **string**<br><p>Interpolate.</p> <ul> <li>INTERPOLATE_UNSPECIFIED: Not specified (linear by default). - INTERPOLATE_LINEAR: Linear.</li> <li>INTERPOLATE_LEFT: Left.</li> <li>INTERPOLATE_RIGHT: Right.</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>aggregation | **string**<br><p>Aggregation.</p> <ul> <li>SERIES_AGGREGATION_UNSPECIFIED: Not specified (avg by default). - SERIES_AGGREGATION_AVG: Average.</li> <li>SERIES_AGGREGATION_MIN: Minimum.</li> <li>SERIES_AGGREGATION_MAX: Maximum.</li> <li>SERIES_AGGREGATION_LAST: Last non-NaN value.</li> <li>SERIES_AGGREGATION_SUM: Sum.</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings | **object**<br><p>Color scheme settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>automatic | **object**<br>Automatic color scheme. <br>`widgets[].chart.visualizationSettings.colorSchemeSettings` includes only one of the fields `automatic`, `standard`, `gradient`<br>
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>standard | **object**<br>Standard color scheme. <br>`widgets[].chart.visualizationSettings.colorSchemeSettings` includes only one of the fields `automatic`, `standard`, `gradient`<br>
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>gradient | **object**<br>Gradient color scheme. <br>`widgets[].chart.visualizationSettings.colorSchemeSettings` includes only one of the fields `automatic`, `standard`, `gradient`<br>
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>gradient.<br>greenValue | **string**<br><p>Gradient green value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>gradient.<br>yellowValue | **string**<br><p>Gradient yellow value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>gradient.<br>redValue | **string**<br><p>Gradient red value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>colorSchemeSettings.<br>gradient.<br>violetValue | **string**<br><p>Gradient violet_value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>heatmapSettings | **object**<br><p>Heatmap settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>heatmapSettings.<br>greenValue | **string**<br><p>Heatmap green value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>heatmapSettings.<br>yellowValue | **string**<br><p>Heatmap yellow value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>heatmapSettings.<br>redValue | **string**<br><p>Heatmap red value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>heatmapSettings.<br>violetValue | **string**<br><p>Heatmap violet_value.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings | **object**<br><p>Y axis settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left | **object**<br><p>Left Y axis settings.</p> <p>Y axis settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>type | **string**<br><p>Type.</p> <p>Y axis type. N.B. _TYPE prefix is necessary to expect name clash with Interpolate LINEAR value.</p> <ul> <li>YAXIS_TYPE_UNSPECIFIED: Not specified (linear by default). - YAXIS_TYPE_LINEAR: Linear.</li> <li>YAXIS_TYPE_LOGARITHMIC: Logarithmic.</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>title | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Title or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>min | **string**<br><p>Min value in extended number format or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>max | **string**<br><p>Max value in extended number format or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>unitFormat | **string**<br><p>Unit format.</p> <ul> <li>UNIT_NONE: None (show tick values as-is).</li> <li>UNIT_COUNT: Count.</li> <li>UNIT_PERCENT: Percent (0-100).</li> <li>UNIT_PERCENT_UNIT: Percent (0-1).</li> <li>UNIT_NANOSECONDS: Nanoseconds (ns).</li> <li>UNIT_MICROSECONDS: Microseconds (µs).</li> <li>UNIT_MILLISECONDS: Milliseconds (ms).</li> <li>UNIT_SECONDS: Seconds (s).</li> <li>UNIT_MINUTES: Minutes (m).</li> <li>UNIT_HOURS: Hours (h).</li> <li>UNIT_DAYS: Days (d).</li> <li>UNIT_BITS_SI: Bits (SI).</li> <li>UNIT_BYTES_SI: Bytes (SI).</li> <li>UNIT_KILOBYTES: Kilobytes (KB).</li> <li>UNIT_MEGABYTES: Megabytes (MB).</li> <li>UNIT_GIGABYTES: Gigabytes (GB).</li> <li>UNIT_TERABYTES: Terabytes (TB)</li> <li>UNIT_PETABYTES: Petabytes (PB).</li> <li>UNIT_EXABYTES: Exabytes (EB).</li> <li>UNIT_BITS_IEC: Bits (IEC).</li> <li>UNIT_BYTES_IEC: Bytes (IEC).</li> <li>UNIT_KIBIBYTES: Kibibytes (KiB).</li> <li>UNIT_MEBIBYTES: Mebibytes (MiB).</li> <li>UNIT_GIBIBYTES: Gigibytes (GiB).</li> <li>UNIT_TEBIBYTES: Tebibytes (TiB).</li> <li>UNIT_PEBIBYTES: Pebibytes (PiB).</li> <li>UNIT_EXBIBYTES: Exbibytes (EiB).</li> <li>UNIT_REQUESTS_PER_SECOND: Requests per second (reqps).</li> <li>UNIT_OPERATIONS_PER_SECOND: Operations per second (ops).</li> <li>UNIT_WRITES_PER_SECOND: Writes per second (wps).</li> <li>UNIT_READS_PER_SECOND: Reads per second (rps).</li> <li>UNIT_PACKETS_PER_SECOND: Packets per second (pps).</li> <li>UNIT_IO_OPERATIONS_PER_SECOND: IO operations per second (iops).</li> <li>UNIT_COUNTS_PER_SECOND: Counts per second (counts/sec).</li> <li>UNIT_BITS_SI_PER_SECOND: Bits (SI) per second (bits/sec).</li> <li>UNIT_BYTES_SI_PER_SECOND: Bytes (SI) per second (bytes/sec).</li> <li>UNIT_KILOBITS_PER_SECOND: Kilobits per second (KBits/sec).</li> <li>UNIT_KILOBYTES_PER_SECOND: Kilobytes per second (KB/sec).</li> <li>UNIT_MEGABITS_PER_SECOND: Megabits per second (MBits/sec).</li> <li>UNIT_MEGABYTES_PER_SECOND: Megabytes per second (MB/sec).</li> <li>UNIT_GIGABITS_PER_SECOND: Gigabits per second (GBits/sec).</li> <li>UNIT_GIGABYTES_PER_SECOND: Gigabytes per second (GB/sec).</li> <li>UNIT_TERABITS_PER_SECOND: Terabits per second (TBits/sec).</li> <li>UNIT_TERABYTES_PER_SECOND: Terabytes per second (TB/sec).</li> <li>UNIT_PETABITS_PER_SECOND: Petabits per second (Pbits/sec).</li> <li>UNIT_PETABYTES_PER_SECOND: Petabytes per second (PB/sec).</li> <li>UNIT_BITS_IEC_PER_SECOND: Bits (IEC) per second (bits/sec).</li> <li>UNIT_BYTES_IEC_PER_SECOND: Bytes (IEC) per second (bytes/sec).</li> <li>UNIT_KIBIBITS_PER_SECOND: Kibibits per second (KiBits/sec).</li> <li>UNIT_KIBIBYTES_PER_SECOND: Kibibytes per second (KiB/sec).</li> <li>UNIT_MEBIBITS_PER_SECOND: Mebibits per second (MiBits/sec).</li> <li>UNIT_MEBIBYTES_PER_SECOND: Mebibytes per second (MiB/sec).</li> <li>UNIT_GIBIBITS_PER_SECOND: Gibibits per second (GiBits/sec).</li> <li>UNIT_GIBIBYTES_PER_SECOND: Gibibytes per second (GiB/sec).</li> <li>UNIT_TEBIBITS_PER_SECOND: Tebibits per second (TiBits/sec).</li> <li>UNIT_TEBIBYTES_PER_SECOND: Tebibytes per second (TiB/sec).</li> <li>UNIT_PEBIBITS_PER_SECOND: Pebibits per second (PiBits/sec).</li> <li>UNIT_PEBIBYTES_PER_SECOND: Pebibytes per second (PiB/sec).</li> <li>UNIT_DATETIME_UTC: Datetime (UTC).</li> <li>UNIT_DATETIME_LOCAL: Datetime (local).</li> <li>UNIT_HERTZ: Hertz (Hz).</li> <li>UNIT_KILOHERTZ: Kilohertz (KHz).</li> <li>UNIT_MEGAHERTZ: Megahertz (MHz).</li> <li>UNIT_GIGAHERTZ: Gigahertz (GHz).</li> <li>UNIT_DOLLAR: Dollar.</li> <li>UNIT_EURO: Euro.</li> <li>UNIT_ROUBLE: Rouble.</li> <li>UNIT_CELSIUS: Celsius (°C).</li> <li>UNIT_FAHRENHEIT: Fahrenheit (°F).</li> <li>UNIT_KELVIN: Kelvin (K).</li> <li>UNIT_FLOP_PER_SECOND: Flop per second (FLOP/sec).</li> <li>UNIT_KILOFLOP_PER_SECOND: Kiloflop per second (KFLOP/sec).</li> <li>UNIT_MEGAFLOP_PER_SECOND: Megaflop per second (MFLOP/sec).</li> <li>UNIT_GIGAFLOP_PER_SECOND: Gigaflop per second (GFLOP/sec).</li> <li>UNIT_PETAFLOP_PER_SECOND: Petaflop per second (PFLOP/sec).</li> <li>UNIT_EXAFLOP_PER_SECOND: Exaflop per second (EFLOP/sec).</li> <li>UNIT_METERS_PER_SECOND: Meters per second (m/sec).</li> <li>UNIT_KILOMETERS_PER_HOUR: Kilometers per hour (km/h).</li> <li>UNIT_MILES_PER_HOUR: Miles per hour (mi/h).</li> <li>UNIT_MILLIMETER: Millimeter.</li> <li>UNIT_CENTIMETER: Centimeter.</li> <li>UNIT_METER: Meter.</li> <li>UNIT_KILOMETER: Kilometer.</li> <li>UNIT_MILE: Mile.</li> <li>UNIT_PPM: Parts per million (ppm).</li> <li>UNIT_EVENTS_PER_SECOND: Events per second</li> <li>UNIT_PACKETS: Packets</li> <li>UNIT_DBM: dBm (dbm)</li> <li>UNIT_VIRTUAL_CPU: Virtual CPU cores based on CPU time (vcpu)</li> <li>UNIT_MESSAGES_PER_SECOND: Messages per second (mps)</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>left.<br>precision | **integer** (int64)<br><p>Tick value precision (null as default, 0-7 in other cases).</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right | **object**<br><p>Right Y axis settings.</p> <p>Y axis settings.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>type | **string**<br><p>Type.</p> <p>Y axis type. N.B. _TYPE prefix is necessary to expect name clash with Interpolate LINEAR value.</p> <ul> <li>YAXIS_TYPE_UNSPECIFIED: Not specified (linear by default). - YAXIS_TYPE_LINEAR: Linear.</li> <li>YAXIS_TYPE_LOGARITHMIC: Logarithmic.</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>title | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Title or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>min | **string**<br><p>Min value in extended number format or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>max | **string**<br><p>Max value in extended number format or empty.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>unitFormat | **string**<br><p>Unit format.</p> <ul> <li>UNIT_NONE: None (show tick values as-is).</li> <li>UNIT_COUNT: Count.</li> <li>UNIT_PERCENT: Percent (0-100).</li> <li>UNIT_PERCENT_UNIT: Percent (0-1).</li> <li>UNIT_NANOSECONDS: Nanoseconds (ns).</li> <li>UNIT_MICROSECONDS: Microseconds (µs).</li> <li>UNIT_MILLISECONDS: Milliseconds (ms).</li> <li>UNIT_SECONDS: Seconds (s).</li> <li>UNIT_MINUTES: Minutes (m).</li> <li>UNIT_HOURS: Hours (h).</li> <li>UNIT_DAYS: Days (d).</li> <li>UNIT_BITS_SI: Bits (SI).</li> <li>UNIT_BYTES_SI: Bytes (SI).</li> <li>UNIT_KILOBYTES: Kilobytes (KB).</li> <li>UNIT_MEGABYTES: Megabytes (MB).</li> <li>UNIT_GIGABYTES: Gigabytes (GB).</li> <li>UNIT_TERABYTES: Terabytes (TB)</li> <li>UNIT_PETABYTES: Petabytes (PB).</li> <li>UNIT_EXABYTES: Exabytes (EB).</li> <li>UNIT_BITS_IEC: Bits (IEC).</li> <li>UNIT_BYTES_IEC: Bytes (IEC).</li> <li>UNIT_KIBIBYTES: Kibibytes (KiB).</li> <li>UNIT_MEBIBYTES: Mebibytes (MiB).</li> <li>UNIT_GIBIBYTES: Gigibytes (GiB).</li> <li>UNIT_TEBIBYTES: Tebibytes (TiB).</li> <li>UNIT_PEBIBYTES: Pebibytes (PiB).</li> <li>UNIT_EXBIBYTES: Exbibytes (EiB).</li> <li>UNIT_REQUESTS_PER_SECOND: Requests per second (reqps).</li> <li>UNIT_OPERATIONS_PER_SECOND: Operations per second (ops).</li> <li>UNIT_WRITES_PER_SECOND: Writes per second (wps).</li> <li>UNIT_READS_PER_SECOND: Reads per second (rps).</li> <li>UNIT_PACKETS_PER_SECOND: Packets per second (pps).</li> <li>UNIT_IO_OPERATIONS_PER_SECOND: IO operations per second (iops).</li> <li>UNIT_COUNTS_PER_SECOND: Counts per second (counts/sec).</li> <li>UNIT_BITS_SI_PER_SECOND: Bits (SI) per second (bits/sec).</li> <li>UNIT_BYTES_SI_PER_SECOND: Bytes (SI) per second (bytes/sec).</li> <li>UNIT_KILOBITS_PER_SECOND: Kilobits per second (KBits/sec).</li> <li>UNIT_KILOBYTES_PER_SECOND: Kilobytes per second (KB/sec).</li> <li>UNIT_MEGABITS_PER_SECOND: Megabits per second (MBits/sec).</li> <li>UNIT_MEGABYTES_PER_SECOND: Megabytes per second (MB/sec).</li> <li>UNIT_GIGABITS_PER_SECOND: Gigabits per second (GBits/sec).</li> <li>UNIT_GIGABYTES_PER_SECOND: Gigabytes per second (GB/sec).</li> <li>UNIT_TERABITS_PER_SECOND: Terabits per second (TBits/sec).</li> <li>UNIT_TERABYTES_PER_SECOND: Terabytes per second (TB/sec).</li> <li>UNIT_PETABITS_PER_SECOND: Petabits per second (Pbits/sec).</li> <li>UNIT_PETABYTES_PER_SECOND: Petabytes per second (PB/sec).</li> <li>UNIT_BITS_IEC_PER_SECOND: Bits (IEC) per second (bits/sec).</li> <li>UNIT_BYTES_IEC_PER_SECOND: Bytes (IEC) per second (bytes/sec).</li> <li>UNIT_KIBIBITS_PER_SECOND: Kibibits per second (KiBits/sec).</li> <li>UNIT_KIBIBYTES_PER_SECOND: Kibibytes per second (KiB/sec).</li> <li>UNIT_MEBIBITS_PER_SECOND: Mebibits per second (MiBits/sec).</li> <li>UNIT_MEBIBYTES_PER_SECOND: Mebibytes per second (MiB/sec).</li> <li>UNIT_GIBIBITS_PER_SECOND: Gibibits per second (GiBits/sec).</li> <li>UNIT_GIBIBYTES_PER_SECOND: Gibibytes per second (GiB/sec).</li> <li>UNIT_TEBIBITS_PER_SECOND: Tebibits per second (TiBits/sec).</li> <li>UNIT_TEBIBYTES_PER_SECOND: Tebibytes per second (TiB/sec).</li> <li>UNIT_PEBIBITS_PER_SECOND: Pebibits per second (PiBits/sec).</li> <li>UNIT_PEBIBYTES_PER_SECOND: Pebibytes per second (PiB/sec).</li> <li>UNIT_DATETIME_UTC: Datetime (UTC).</li> <li>UNIT_DATETIME_LOCAL: Datetime (local).</li> <li>UNIT_HERTZ: Hertz (Hz).</li> <li>UNIT_KILOHERTZ: Kilohertz (KHz).</li> <li>UNIT_MEGAHERTZ: Megahertz (MHz).</li> <li>UNIT_GIGAHERTZ: Gigahertz (GHz).</li> <li>UNIT_DOLLAR: Dollar.</li> <li>UNIT_EURO: Euro.</li> <li>UNIT_ROUBLE: Rouble.</li> <li>UNIT_CELSIUS: Celsius (°C).</li> <li>UNIT_FAHRENHEIT: Fahrenheit (°F).</li> <li>UNIT_KELVIN: Kelvin (K).</li> <li>UNIT_FLOP_PER_SECOND: Flop per second (FLOP/sec).</li> <li>UNIT_KILOFLOP_PER_SECOND: Kiloflop per second (KFLOP/sec).</li> <li>UNIT_MEGAFLOP_PER_SECOND: Megaflop per second (MFLOP/sec).</li> <li>UNIT_GIGAFLOP_PER_SECOND: Gigaflop per second (GFLOP/sec).</li> <li>UNIT_PETAFLOP_PER_SECOND: Petaflop per second (PFLOP/sec).</li> <li>UNIT_EXAFLOP_PER_SECOND: Exaflop per second (EFLOP/sec).</li> <li>UNIT_METERS_PER_SECOND: Meters per second (m/sec).</li> <li>UNIT_KILOMETERS_PER_HOUR: Kilometers per hour (km/h).</li> <li>UNIT_MILES_PER_HOUR: Miles per hour (mi/h).</li> <li>UNIT_MILLIMETER: Millimeter.</li> <li>UNIT_CENTIMETER: Centimeter.</li> <li>UNIT_METER: Meter.</li> <li>UNIT_KILOMETER: Kilometer.</li> <li>UNIT_MILE: Mile.</li> <li>UNIT_PPM: Parts per million (ppm).</li> <li>UNIT_EVENTS_PER_SECOND: Events per second</li> <li>UNIT_PACKETS: Packets</li> <li>UNIT_DBM: dBm (dbm)</li> <li>UNIT_VIRTUAL_CPU: Virtual CPU cores based on CPU time (vcpu)</li> <li>UNIT_MESSAGES_PER_SECOND: Messages per second (mps)</li> </ul> 
widgets[].<br>chart.<br>visualizationSettings.<br>yaxisSettings.<br>right.<br>precision | **integer** (int64)<br><p>Tick value precision (null as default, 0-7 in other cases).</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>title | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Inside chart title.</p> 
widgets[].<br>chart.<br>visualizationSettings.<br>showLabels | **boolean** (boolean)<br><p>Show chart labels.</p> 
widgets[].<br>chart.<br>seriesOverrides[] | **object**<br><p>Override settings.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings | **object**<br>Required. Override settings.
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>name | **string**<br><p>Series name or empty.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>color | **string**<br><p>Series color or empty.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>type | **string**<br><p>Type.</p> <ul> <li>SERIES_VISUALIZATION_TYPE_UNSPECIFIED: Not specified (line by default). - SERIES_VISUALIZATION_TYPE_LINE: Line chart.</li> <li>SERIES_VISUALIZATION_TYPE_STACK: Stack chart.</li> <li>SERIES_VISUALIZATION_TYPE_COLUMN: Points as columns chart.</li> <li>SERIES_VISUALIZATION_TYPE_POINTS: Points.</li> </ul> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>stackName | **string**<br><p>Stack name or empty.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>growDown | **boolean** (boolean)<br><p>Stack grow down.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>settings.<br>yaxisPosition | **string**<br><p>Yaxis position.</p> <ul> <li>YAXIS_POSITION_UNSPECIFIED: Not specified (left by default). - YAXIS_POSITION_LEFT: Left.</li> <li>YAXIS_POSITION_RIGHT: Right.</li> </ul> 
widgets[].<br>chart.<br>seriesOverrides[].<br>name | **string** <br>`widgets[].chart.seriesOverrides[]` includes only one of the fields `name`, `targetIndex`<br><br><p>Series name.</p> 
widgets[].<br>chart.<br>seriesOverrides[].<br>targetIndex | **string** <br>`widgets[].chart.seriesOverrides[]` includes only one of the fields `name`, `targetIndex`<br><br><p>Target index.</p> 
widgets[].<br>chart.<br>nameHidingSettings | **object**<br><p>Name hiding settings.</p> <p>Name hiding settings.</p> 
widgets[].<br>chart.<br>nameHidingSettings.<br>positive | **boolean** (boolean)<br><p>True if we want to show concrete series names only, false if we want to hide concrete series names.</p> 
widgets[].<br>chart.<br>nameHidingSettings.<br>names[] | **string**<br><p>Series names to show or hide.</p> 
widgets[].<br>chart.<br>description | **string**<br><p>Chart description in dashboard (not enabled in UI).</p> 
widgets[].<br>chart.<br>title | **string** <br>`widgets[]` includes only one of the fields `text`, `title`, `chart`<br><br><p>Chart widget title.</p> 
widgets[].<br>chart.<br>displayLegend | **boolean** (boolean)<br><p>Enable legend under chart.</p> 
widgets[].<br>chart.<br>freeze | **string**<br><p>Fixed time interval for chart.</p> <ul> <li>FREEZE_DURATION_HOUR: Last hour.</li> <li>FREEZE_DURATION_DAY: Last day = last 24 hours.</li> <li>FREEZE_DURATION_WEEK: Last 7 days.</li> <li>FREEZE_DURATION_MONTH: Last 31 days.</li> </ul> 
parametrization | **object**<br><p>Dashboard parametrization.</p> <p>Parametrization.</p> 
parametrization.<br>parameters[] | **object**<br><p>Parameters.</p> 
parametrization.<br>parameters[].<br>name | **string**<br><p>Parameter identifier.</p> 
parametrization.<br>parameters[].<br>title | **string**<br><p>UI-visible title of the parameter.</p> 
parametrization.<br>parameters[].<br>hidden | **boolean** (boolean)<br><p>UI-visibility.</p> 
parametrization.<br>parameters[].<br>description | **string**<br><p>Parameter description.</p> 
parametrization.<br>parameters[].<br>labelValues | **object**<br>Label values parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>labelValues.<br>selectors | **string**<br><p>Required. Selectors to select metric label values.</p> 
parametrization.<br>parameters[].<br>labelValues.<br>labelKey | **string**<br><p>Required. Label key to list label values.</p> 
parametrization.<br>parameters[].<br>labelValues.<br>multiselectable | **boolean** (boolean)<br><p>Specifies the multiselectable values of parameter.</p> 
parametrization.<br>parameters[].<br>labelValues.<br>defaultValues[] | **string**<br><p>Default values.</p> 
parametrization.<br>parameters[].<br>labelValues.<br>folderId | **string**<br><p>Required. Folder ID.</p> 
parametrization.<br>parameters[].<br>custom | **object**<br>Custom parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>custom.<br>values[] | **string**<br><p>Required. List of parameter values.</p> 
parametrization.<br>parameters[].<br>custom.<br>multiselectable | **boolean** (boolean)<br><p>Specifies the multiselectable values of parameter.</p> 
parametrization.<br>parameters[].<br>custom.<br>defaultValues[] | **string**<br><p>Default values.</p> 
parametrization.<br>parameters[].<br>text | **object**<br>Text parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>text.<br>defaultValue | **string**<br><p>Default value.</p> 
parametrization.<br>parameters[].<br>integerParameter | **object**<br>Integer parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>integerParameter.<br>defaultValue | **string** (int64)<br><p>Default value.</p> 
parametrization.<br>parameters[].<br>integerParameter.<br>unitFormat | **string**<br><p>Parameter unit.</p> <ul> <li>UNIT_NONE: None (show tick values as-is).</li> <li>UNIT_COUNT: Count.</li> <li>UNIT_PERCENT: Percent (0-100).</li> <li>UNIT_PERCENT_UNIT: Percent (0-1).</li> <li>UNIT_NANOSECONDS: Nanoseconds (ns).</li> <li>UNIT_MICROSECONDS: Microseconds (µs).</li> <li>UNIT_MILLISECONDS: Milliseconds (ms).</li> <li>UNIT_SECONDS: Seconds (s).</li> <li>UNIT_MINUTES: Minutes (m).</li> <li>UNIT_HOURS: Hours (h).</li> <li>UNIT_DAYS: Days (d).</li> <li>UNIT_BITS_SI: Bits (SI).</li> <li>UNIT_BYTES_SI: Bytes (SI).</li> <li>UNIT_KILOBYTES: Kilobytes (KB).</li> <li>UNIT_MEGABYTES: Megabytes (MB).</li> <li>UNIT_GIGABYTES: Gigabytes (GB).</li> <li>UNIT_TERABYTES: Terabytes (TB)</li> <li>UNIT_PETABYTES: Petabytes (PB).</li> <li>UNIT_EXABYTES: Exabytes (EB).</li> <li>UNIT_BITS_IEC: Bits (IEC).</li> <li>UNIT_BYTES_IEC: Bytes (IEC).</li> <li>UNIT_KIBIBYTES: Kibibytes (KiB).</li> <li>UNIT_MEBIBYTES: Mebibytes (MiB).</li> <li>UNIT_GIBIBYTES: Gigibytes (GiB).</li> <li>UNIT_TEBIBYTES: Tebibytes (TiB).</li> <li>UNIT_PEBIBYTES: Pebibytes (PiB).</li> <li>UNIT_EXBIBYTES: Exbibytes (EiB).</li> <li>UNIT_REQUESTS_PER_SECOND: Requests per second (reqps).</li> <li>UNIT_OPERATIONS_PER_SECOND: Operations per second (ops).</li> <li>UNIT_WRITES_PER_SECOND: Writes per second (wps).</li> <li>UNIT_READS_PER_SECOND: Reads per second (rps).</li> <li>UNIT_PACKETS_PER_SECOND: Packets per second (pps).</li> <li>UNIT_IO_OPERATIONS_PER_SECOND: IO operations per second (iops).</li> <li>UNIT_COUNTS_PER_SECOND: Counts per second (counts/sec).</li> <li>UNIT_BITS_SI_PER_SECOND: Bits (SI) per second (bits/sec).</li> <li>UNIT_BYTES_SI_PER_SECOND: Bytes (SI) per second (bytes/sec).</li> <li>UNIT_KILOBITS_PER_SECOND: Kilobits per second (KBits/sec).</li> <li>UNIT_KILOBYTES_PER_SECOND: Kilobytes per second (KB/sec).</li> <li>UNIT_MEGABITS_PER_SECOND: Megabits per second (MBits/sec).</li> <li>UNIT_MEGABYTES_PER_SECOND: Megabytes per second (MB/sec).</li> <li>UNIT_GIGABITS_PER_SECOND: Gigabits per second (GBits/sec).</li> <li>UNIT_GIGABYTES_PER_SECOND: Gigabytes per second (GB/sec).</li> <li>UNIT_TERABITS_PER_SECOND: Terabits per second (TBits/sec).</li> <li>UNIT_TERABYTES_PER_SECOND: Terabytes per second (TB/sec).</li> <li>UNIT_PETABITS_PER_SECOND: Petabits per second (Pbits/sec).</li> <li>UNIT_PETABYTES_PER_SECOND: Petabytes per second (PB/sec).</li> <li>UNIT_BITS_IEC_PER_SECOND: Bits (IEC) per second (bits/sec).</li> <li>UNIT_BYTES_IEC_PER_SECOND: Bytes (IEC) per second (bytes/sec).</li> <li>UNIT_KIBIBITS_PER_SECOND: Kibibits per second (KiBits/sec).</li> <li>UNIT_KIBIBYTES_PER_SECOND: Kibibytes per second (KiB/sec).</li> <li>UNIT_MEBIBITS_PER_SECOND: Mebibits per second (MiBits/sec).</li> <li>UNIT_MEBIBYTES_PER_SECOND: Mebibytes per second (MiB/sec).</li> <li>UNIT_GIBIBITS_PER_SECOND: Gibibits per second (GiBits/sec).</li> <li>UNIT_GIBIBYTES_PER_SECOND: Gibibytes per second (GiB/sec).</li> <li>UNIT_TEBIBITS_PER_SECOND: Tebibits per second (TiBits/sec).</li> <li>UNIT_TEBIBYTES_PER_SECOND: Tebibytes per second (TiB/sec).</li> <li>UNIT_PEBIBITS_PER_SECOND: Pebibits per second (PiBits/sec).</li> <li>UNIT_PEBIBYTES_PER_SECOND: Pebibytes per second (PiB/sec).</li> <li>UNIT_DATETIME_UTC: Datetime (UTC).</li> <li>UNIT_DATETIME_LOCAL: Datetime (local).</li> <li>UNIT_HERTZ: Hertz (Hz).</li> <li>UNIT_KILOHERTZ: Kilohertz (KHz).</li> <li>UNIT_MEGAHERTZ: Megahertz (MHz).</li> <li>UNIT_GIGAHERTZ: Gigahertz (GHz).</li> <li>UNIT_DOLLAR: Dollar.</li> <li>UNIT_EURO: Euro.</li> <li>UNIT_ROUBLE: Rouble.</li> <li>UNIT_CELSIUS: Celsius (°C).</li> <li>UNIT_FAHRENHEIT: Fahrenheit (°F).</li> <li>UNIT_KELVIN: Kelvin (K).</li> <li>UNIT_FLOP_PER_SECOND: Flop per second (FLOP/sec).</li> <li>UNIT_KILOFLOP_PER_SECOND: Kiloflop per second (KFLOP/sec).</li> <li>UNIT_MEGAFLOP_PER_SECOND: Megaflop per second (MFLOP/sec).</li> <li>UNIT_GIGAFLOP_PER_SECOND: Gigaflop per second (GFLOP/sec).</li> <li>UNIT_PETAFLOP_PER_SECOND: Petaflop per second (PFLOP/sec).</li> <li>UNIT_EXAFLOP_PER_SECOND: Exaflop per second (EFLOP/sec).</li> <li>UNIT_METERS_PER_SECOND: Meters per second (m/sec).</li> <li>UNIT_KILOMETERS_PER_HOUR: Kilometers per hour (km/h).</li> <li>UNIT_MILES_PER_HOUR: Miles per hour (mi/h).</li> <li>UNIT_MILLIMETER: Millimeter.</li> <li>UNIT_CENTIMETER: Centimeter.</li> <li>UNIT_METER: Meter.</li> <li>UNIT_KILOMETER: Kilometer.</li> <li>UNIT_MILE: Mile.</li> <li>UNIT_PPM: Parts per million (ppm).</li> <li>UNIT_EVENTS_PER_SECOND: Events per second</li> <li>UNIT_PACKETS: Packets</li> <li>UNIT_DBM: dBm (dbm)</li> <li>UNIT_VIRTUAL_CPU: Virtual CPU cores based on CPU time (vcpu)</li> <li>UNIT_MESSAGES_PER_SECOND: Messages per second (mps)</li> </ul> 
parametrization.<br>parameters[].<br>doubleParameter | **object**<br>Double parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>doubleParameter.<br>defaultValue | **number** (double)<br><p>Default value.</p> 
parametrization.<br>parameters[].<br>doubleParameter.<br>unitFormat | **string**<br><p>Parameter unit.</p> <ul> <li>UNIT_NONE: None (show tick values as-is).</li> <li>UNIT_COUNT: Count.</li> <li>UNIT_PERCENT: Percent (0-100).</li> <li>UNIT_PERCENT_UNIT: Percent (0-1).</li> <li>UNIT_NANOSECONDS: Nanoseconds (ns).</li> <li>UNIT_MICROSECONDS: Microseconds (µs).</li> <li>UNIT_MILLISECONDS: Milliseconds (ms).</li> <li>UNIT_SECONDS: Seconds (s).</li> <li>UNIT_MINUTES: Minutes (m).</li> <li>UNIT_HOURS: Hours (h).</li> <li>UNIT_DAYS: Days (d).</li> <li>UNIT_BITS_SI: Bits (SI).</li> <li>UNIT_BYTES_SI: Bytes (SI).</li> <li>UNIT_KILOBYTES: Kilobytes (KB).</li> <li>UNIT_MEGABYTES: Megabytes (MB).</li> <li>UNIT_GIGABYTES: Gigabytes (GB).</li> <li>UNIT_TERABYTES: Terabytes (TB)</li> <li>UNIT_PETABYTES: Petabytes (PB).</li> <li>UNIT_EXABYTES: Exabytes (EB).</li> <li>UNIT_BITS_IEC: Bits (IEC).</li> <li>UNIT_BYTES_IEC: Bytes (IEC).</li> <li>UNIT_KIBIBYTES: Kibibytes (KiB).</li> <li>UNIT_MEBIBYTES: Mebibytes (MiB).</li> <li>UNIT_GIBIBYTES: Gigibytes (GiB).</li> <li>UNIT_TEBIBYTES: Tebibytes (TiB).</li> <li>UNIT_PEBIBYTES: Pebibytes (PiB).</li> <li>UNIT_EXBIBYTES: Exbibytes (EiB).</li> <li>UNIT_REQUESTS_PER_SECOND: Requests per second (reqps).</li> <li>UNIT_OPERATIONS_PER_SECOND: Operations per second (ops).</li> <li>UNIT_WRITES_PER_SECOND: Writes per second (wps).</li> <li>UNIT_READS_PER_SECOND: Reads per second (rps).</li> <li>UNIT_PACKETS_PER_SECOND: Packets per second (pps).</li> <li>UNIT_IO_OPERATIONS_PER_SECOND: IO operations per second (iops).</li> <li>UNIT_COUNTS_PER_SECOND: Counts per second (counts/sec).</li> <li>UNIT_BITS_SI_PER_SECOND: Bits (SI) per second (bits/sec).</li> <li>UNIT_BYTES_SI_PER_SECOND: Bytes (SI) per second (bytes/sec).</li> <li>UNIT_KILOBITS_PER_SECOND: Kilobits per second (KBits/sec).</li> <li>UNIT_KILOBYTES_PER_SECOND: Kilobytes per second (KB/sec).</li> <li>UNIT_MEGABITS_PER_SECOND: Megabits per second (MBits/sec).</li> <li>UNIT_MEGABYTES_PER_SECOND: Megabytes per second (MB/sec).</li> <li>UNIT_GIGABITS_PER_SECOND: Gigabits per second (GBits/sec).</li> <li>UNIT_GIGABYTES_PER_SECOND: Gigabytes per second (GB/sec).</li> <li>UNIT_TERABITS_PER_SECOND: Terabits per second (TBits/sec).</li> <li>UNIT_TERABYTES_PER_SECOND: Terabytes per second (TB/sec).</li> <li>UNIT_PETABITS_PER_SECOND: Petabits per second (Pbits/sec).</li> <li>UNIT_PETABYTES_PER_SECOND: Petabytes per second (PB/sec).</li> <li>UNIT_BITS_IEC_PER_SECOND: Bits (IEC) per second (bits/sec).</li> <li>UNIT_BYTES_IEC_PER_SECOND: Bytes (IEC) per second (bytes/sec).</li> <li>UNIT_KIBIBITS_PER_SECOND: Kibibits per second (KiBits/sec).</li> <li>UNIT_KIBIBYTES_PER_SECOND: Kibibytes per second (KiB/sec).</li> <li>UNIT_MEBIBITS_PER_SECOND: Mebibits per second (MiBits/sec).</li> <li>UNIT_MEBIBYTES_PER_SECOND: Mebibytes per second (MiB/sec).</li> <li>UNIT_GIBIBITS_PER_SECOND: Gibibits per second (GiBits/sec).</li> <li>UNIT_GIBIBYTES_PER_SECOND: Gibibytes per second (GiB/sec).</li> <li>UNIT_TEBIBITS_PER_SECOND: Tebibits per second (TiBits/sec).</li> <li>UNIT_TEBIBYTES_PER_SECOND: Tebibytes per second (TiB/sec).</li> <li>UNIT_PEBIBITS_PER_SECOND: Pebibits per second (PiBits/sec).</li> <li>UNIT_PEBIBYTES_PER_SECOND: Pebibytes per second (PiB/sec).</li> <li>UNIT_DATETIME_UTC: Datetime (UTC).</li> <li>UNIT_DATETIME_LOCAL: Datetime (local).</li> <li>UNIT_HERTZ: Hertz (Hz).</li> <li>UNIT_KILOHERTZ: Kilohertz (KHz).</li> <li>UNIT_MEGAHERTZ: Megahertz (MHz).</li> <li>UNIT_GIGAHERTZ: Gigahertz (GHz).</li> <li>UNIT_DOLLAR: Dollar.</li> <li>UNIT_EURO: Euro.</li> <li>UNIT_ROUBLE: Rouble.</li> <li>UNIT_CELSIUS: Celsius (°C).</li> <li>UNIT_FAHRENHEIT: Fahrenheit (°F).</li> <li>UNIT_KELVIN: Kelvin (K).</li> <li>UNIT_FLOP_PER_SECOND: Flop per second (FLOP/sec).</li> <li>UNIT_KILOFLOP_PER_SECOND: Kiloflop per second (KFLOP/sec).</li> <li>UNIT_MEGAFLOP_PER_SECOND: Megaflop per second (MFLOP/sec).</li> <li>UNIT_GIGAFLOP_PER_SECOND: Gigaflop per second (GFLOP/sec).</li> <li>UNIT_PETAFLOP_PER_SECOND: Petaflop per second (PFLOP/sec).</li> <li>UNIT_EXAFLOP_PER_SECOND: Exaflop per second (EFLOP/sec).</li> <li>UNIT_METERS_PER_SECOND: Meters per second (m/sec).</li> <li>UNIT_KILOMETERS_PER_HOUR: Kilometers per hour (km/h).</li> <li>UNIT_MILES_PER_HOUR: Miles per hour (mi/h).</li> <li>UNIT_MILLIMETER: Millimeter.</li> <li>UNIT_CENTIMETER: Centimeter.</li> <li>UNIT_METER: Meter.</li> <li>UNIT_KILOMETER: Kilometer.</li> <li>UNIT_MILE: Mile.</li> <li>UNIT_PPM: Parts per million (ppm).</li> <li>UNIT_EVENTS_PER_SECOND: Events per second</li> <li>UNIT_PACKETS: Packets</li> <li>UNIT_DBM: dBm (dbm)</li> <li>UNIT_VIRTUAL_CPU: Virtual CPU cores based on CPU time (vcpu)</li> <li>UNIT_MESSAGES_PER_SECOND: Messages per second (mps)</li> </ul> 
parametrization.<br>parameters[].<br>textValues | **object**<br>Integer parameter. <br>`parametrization.parameters[]` includes only one of the fields `labelValues`, `custom`, `text`, `integerParameter`, `doubleParameter`, `textValues`<br>
parametrization.<br>parameters[].<br>textValues.<br>defaultValues[] | **string**<br><p>Default value.</p> 
parametrization.<br>selectors | **string**<br><p>Predefined selectors.</p> 
etag | **string**<br><p>The current etag of the dashboard.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 