# Устранение ошибки `CORS` при обращении к API {{ speechkit-short-name }}, {{ vision-short-name }} или {{ translate-short-name }} из фронтенда веб-приложения


## Описание проблемы {#issue-description}

При обращении к API {{ speechkit-short-name }}, {{ vision-short-name }} или {{ translate-short-name }} сервис возвращает ошибку `CORS`:

```
Access to XMLHttpRequest at '<https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze>' 
from origin '...' has been blocked by CORS policy: Response to preflight request doesn't
pass access control check: No 'Access-Control-Allow-Origin'
```

## Решение {#issue-resolution}

Организовать прямое взаимодействие между приложением, работающим во фронтенд-окружении, и API не получится. AI-сервисы не могут работать с [кросс-доменными запросами](../../../glossary/cors.md), поскольку в API этих сервисов не реализован ответ на запрос `OPTIONS`.

Для решения этой задачи вы можете использовать {{ sf-name }}. В сервисе понадобится [создать облачную функцию](../../../functions/operations/function/function-create.md) и разместить в ней API, которое будет передавать запросы в {{ speechkit-short-name }}, {{ vision-short-name }} или {{ translate-short-name }}.