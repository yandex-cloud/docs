# Устранение ошибки You cannot enable redirect HTTP to HTTPS when HTTPS is disabled


## Описание проблемы {#issue-description}

При попытке создать CDN-ресурс возникает ошибка:
```
status": 400,
"message": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"code": "GATEWAY_REQUEST_ERROR",
"title": "Ошибка",
"description": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"details": {
"grpcCode": 3
}

```
## Решение {#issue-resolution}

Прежде чем включать опцию редиректа с HTTP на HTTPS, необходимо, чтобы на домене заработал HTTPS — то есть нужно создать или добавить существующий сертификат для доменного имени, которое будет использоваться для раздачи содержимого через CDN.

Сертификат добавляется в сервисе [Certificate Manager](https://cloud.yandex.ru/docs/certificate-manager/quickstart/).

В диалоге создания CDN нужно указать сертификат, хранящийся в Certificate Manager. После этого можно включить переадресацию запросов с HTTP на HTTPS.

{% note info %}

Логика создания CDN поменялась на стороне партнёра, обеспечивающего работу CDN-хостов – G-Core Labs. Теперь от пользователей требуется обязательное наличие HTTPS на источниках, и по этой причине поменялась наша обработка создания ресурсов.

{% endnote %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса просим приложить скриншот страницы с настройками.

Также рекомендуем  создать ресурс с включенным HTTPS и запросом сертификата, а после включения HTTPS включить редирект HTTP-HTTPS.
