# Устранение ошибки `ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE`


## Описание проблемы {#issue-description}

При прямом подключении к данным Яндекс Метрика из DataLens отображается сообщение об ошибке:

```
{
    "*******_result": {
        "code": "ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE",
        "status": 400,
        "sourceType": "bi_datasets",
        "message": "Invalid argument types for function <fuction>; 
        dialect: METRIKAAPI; types: (STRING);  however, the ClickHouse database supports such function.",
        "details": {}
    }
}
"Error: Request failed with status code 427\n)"
```

## Решение {#issue-resolution}

Такая ошибка возникает, когда прямое подключение к Яндекс Метрика не поддерживает используемую функцию. Со списком поддерживаемых функций можно ознакомиться [в документации](../../../datalens/function-ref/availability.md).

Для получения поддержки большинства функций можно выгрузить данные в ClickHouse® и производить подключение к базе данных. О том, как это сделать, мы пишем в статье [**Ответы на вопросы в DataLens**](../../../datalens/qa/index.md#uploading-data-logs-api).

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные рекомендации не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). 
При создании запроса укажите следующую информацию:

1. Ссылка на дашборд в DataLens.
1. Описание сценария использования.