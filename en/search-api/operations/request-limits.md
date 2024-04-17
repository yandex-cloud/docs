# Requesting limits for the day

Returns information about [limits](../concepts/limits.md) on the number of queries that can be sent hourly.

The [response](#limit-response-format) contains information for each of the next 24 hours.

## Request format {#limit-request-format}

```bash
https://yandex.<domain>/search/xml
  ? [action=<limits-info>]
  & [folderid=<folder_ID>]
  & [apikey=<service_account_API_key>]
```

Where:

* `folderid`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are using to work with {{ search-api }}.
* `apikey`: [API key](../../iam/concepts/authorization/api-key.md) of the service account in this folder. You can [create](../../iam/operations/api-key/create.md) an API key in the management console interface. The value of an API key is displayed only once when it is being created.

### Sample request {#query-request}

The following request returns information about hourly limits on the number of search queries that can be sent by the user in the next 24 hours:

```bash
https://yandex.ru/search/xml?action=limits-info&folderid=b1g8oateeanu********&apikey=AQVN1kJ7f_1dHwW_Ert6p8357XJgzuKEpW********
```

## Response format {#limit-response-format}

In response to the request for hourly limits, {{ search-api }} returns a UTF-8 encoded XML file.

{% note info %}

If the allowed number of queries during one of the hours is exceeded, queries in excess of the limit will be deducted from the corresponding hour in the next 24-hour period. The excess data will be taken into account when generating a response.

{% endnote %}

Below, you can find a general structure of a resulting XML document with sample values.


```xml
<yandexsearch version="1.0">
<response>
<limits>
<time-interval from="2014-07-22 20:00:00 +0000" to="2014-07-22 21:00:00 +0000">500</time-interval>
<time-interval from="2014-07-22 21:00:00 +0000" to="2014-07-22 22:00:00 +0000">450</time-interval>
<time-interval from="2014-07-22 22:00:00 +0000" to="2014-07-22 23:00:00 +0000">590</time-interval>
<time-interval from="2014-07-22 23:00:00 +0000" to="2014-07-23 00:00:00 +0000">600</time-interval>
<time-interval from="2014-07-23 00:00:00 +0000" to="2014-07-23 01:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 01:00:00 +0000" to="2014-07-23 02:00:00 +0000">200</time-interval>
<time-interval from="2014-07-23 02:00:00 +0000" to="2014-07-23 03:00:00 +0000">500</time-interval>
<time-interval from="2014-07-23 03:00:00 +0000" to="2014-07-23 04:00:00 +0000">500</time-interval>
<time-interval from="2014-07-23 04:00:00 +0000" to="2014-07-23 05:00:00 +0000">500</time-interval>
<time-interval from="2014-07-23 05:00:00 +0000" to="2014-07-23 06:00:00 +0000">100</time-interval>
<time-interval from="2014-07-23 06:00:00 +0000" to="2014-07-23 07:00:00 +0000">100</time-interval>
<time-interval from="2014-07-23 07:00:00 +0000" to="2014-07-23 08:00:00 +0000">100</time-interval>
<time-interval from="2014-07-23 08:00:00 +0000" to="2014-07-23 09:00:00 +0000">100</time-interval>
<time-interval from="2014-07-23 09:00:00 +0000" to="2014-07-23 10:00:00 +0000">200</time-interval>
<time-interval from="2014-07-23 10:00:00 +0000" to="2014-07-23 11:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 11:00:00 +0000" to="2014-07-23 12:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 12:00:00 +0000" to="2014-07-23 13:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 13:00:00 +0000" to="2014-07-23 14:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 14:00:00 +0000" to="2014-07-23 15:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 15:00:00 +0000" to="2014-07-23 16:00:00 +0000">300</time-interval>
<time-interval from="2014-07-23 16:00:00 +0000" to="2014-07-23 17:00:00 +0000">400</time-interval>
<time-interval from="2014-07-23 17:00:00 +0000" to="2014-07-23 18:00:00 +0000">500</time-interval>
<time-interval from="2014-07-23 18:00:00 +0000" to="2014-07-23 19:00:00 +0000">500</time-interval>
<time-interval from="2014-07-23 19:00:00 +0000" to="2014-07-23 20:00:00 +0000">600</time-interval>
</limits>
</response>
</yandexsearch>
```


#|
|| **Tag** | **Description** | **Attributes** ||
|| response | Grouping | Missing. ||
|| limits |
Grouping.

Contains records about hourly limits on the allowed number of search queries
| Missing. ||
|| time-interval |
Number of search queries that can be sent within a given interval.

The interval boundaries are defined by respective attributes.|
- `from`: Limit's interval start date and time (inclusive).
- `to` Limit's interval end date and time (not inclusive).

Attribute data format:

```no-highlight
YYYY-MM-DD HH:MM:SS +HHMM
```

`HHMM` sets an event offset from UTC+0.

{% note warning %}

Currently, all hourly limits are output in UTC+0.

{% endnote %}
||
|#