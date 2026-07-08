# SendBulkEmail method

Sends multiple template emails from an [address](../../concepts/glossary.md#adress) in the folder. The folder is selected based on the service account the request originates from.

A single request contains a shared template and emails to send. For each email, you specify recipients, data to populate the template, headers, and tags.

## Request {#request}

```http
POST /v2/email/outbound-bulk-emails HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "ConfigurationSetName": "string",
  "FromEmailAddress": "<sender_address>",
  "ReplyToAddresses": [
    "<reply-to_address>"
  ],
  "DefaultEmailTags": [
    {
      "Name": "<label_name>",
      "Value": "<label_value>"
    }
  ],
  "DefaultContent": {
    "Template": {
      "Headers": [
        {
          "Name": "<header>",
          "Value": "<value>"
        }
      ],
      "TemplateContent": {
        "Html": "<HTML_template>",
        "Subject": "<subject_template>",
        "Text": "<text_template>"
      },
      "TemplateData": "<data_to_populate_template>"
    }
  },
  "BulkEmailEntries": [
    {
      "Destination": {
        "ToAddresses": [
          "<recipient_address>"
        ],
        "CcAddresses": [
          "<copy_recipient_address>"
        ],
        "BccAddresses": [
          "<blind_copy_recipient_address>"
        ]
      },
      "ReplacementEmailContent": {
        "ReplacementTemplate": {
          "ReplacementTemplateData": "<data_to_populate_template>"
        }
      },
      "ReplacementHeaders": [
        {
          "Name": "<header>",
          "Value": "<value>"
        }
      ],
      "ReplacementTags": [
        {
          "Name": "<label_name>",
          "Value": "<label_value>"
        }
      ]
    }
  ]
}
```

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Name of the configuration used to send emails. If not specified, the system uses the configuration associated with the {{ postbox-name }} address. ||
|| `FromEmailAddress` | **Type**: String.

Address the emails are sent from. The address must be verified. This is a required setting. ||
|| `ReplyToAddresses` | **Type**: Array.

Addresses where recipients' replies will be sent. ||
|| `DefaultEmailTags` | **Type**: Array.

Labels that apply to all emails in the request.

* `Name`: Label name. Type: String.
* `Value`: Label value. Type: String.

The label name and value may contain Latin letters, numbers, hyphens, and underscores. Maximum length is 256 characters. ||
|| `DefaultContent` | **Type**: Object.

Object with common email content. ||
|| `Template` | **Type**: Object.

Template type. The email template is passed in the request. ||
|| `Headers` | **Type**: Array.

Headers that apply to all emails in the request.

* `Name`: Header name. Type: String.
* `Value`: Header value. Type: String.

`Name` cannot be one of the limited headers: `BCC`, `CC`, `Content-Disposition`, `Content-Type`, `Date`, `From`, `Message-ID`, `MIME-Version`, `Reply-To`, `Return-Path`, `Subject`, or `To`. ||
|| `TemplateContent` | **Type**: Object.

Contains an email template:

* `Html`: HTML template. Type: String.
* `Subject`: Subject template. Type: String. This is a required setting.
* `Text`: Text template. Type: String.

Make sure to specify at least one of the following parameters: either `Html` or `Text`. ||
|| `TemplateData` | **Type**: String.

Default data used to populate the template. A JSON object serialized to a string. ||
|| `BulkEmailEntries` | **Type**: Array.

List of emails to send. The request must contain at least one element. ||
|| `Destination` | **Type**: Object.

Object containing the address for sending the letter.

* `ToAddresses`: Addresses the email is sent to. Type: Array.
* `CcAddresses`: Addresses the email copy is sent to. Type: Array.
* `ToAddresses`: Addresses a BCC of the email is sent to. Type: Array.

Make sure to specify at least one address in `ToAddresses`, `CcAddresses`, or `BccAddresses` for each `BulkEmailEntries` element. ||
|| `ReplacementEmailContent` | **Type**: Object.

Data that overrides the email contents for an individual `BulkEmailEntries` element. ||
|| `ReplacementTemplate` | **Type**: Object.

Object with data for substitution into the individual email template. ||
|| `ReplacementTemplateData` | **Type**: String.

Data for filling the template of an individual email. A JSON object serialized to a string. Values from `ReplacementTemplateData` override identically named values from `TemplateData`. ||
|| `ReplacementHeaders` | **Type**: Array.

Headers of an individual email. They complement or override the headers from `DefaultContent.Template.Headers`. The format is the same as for `Headers`. ||
|| `ReplacementTags` | **Type**: Array.

Labels of an individual email. They complement or override the labels from `DefaultEmailTags`. The format is the same as for `DefaultEmailTags`. ||
|#

### Limits {#limits}

The `SendBulkEmail` method has the following limits:

* The maximum number of `BulkEmailEntries` elements in a single request is 50.
* The maximum total number of recipients across all `BulkEmailEntries` elements is 500.
* The maximum total size of `TemplateContent.Subject`, `TemplateContent.Text`, and `TemplateContent.Html` combined is 1 MB.
* The maximum number of variables in a template is 50.

Template uses the [Handlebars](https://handlebarsjs.com/guide/) syntax and supports simple substitutions.

## Responses {#responses}

### 200 OK {#200}

```json
{
  "BulkEmailEntryResults": [
    {
      "Status": "SUCCESS",
      "MessageId": "<email_ID>"
    },
    {
      "Status": "INVALID_PARAMETER",
      "Error": "<error_description>"
    }
  ]
}
```

#|
|| **Parameter** | **Description** ||
|| `BulkEmailEntryResults` | **Type**: Array.

Email sending results. The order of elements in the response corresponds to that `BulkEmailEntries` in the request. ||
|| `Status` | **Type**: String.

Status of processing an individual email. If the email is accepted for sending, `SUCCESS` is returned. If the email is not accepted, an error status is returned, e.g., `INVALID_PARAMETER`. ||
|| `MessageId` | **Type**: String.

Unique ID of the email. It is returned for emails with the `SUCCESS` status. ||
|| `Error` | **Type**: String.

Error description. Returned for emails that were not accepted for sending. ||
|#

If the error applies to the entire request, the method returns a request-level error. If the error only applies to an individual `BulkEmailEntries` element, the method returns `200 OK`, and the error is indicated in the corresponding `BulkEmailEntryResults` element.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

{% include [errors-list](../../../_includes/postbox/errors-list.md) %}

## Useful links {#see-also}

* [{#T}](../index.md)
* [{#T}](../../api-ref/authentication.md)
* [{#T}](../../operations/send-bulk-email.md)
