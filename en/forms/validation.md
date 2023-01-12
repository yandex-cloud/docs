# Use an external response validator

To check responses for which no standard validation methods can be used (for example, to prompts of the [<q>Short text</q>](blocks-ref/short-text.md) and [<q>Number</q>](blocks-ref/number.md) type), you can use an external validation server.


## to enable an external validator {#enable}

1. Select the form and open the **Settings** → **Additional** tab.

1. Enable the **Response validation** and specify the validation server address.

1. Click **Save**.

1. In the settings of responses to be checked using an external server, select **External validator** in the **Validation** block.


## Format and responses {#format}

Data from a form is transferred to the validation server in the following format:

```json
{
    id: 443,
    slug: "test-survey",
    name: "Test form",
    questions: [
      {
        answer_type: {
            slug: "answer_short_text",
            name: "Short response",
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

The server validation should return response in format:

- If the validation is successful, you'll see any response with the code 200 or:

   ```json
   {
     status: "OK"
   }
   ```

- If the validation fails, an error message is returned for each incorrect response:

   ```json
   {
     "status": "ERROR",
     "errors": {
       "answer_short_text_30385": [ "Incorrect value" ],
       "answer_long_text_30391": [ "Incorrect answer type", "Incorrect value" ]
     }
   }
   ```

See an [example](https://a.yandex-team.ru/arcadia/intranet/forms/src/events/surveyme/views.py) of validator implementation.