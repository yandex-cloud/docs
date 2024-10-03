# Resolving the ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE error


## Issue description {#issue-description}

When you connect directly to Yandex Metrica data from DataLens, you see this error message:

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

## Solution {#issue-resolution}

Such an error occurs when the direct connection to Yandex Metrica does not support the function you use.
You can review the list of supported functions in the [documentation](../../../datalens/function-ref/availability).

To enable support for most functions, you can export data from Yandex Metrica to ClickHouse and connect to the database.
To learn how to do this, see the [Answers to DataLens questions](../../../datalens/qa/index.md#uploading-data-logs-api) article.

You can vote for implementation of this idea in the [Community section](https://cloud.yandex.ru/features/649). There, you can also upvote other interesting ideas. We review all the community suggestions regularly, adding them to our roadmap. As soon as we implement the idea you added or upvoted, we will write to you about this.
