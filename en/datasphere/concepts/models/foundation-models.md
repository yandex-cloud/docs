# Foundation models in {{ ml-platform-name }}

{{ ml-platform-full-name }} enables you to use foundation models to meet your objectives and retrain them on your own data if needed. Retraining is based on the Fine-tuning method with results stored in {{ ml-platform-name }}.

{% note info %}

Foundation model retraining is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

The {{ yagpt-name }} model is available under **Foundation models**. You can use it in {{ ml-platform-name }} as is or retrain it on your own data to make model responses more tailored to your specific tasks. Model retraining results will be available from {{ ml-platform-name }} projects and via the [{{ yagpt-name }} API](../../../yandexgpt/api-ref/authentication.md).

## Data required for {{ yagpt-name }} retraining {#yagpt-tuning}

To retrain the {{ yagpt-name }} model using the Fine-tuning method, prepare a JSON file with at least ten sample queries and reference responses. Save the file in the [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding:

```json
[
  {
    "request": "text query",
    "response": "expected response"
  },
  {
    "request": "another text query",
    "response": "new expected response"
  },
  …
]
```

The file may contain up to 10,000 questions and responses. The maximum size of a query is 4,000 characters and that of a reference response is 2,000 characters.

In the {{ ml-platform-name }} interface, create a new fine-tuned foundation model, enter instructions for the model, set the tuning rate, and upload your data. It takes some time to tune the model.

## Requests to a fine-tuned model {#requests}

You can send requests to a fine-tuned model through the {{ ml-platform-name }} Playground interface or the API from {{ ml-platform-name }} and other applications. In Playground, requests are made on behalf of a user with the model access flag set. You can send requests through Playground to the original or fine-tuned model to compare the results.

To make API requests, add a user account or service account you are going to use to submit requests to the list of {{ ml-platform-name }} project members. Make sure the account has the `ai.languageModels.user` role and its cloud has access to {{ yagpt-name }}.
