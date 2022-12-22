# Use an external response validator

You can use an external validation server to validate responses to prompts for which no standard validation methods exist (for example, [<q>Short text</q>](blocks-ref/short-text.md) and [<q>Number</q>](blocks-ref/number.md) prompts).

## Enable an external validator {#enable}

1. Select the form and go to **Settings** → **Additional**.

1. Enable the **Response validation** option and specify the validation server address.

1. Click **Save**.

1. In the settings for prompts that need to be validated using an external server, select **External validator** in the **Validation** block.

## Data format and responses {#format}

The data from the form is transmitted to the validation server in the following format:

```json
{
    id: 443,
    slug: "test-survey",
    name: "Test form",
    questions: [
      {
        answer_type: {
            slug: "answer_short_text",
            name: "Short answer",
        },
        id: 30373,
        label: "Place of work",
        slug: "answer_work_place",
        value: "Yandex LLC"
      }
      ...
    ]
}
```

The validation server should return a response in the following format:

- If validation is successful, any response with the 200 code or:

  ```json
  {
    status: "OK"
  }
  ```

- If there is a validation error, an error message for each incorrect response:

  ```json
  {
    "status": "ERROR",
    "errors": {
      "answer_short_text_30385": [ "Incorrect value" ],
      "answer_long_text_30391": [ "Incorrect answer type", "Incorrect value" ]
    }
  }
  ```

Here is an [example](https://a.yandex-team.ru/arcadia/intranet/forms/src/events/surveyme/views.py) of using the validator.

