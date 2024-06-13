---
editable: false
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/search.md
---

# Talk Analytics API, REST: Talk.search
rpc for searching talks. will return ids only
 

 
## HTTP request {#https-request}
```
POST https://speechsense.{{ api-host }}/speechsense/v1/talks/search
```
 
## Body parameters {#body_params}
 
```json 
{
  "organizationId": "string",
  "spaceId": "string",
  "connectionId": "string",
  "projectId": "string",
  "filters": [
    {
      "key": "string",
      "inverse": true,
      "channelNumber": "integer",

      // `filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`
      "anyMatch": {
        "values": [
          "string"
        ]
      },
      "intRange": {
        "fromValue": "integer",
        "toValue": "integer",
        "boundsInclusive": {
          "fromInclusive": true,
          "toInclusive": true
        }
      },
      "doubleRange": {
        "fromValue": "number",
        "toValue": "number",
        "boundsInclusive": {
          "fromInclusive": true,
          "toInclusive": true
        }
      },
      "dateRange": {
        "fromValue": "string",
        "toValue": "string",
        "boundsInclusive": {
          "fromInclusive": true,
          "toInclusive": true
        }
      },
      "durationRange": {
        "fromValue": "string",
        "toValue": "string",
        "boundsInclusive": {
          "fromInclusive": true,
          "toInclusive": true
        }
      },
      "booleanMatch": {
        "value": true
      },
      // end of the list of possible fields`filters[]`

    }
  ],
  "query": {
    "text": "string",
    "inverse": true,
    "channelNumber": "integer"
  },
  "pageSize": "string",
  "pageToken": "string",
  "sortData": {
    "fields": [
      {
        "field": "string",
        "order": "string",
        "position": "string"
      }
    ]
  }
}
```

 
Field | Description
--- | ---
organizationId | **string**<br><p>id of organization</p> 
spaceId | **string**<br><p>id of space</p> 
connectionId | **string**<br><p>id of connection</p> 
projectId | **string**<br><p>id of project</p> 
filters[] | **object**<br><p>metadata keys filters (user and system)</p> 
filters[].<br>key | **string**<br><p>metadata key (user.some_key / system.created_at / analysis.speechkit.duration)</p> 
filters[].<br>inverse | **boolean** (boolean)
filters[].<br>channelNumber | **integer** (int64)<br><p>channel number to apply filter for, starting with 0. applies to all channels if not specified</p> 
filters[].<br>anyMatch | **object**<br>find talk matched by any text filters <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>anyMatch.<br>values[] | **string**<br><p>values list to match with "OR" operator</p> 
filters[].<br>intRange | **object**<br>find talks with value from int range <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>intRange.<br>fromValue | **integer** (int64)
filters[].<br>intRange.<br>toValue | **integer** (int64)
filters[].<br>intRange.<br>boundsInclusive | **object**<br><p>indicates whether to include range boundaries</p> 
filters[].<br>intRange.<br>boundsInclusive.<br>fromInclusive | **boolean** (boolean)<br><p>include from bound</p> 
filters[].<br>intRange.<br>boundsInclusive.<br>toInclusive | **boolean** (boolean)<br><p>include to bound</p> 
filters[].<br>doubleRange | **object**<br>find talks with value from double range <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>doubleRange.<br>fromValue | **number** (double)
filters[].<br>doubleRange.<br>toValue | **number** (double)
filters[].<br>doubleRange.<br>boundsInclusive | **object**<br><p>indicates whether to include range boundaries</p> 
filters[].<br>doubleRange.<br>boundsInclusive.<br>fromInclusive | **boolean** (boolean)<br><p>include from bound</p> 
filters[].<br>doubleRange.<br>boundsInclusive.<br>toInclusive | **boolean** (boolean)<br><p>include to bound</p> 
filters[].<br>dateRange | **object**<br>find talks with value from date range <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>dateRange.<br>fromValue | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
filters[].<br>dateRange.<br>toValue | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
filters[].<br>dateRange.<br>boundsInclusive | **object**<br><p>indicates whether to include range boundaries</p> 
filters[].<br>dateRange.<br>boundsInclusive.<br>fromInclusive | **boolean** (boolean)<br><p>include from bound</p> 
filters[].<br>dateRange.<br>boundsInclusive.<br>toInclusive | **boolean** (boolean)<br><p>include to bound</p> 
filters[].<br>durationRange | **object**<br>find talks with value from duration range <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>durationRange.<br>fromValue | **string**
filters[].<br>durationRange.<br>toValue | **string**
filters[].<br>durationRange.<br>boundsInclusive | **object**<br><p>indicates whether to include range boundaries</p> 
filters[].<br>durationRange.<br>boundsInclusive.<br>fromInclusive | **boolean** (boolean)<br><p>include from bound</p> 
filters[].<br>durationRange.<br>boundsInclusive.<br>toInclusive | **boolean** (boolean)<br><p>include to bound</p> 
filters[].<br>booleanMatch | **object**<br>find talks with value equals boolean <br>`filters[]` includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`<br>
filters[].<br>booleanMatch.<br>value | **boolean** (boolean)
query | **object**<br><p>Full-text search query</p> 
query.<br>text | **string**
query.<br>inverse | **boolean** (boolean)<br><p>should or should NOT match</p> 
query.<br>channelNumber | **integer** (int64)<br><p>id of channel to search ("1", "2", ..., any channel if not set)</p> 
pageSize | **string** (int64)<br><p>page size, from 1 to 1000, default 100</p> 
pageToken | **string**<br><p>next page token, if page is not first</p> 
sortData | **object**<br><p>talks sorting options</p> 
sortData.<br>fields[] | **object**
sortData.<br>fields[].<br>field | **string**<br><p>sorting key</p> 
sortData.<br>fields[].<br>order | **string**<br><p>sorting order by current ``field``</p> 
sortData.<br>fields[].<br>position | **string** (int64)<br><p>number of field in comparing order (sort by key1 (position = 0), then key2 (position = 1), then key3...)</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "talkIds": [
    "string"
  ],
  "talksCount": "string",
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
talkIds[] | **string**<br><p>page results entries</p> 
talksCount | **string** (int64)<br><p>total documents matched</p> 
nextPageToken | **string**<br><p>page token for next request</p> 