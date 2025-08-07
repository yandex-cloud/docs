# Working with dialogs

When in a [dialog](../../concepts/dialogs.md), you can get detailed information about the dialog, listen to the conversation audio, and look up the customer's text chat with the agent or bot.

## Viewing a list of dialogs {#list-dialogs}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.

By default, the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab shows 100 most recent dialogs. To see the previous dialogs, click **{{ ui-key.yc-ui-talkanalytics.common.show-more }}** at the end of the list.

## Finding dialogs {#search-dialogs}

Use the following to search for dialogs:
* [Filters](#filters-dialogs)
* [Full-text search](#full-text-search)
* [Dictionary search](#dictionary-search)
* [Semantic search](#sense-search)

To get more information about each dialog, [customize the columns](#set-columns).

### Filters {#filters-dialogs}

To apply a filter to dialogs:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. Select the required filter and enter its value.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

You can add multiple filters. They will be combined by the logical `AND` operation to find the dialogs satisfying all the conditions that were specified.

### Full-text search {#full-text-search}

Full-text search allows you to find dialogs containing a specific word or phrase. The better the dialog text matches the search query and the more frequently it occurs, the higher is the dialog placed in the search results.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/square-dashed-text.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.text.title }}**.
1. Enter the text fragment you are looking for in the search bar.
1. Optionally, to refine your search results, select the channel you want to search in from the drop-down list below the search bar: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, or **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
1. Click **{{ ui-key.yacloud.common.search }}**.

### Dictionary search {#dictionary-search}

The dictionary search allows you to find dialogs containing one or more specified key phrases.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/square-dashed-letter-t.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.dictionary.title }}**.
1. Enter a key phrase or phrases in the search bar. Use a new row for each one.

   {% include [key-phrases-restrictions](../../../_includes/speechsense/data/key-phrases-restrictions.md) %}

1. (Optional) To refine your search results:

   * Select the channel you want to search in from the drop-down list: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, or **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
   * Select the allowable distance between words in the key phrase.
   * Enable **{{ ui-key.yc-ui-talkanalytics.dialogs.exact-match-by-key-phrases }}**.
1. Click **{{ ui-key.yacloud.common.search }}**.

### Semantic search {#sense-search}

The semantic search allows you to find dialogs that match the meaning of the search query in the context of the selected [semantic attribute](../../concepts/reports/sense-attributes.md). The search results will only contain dialogs matching the search query, arranged in descending order of the likelihood of matching.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/neuro-tag.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.neuro.title }}**.
1. Select one of the semantic attributes from the drop-down list.
1. In the search bar, select a search query from the auto [suggestions](../../concepts/tags.md#suggestions) or enter it manually.

   If there are more than 1,000 dialogs in the project, {{ speechsense-name }} will analyze only 1,000 random dialogs to generate suggestions. If not happy with the auto suggestions, you can click **{{ ui-key.yacloud.common.update }}**. {{ speechsense-name }} will select 1,000 more random dialogs, analyze them, and generate new suggestions.

1. Click **{{ ui-key.yacloud.common.search }}**.

## Customizing column display {#set-columns}

By default, not all columns are displayed in the dialog list. You can display additional columns, hide the ones you do not need, and reorder them.

To customize the columns:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the title row for the list of dialogs, click ![image](../../../_assets/console-icons/gear.svg). This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Check any additional columns you want displayed.
    * Uncheck the columns you do not need. Some columns cannot be hidden, so you cannot uncheck them.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column to a new position in the list.

1. Click **Apply**.

## Viewing a dialog {#view-dialog}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. [Find the dialog you need](#search-dialogs).
1. Open the dialog in one of the following ways:

    * To open a dialog preview, click the dialog line.
    * To open the dialog in a new window, click ![image](../../../_assets/console-icons/arrow-up-right-from-square.svg) on the right in the dialog line.

The dialog page displays the following information:

* Metadata such as agent and customer names, call or message date, dialog language.
* Conversation audio (only for audio).
* Conversation contents on the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialog }}** tab.
* Semantic analysis of the conversation on the **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}** tab.
* [Tags](../../concepts/tags.md) assigned to the dialog.

