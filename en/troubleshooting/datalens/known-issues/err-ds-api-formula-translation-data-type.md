# Resolving the `ERR.DS_API.FORMULA.TRANSLATION.DATA_TYPE` error


## Issue description {#issue-description}

When you connect directly to {{ metrika }} data from {{ datalens-name }}, you see this error message:

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

Such an error occurs when the direct connection to {{ metrika }} does not support the function you use. You can review the list of supported functions [here](../../../datalens/function-ref/availability).

To enable support for most functions, you can export data to {{ CH }} and connect to the database. To learn how to do this, see our **{{ datalens-name }} FAQs** [here](../../../datalens/qa/index.md#uploading-data-logs-api).

## If the issue persists {#if-issue-still-persists}

If the tips we provided above did not help you resolve the issue, [create a support ticket]({{ link-console-support }}). 
Provide the following information in your ticket:

1. Link to your dashboard in {{ datalens-name }}.
1. Description of how you use it.
 
