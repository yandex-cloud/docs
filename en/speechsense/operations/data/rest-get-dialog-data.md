---
title: Getting information about a dialog in REST API
description: Follow this guide to get information about a dialog in REST API.
---

# Getting information about a dialog in REST API

## Getting started {#before-you-begin}

To get information about a dialog via the {{ yandex-cloud }} REST API: 

{% include [before-you-begin](../../../_includes/speechsense/data/rest-search-before-you-begin.md) %}

1. Get the dialog ID using [full-text search](rest-full-text-search.md) or [filtering by parameters](rest-search-filters.md).

## Getting information about a dialog {#get-dialog-data}

1. In the folder, create a file named `get.json` with the following [parameters](#get-query-ref) to get the dialog you need: 

    ```json
    {
      "organizationId": "<organization_ID>",
      "spaceId": "<space_ID>",
      "connectionId": "<connection_ID>",
      "projectId": "<project_ID>",
      "talkIds": [
        "<dialog_ID>"
      ],
      "resultsMask": {
        "paths": [
          "<requested_field_keys>"
        ]
      }
    }
    ```

    Where:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

    * `talkIds`: IDs of the dialogs you want to get information about. To find out the dialog IDs, use a [search query](#search-query).
    * `resultsMask`: Result mask. If this parameter is not provided, you will get the full information about the dialog, whereas if the parameter is provided with an empty `paths` list, you will get only the basic information about the dialog, such as the IDs of the project, connection, and space, information about when and by whom the dialog was created or modified, and the metadata added when uploading the dialog. To unload individual fields with data, provide the keys of the required fields in the `paths` list to the mask:

      * `transcription`: Audio text transcript or chat text messages.
      * `speechStatistics`: Speech statistics.
      * `silenceStatistics`: Statistics of pauses in the dialog.
      * `interruptsStatistics`: Statistics of dialog partner interruptions.
      * `conversationStatistics`: Dialog statistics.
      * `points`: Dialog summary.
      * `textClassifiers`: Statistics for classifiers (tags).

    For more information about GET request parameters, see the [API reference](../../api-ref/Talk/get.md).  

1. Make a GET request to the {{ speechsense-name }} API using cURL: 

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @get.json
    ```

    Where `Api-Key` is the API key for authentication. If using an IAM token, specify `Bearer ${IAM_TOKEN}` instead of `Api-Key ${API_KEY}`.

    The results will be output to the terminal in JSON format.

## Request body example for getting information about a dialog {#get-chat-info-example}

For example, you need to get a summary of a dialog with technical support where the agent proposed filing a ticket for a technician's visit. To get the ID of the dialog, use [this request example for full-text search](#full-text-search-example).

Your JSON file with the request parameters will look as follows:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "talkIds": ["aud95sn63lra********"],
  "resultsMask": {
    "paths": ["points"]
  }
}
```

{% cut "Query execution results" %}

```json
{
  "talk": [
    {
      "id": "aud95sn63lra********",
      "organizationId": "yc.organization****************",
      "spaceId": "f3fuclf1kufs********",
      "connectionId": "eag0u346n4hn********",
      "projectIds": [
        "eag9t3rm3o43********"
      ],
      "createdBy": "ajeugoqa16o5********",
      "createdAt": "2024-09-24T08:53:09.932Z",
      "modifiedBy": "CLASSIFIER",
      "modifiedAt": "2024-09-24T18:06:08.299Z",
      "talkFields": [
        {
          "name": "operator_name",
          "value": "Agent",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "operator_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Customer",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "customer_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_name",
          "value": "Bot",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_id",
          "value": "bot_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2024-09-24T11:11:11.111Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "Russian",
          "type": "FIELD_TYPE_STRING"
        }
      ],
      "transcription": null,
      "speechStatistics": null,
      "silenceStatistics": null,
      "interruptsStatistics": null,
      "conversationStatistics": null,
      "points": {
        "quiz": [
          {
            "request": "1. Was the agent polite?",
            "response": "1. Yes",
            "id": "1"
          },
          {
            "request": "2. Was the agent annoyed?",
            "response": "2. No",
            "id": "2"
          },
          {
            "request": "3. Was the agent engaged in the dialog?",
            "response": "3. No",
            "id": "3"
          },
          {
            "request": "4. Was the agent empathic?",
            "response": "4. Yes",
            "id": "4"
          },
          {
            "request": "5. Was the agent rude?",
            "response": "5. No",
            "id": "5"
          },
          {
            "request": "6. Did the agent solve the customer's problem?",
            "response": "6. No",
            "id": "6"
          },
          {
            "request": "7. Was the agent confident?",
            "response": "7. Yes",
            "id": "7"
          },
          {
            "request": "8. Did the customer leave annoyed?",
            "response": "8. No",
            "id": "8"
          },
          {
            "request": "9. Was the customer satisfied?",
            "response": "9. Yes",
            "id": "9"
          },
          {
            "request": "10. Was the customer rude?",
            "response": "10. No",
            "id": "10"
          }
        ]
      },
      "textClassifiers": null
    }
  ]
}
```

{% endcut %}
