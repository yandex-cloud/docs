# Устранение ошибки ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE


## Описание проблемы {#issue-description}

При прямом подключении к данным Яндекс Метрики из DataLens отображается сообщение об ошибке:

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

Такая ошибка возникает, когда прямое подключение к Метрике не поддерживает используемую функцию.
Со списком поддерживаемых функций можно ознакомиться [в документации](../../../datalens/function-ref/availability).

Для получения поддержки большинства функций можно выгрузить данные из метрики в ClickHouse и производить подключение к базе данных.
О том, как это сделать, мы пишем в материале [Ответы на вопросы в DataLens](../../../datalens/qa/index.md#uploading-data-logs-api).

Вы можете поддержать реализацию этой идеи в [разделе «Сообщество»](https://cloud.yandex.ru/features/649). В этом разделе можно проголосовать и за реализацию других интересных идей. Мы регулярно просматриваем все предложения и добавляем их в планы по разработке. Как только идея, которую вы добавили или за которую проголосовали, будет реализована, мы напишем вам об этом.