For more information, see [{#T}](../../concepts/dialogs.md#details).

## Editing dialog metadata {#edit-dialog-metadata}

Editing dialog metadata can be of use in some situations. For example, you can add a score to an already uploaded dialog after the customer has rated it.

You can update metadata values for keys that were added [when creating the connection](../connection/create.md). You cannot add metadata if there is none in the connection settings.

You can edit dialog metadata via the {{ yandex-cloud }} gRPC API. To do this:

1. [Get the dialog ID](#get-dialog-id).
1. [Get your infrastructure ready for the {{ yandex-cloud }} gRPC API](#prepare-grpc-api).
1. [Get the dialog information](#get-dialog-info).
1. [Edit the dialog metadata](#edit-metadata).

### Get the dialog ID {#get-dialog-id}

Find the dialog you need and copy its ID:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. On the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, [find the dialog](#search-dialogs) and navigate to it.
1. Copy the dialog ID from the upper-left corner.

### Get your infrastructure ready for the {{ yandex-cloud }} gRPC API {#prepare-grpc-api}

{% include [software](../../../_includes/speechsense/data/software.md) %}

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

### Get the dialog information {#get-dialog-info}

Use the [TalkService/Get](../../api-ref/grpc/Talk/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}.

The examples use demo data.

**Request:**

```bash
grpcurl \
    -format json \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/yandex/cloud/speechsense/v1/talk_service.proto \
    -rpc-header "Authorization: Bearer $IAM_TOKEN" \
    -d '{
          "space_id": "f3fuc***************",
          "project_id": "eagpe***************",
          "talk_ids": [
            "aud78***************"
          ]
        }' \
    api.speechsense.yandexcloud.net:443 \
    yandex.cloud.api.speechsense.v1.TalkService.Get
```

**Response:**

```json
{
  "talk": [
    {
      "id": "aud78***************",
      "organizationId": "yc.organization-manager.example",
      "spaceId": "f3fuc***************",
      "connectionId": "eagjj***************",
      "projectIds": [
        "eagpe***************"
      ],
      "createdBy": "ajegr***************",
      "createdAt": "2025-04-24T14:35:19.882Z",
      "modifiedBy": "CLASSIFIER",
      "modifiedAt": "2025-04-24T14:35:24.470980Z",
      "talkFields": [
        {
          "name": "operator_name",
          "value": "John",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "11111",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Alexander",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "22222",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2025-04-24T14:34:19Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "ru-ru",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "score_main",
          "type": "FIELD_TYPE_STRING"
        }
      ],
    // ...
    }
  ]
}
```

The response contains the dialog metadata in the `talkFields` field:

* `operator_name`: Agent name.
* `operator_id`: Agent ID.
* `client_name`: Customer name.
* `client_id`: Customer ID.
* `date`: Dialog start date and time, in `YYYY-MM-DDTHH:MM:SSSZ` format.

   {% include [data-format](../../../_includes/speechsense/data/data-format.md) %}

* `direction_outgoing`: Dialog direction (incoming or outgoing).
* `language`: Dialog language.
* `score_main`: Dialog score. Optional key; the value will be added when editing the metadata.

### Edit the dialog metadata {#edit-metadata}

{% note info %}

When editing the dialog metadata, remember to provide all keys; otherwise, their values will be deleted.

{% endnote %}

To edit audio metadata, use the [TalkService/Upload](../../api-ref/grpc/Talk/upload.md) call. To edit chat metadata, use the [TalkService/UploadText](../../api-ref/grpc/Talk/uploadText.md) call. Send a request, e.g., using {{ api-examples.grpc.tool }}.

The example uses demo data.

**Request:**

The request adds a new `score_main` key value; other key values are provided unchanged.

```bash
grpcurl \
    -format json \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/speechsense/v1/talk_service.proto \
    -rpc-header "Authorization: Bearer $IAM_TOKEN" \
    -d '{
          "talkId": "aud78***************",
          "metadata": {
            "connectionId": "eagjj***************",
            "fields": {
              "date": "2025-04-24T14:34:19Z",
              "direction_outgoing": "true",
              "language": "ru-ru",
              "operator_name": "John",
              "operator_id": "11111",
              "client_name": "Alexander",
              "client_id": "22222",
              "score_main": "4"
            }
          }
        }' \
    api.speechsense.yandexcloud.net:443 \
    yandex.cloud.speechsense.v1.TalkService.Upload
```

## Example of searching dialogs by time period and text fragment {#example-find-dialogs-by-period-and-text}

Search criteria:

* Period: `10.11.2023 - 16.11.2023`.
* Contains the customer's utterance: `good service`.

Follow these steps:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, enter `good service` in the search bar.
1. To the right of the search bar, select the **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}** channel from the drop-down list.
1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}** group, select the **Start date** filter. As the filter value, specify the `10.11.2023 - 16.11.2023` date range.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

The filtered dialogs will be displayed as a result.

Example of ranking dialogs depending on the found text fragments:

#|
|| **No.** | **Dialog date** | **Dialog fragment** ||
|| 1 | 16.11.2023 | thank you for `good service` ||
|| 2 | 13.11.2023 | `good` equipment and `service` ||
|| 3 | 15.11.2023 | full system `service` ||
|#
