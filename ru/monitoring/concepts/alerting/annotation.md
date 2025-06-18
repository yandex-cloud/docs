# Аннотация

Аннотации позволяют сохранить дополнительную информацию в момент вычисления алерта. Имя и значение аннотаций передаются при отправке уведомлений по алертам в [каналы](notification-channel.md) `Email` и `Telegram`.

В аннотациях поддерживается [mustache-шаблонизация](http://mustache.github.io/), при помощи которой в аннотацию можно передать параметры алерта.

Примеры аннотаций:

```text
Alert `not_var{{alert.name}}` is in not_var{{status.code}} state
```

```text
Used disk space is not_var{{pointValue}} Gbs, expected less than not_var{{alert.warnThreshold}} Gbs
```

Полный список параметров алертов, доступных в аннотациях:

Название | Описание
---------|----------
**alert.projectId**</br>**alert.folderId**</br>**alert.id**</br>**alert.name**</br>**alert.state**</br>**alert.createdAt**</br>**alert.updatedAt**</br>**alert.createdBy**</br>**alert.updatedBy**</br>**alert.version**</br> | Общие параметры алерта.
**alert.queries**</br>**alert.queryToCheck**</br>**alert.thresholdType**</br>**alert.comparison**</br>**alert.alarmThreshold**</br>**alert.warnThreshold** | Запросы и параметры сравнения порогового алерта.
**fromTime** | Начало временного интервала, в котором рассчитывается алерт. Строчка в формате ISO8601, например `2017-09-07T11:30:00Z`.
**toTime** | Конец временного интервала, в котором рассчитывается алерт. Строчка в формате ISO8601, например `2017-09-07T12:00:00Z`.
**pointValue** | Значение метрики на момент вычисления алерта.
**status.code** | Статус алерта: `OK`, `ALARM`, `WARN`, `NO_DATA` или `ERROR`.
**isOk**</br>**isWarn**</br>**isAlarm**</br>**isNoData**</br>**isError** | Логические переменные, с помощью которых можно узнать статус алерта. Например:</br></br>`{{#isAlarm}}Disk usage is too high!{{/isAlarm}}`</br>`{{^isAlarm}}Disk usage is ok.{{/isAlarm}}`
