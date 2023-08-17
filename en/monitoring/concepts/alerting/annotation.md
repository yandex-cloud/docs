# Annotation

Annotations enable you to save some additional information during alert calculation and add this information to your notification text.

Annotations support [mustache templates](http://mustache.github.io/): you can use them to add alert parameters to your annotations.

Annotation examples:

```
Alert `not_var{{alert.name}}` is in not_var{{status.code}} state
```

```
Used disk space is not_var{{pointValue}} Gbs, expected less than not_var{{alert.warnThreshold}} Gbs
```

Complete list of alert parameters available in annotations:

| Name | Description |
---------|----------
| **alert.projectId**</br>**alert.folderId**</br>**alert.id**</br>**alert.name**</br>**alert.state**</br>**alert.createdAt**</br>**alert.updatedAt**</br>**alert.createdBy**</br>**alert.updatedBy**</br>**alert.version**</br> | Common alert parameters: |
| **alert.queries**</br>**alert.queryToCheck**</br>**alert.thresholdType**</br>**alert.comparison**</br>**alert.alarmThreshold**</br>**alert.warnThreshold** | Threshold alert queries and comparison parameters. |
| **fromTime** | Beginning of the time interval in which the alert is calculated. A string in ISO8601 format, such as `2017-09-07T11:30:00Z`. |
| **toTime** | End of the time interval in which the alert is calculated. A string in ISO8601 format, such as `2017-09-07T12:00:00Z`. |
| **pointValue** | Metric value as of alert calculation. |
| **status.code** | Alert status: `OK`, `ALARM`, `WARN`, `NO_DATA`, or `ERROR`. |
| **isOk**</br>**isWarn**</br>**isAlarm**</br>**isNoData**</br>**isError** | Boolean variables that can be used to find out the alert status. For example:</br></br>`not_var{{#isAlarm}}Disk usage is too high!not_var{{/isAlarm}}`</br>`not_var{{^isAlarm}}Disk usage is ok.not_var{{/isAlarm}}` |