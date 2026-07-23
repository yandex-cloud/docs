# SendEmail method

Sends an email from an [address](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

Alternatively, you can send emails via [SMTP protocol](../../quickstart.md#smtp).

## Request {#request}

```http
POST /v2/email/outbound-emails HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "ConfigurationSetName": "string",
  "FromEmailAddress": "<sender_address>",
  "FromEmailAddressIdentityArn": "<compatibility_parameter>",
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
  "Content": {
    "Simple": {
      "Subject": {
        "Data": "<subject_text>",
        "Charset": "<encoding>"
      },
      "Headers": [
        {
          "Name": "<header>",
          "Value": "<value>"
        }
      ],
      "Body": {
        "Text": {
          "Data": "<email_text>",
          "Charset": "<encoding>"
        },
        "Html": {
          "Data": "<email_text>",
          "Charset": "<encoding>"
        }
      },
      "Attachments": [
        {
          "FileName": "<file_name>",
          "RawContent": "<content_in_Base64>",
          "ContentType": "<MIME_type>",
          "ContentDescription": "<attachment_description>",
          "ContentDisposition": "<display_mode>",
          "ContentId": "<attachment_ID>",
          "ContentTransferEncoding": "base64"
        }
      ]
    },
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
      "TemplateData": "<data_to_insert_in_templates>",
      "Attachments": [
        {
          "FileName": "<file_name>",
          "RawContent": "<content_in_Base64>",
          "ContentType": "<MIME_type>",
          "ContentDescription": "<attachment_description>",
          "ContentDisposition": "<display_mode>",
          "ContentId": "<attachment_ID>",
          "ContentTransferEncoding": "base64"
        }
      ]
    },
    "Raw": {
      "Data": "<whole_email_content>"
    }
  },
  "ListManagementOptions": {
    "ContactListName": "<contact_list_name>",
    "TopicName": "<topic_name>"
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Name of the configuration used to send the email. If not specified, the system uses the configuration associated with the {{ postbox-name }} address. ||
|| `FromEmailAddress` | **Type**: String.

Address the email is sent from. The address must be verified. ||
|| `FromEmailAddressIdentityArn` | **Type**: String.

This parameter is not used. It is provided for compatibility with AWS. ||
|| `Destination` | **Type**: Object.

Object containing the address for sending the letter.

* `ToAddresses`: Addresses the email is sent to. Type: Array.
* `CcAddresses`: Addresses the email copy is sent to. Type: Array.
* `ToAddresses`: Addresses a BCC of the email is sent to. Type: Array. ||

|| `ListManagementOptions` | **Type**: Object.

Parameters to manage the [newsletter unsubscribe mechanism](../../concepts/unsubscribe.md).

* `ContactListName`: Contact list name. Type: String. This is a required setting.
* `TopicName`: Topic name inside the contact list. Type: String. This is an optional setting. ||
|| `Simple` | **Type**: Object.

Simple type. You cannot use it together with `Raw` or `Template`. Suitable if you need to send an email without any additional setup. Such an email consists of a subject line and content. Type: Object. ||
|| `Subject` | **Type**: Object.

Describes the subject:

* `Data`: Text of the subject. Type: String.
* `Charset`: Encoding. Type: String. The possible value is `UTF-8`. ||
|| `Headers` | **Type**: Array.
* `Name`: Header name. Type: String.
* `Value`: Header value. Type: String.

`Name` cannot be one of the limited headers: `BCC`, `CC`, `Content-Disposition`, `Content-Type`, `Date`,
`From`, `Message-ID`, `MIME-Version`, `Reply-To`, `Return-Path`, `Subject`, `To`.||
|| `Body` | **Type**: Object.

Describes the content:

* `Text`: Object responsible for displaying the email in clients without HTML support. Type: Object.
  * `Data`: Email text. Type: String.
  * `Charset`: Encoding. Type: String. The possible value is `UTF-8`.
* `Html`: Object responsible for displaying the email in clients with HTML support. Type: Object.
  * `Data`: Email text. Type: String.
  * `Charset`: Encoding. Type: String. The possible value is `UTF-8`. ||
|| `Attachments` | **Type**: Array.

The list of email attachments. Available in the content of the `Simple` and `Template` types. Each attachment is defined by an object with the following fields:

{% include [attachments-fields](../../../_includes/postbox/attachments-fields.md) %} ||
|| `Template` | **Type**: Object.

Template type. You cannot use it together with `Simple` or `Raw`. Suitable if you need to send an email based on a template. Only the templates provided in the request are supported.||
|| `TemplateContent` | **Type**: Object.

Contains an email template:

* `Html`: HTML template. Type: String.
* `Subject`: Subject template. Type: String.
* `Text`: Text template. Type: String. ||
|| `TemplateData` | **Type**: String.

Data required to fill the template. A JSON object serialized to a string. ||
|| `Raw` | **Type**: Object.

Raw type. You cannot use it together with `Simple` or `Template`. Suitable if your email content requires some additional setup. This type must satisfy the following requirements:

* The email must consist of a header and content separated by a blank line.
* All the required header fields must be present.
* For a MIME email, all fragments must be properly formatted.
* Attachments must be in a format supported by {{ postbox-name }}.
* The email must use Base64 encoding.
* Any content outside the 7-bit ASCII table must be encoded to be correctly displayed in the recipient’s email client.
* Maximum line length: 1,000 characters.

The whole email must reside in the `Data` parameter. Type: String. ||
|#

## Responses {#responses}

### 200 OK {#200}

```json
{
  "MessageId": "<email_ID>"
}
```

#|
|| **Parameter** | **Description** ||
|| `MessageId` | **Type**: String.

Unique ID of the email. ||
|#

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

{% include [errors-list](../../../_includes/postbox/errors-list.md) %}

## Useful links {#see-also}

* [{#T}](../index.md)
* [{#T}](../../api-ref/authentication.md)
* [{#T}](../../operations/send-templated-email.md)
