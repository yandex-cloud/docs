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
      "Body": {
        "Text": {
          "Data": "<email_text>",
          "Charset": "<encoding>"
        },
        "Html": {
          "Data": "<email_text>",
          "Charset": "<encoding>"
        }
      }
    },
    "Raw": {
      "Data": "<overall_email_content>"
    }
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `FromEmailAddress` | **Type**: String.

Address the email is sent from. The address must be verified. ||
|| `FromEmailAddressIdentityArn` | **Type**: String.

Used exclusively for compatibility with AWS. ||
|| `Destination` | **Type**: Object.

Object containing parameters that describe your email. ||
|| `Simple` | **Type**: Object.

Simple type. You cannot use it together with `Raw`. A good choice if you need to send an email with no advanced settings. Such an email consists of a subject line and content. Type: Object. ||
|| `Subject` | **Type**: Object.

Describes the subject:
  * `Data`: Text of the subject. Type: String.
  * `Charset`: Encoding. Type: String. Possible values: `UTF-8`, `ISO-8859-1`, and `Shift_JIS`. ||
|| `Body` | **Type**: Object.

Describes the content:
  * `Text`: Object in charge of displaying the email in clients without HTML support. Type: Object.
      * `Data`: Email text. Type: String.
      * `Charset`: Encoding. Type: String. Possible values: `UTF-8`, `ISO-8859-1`, and `Shift_JIS`.
  * `Html`: Object in charge of displaying the email in clients with HTML support. Type: Object.
      * `Data`: Email text. Type: String.
      * `Charset`: Encoding. Type: String. Possible values: `UTF-8`, `ISO-8859-1`, and `Shift_JIS`. ||
|| `Raw` | **Type**: Object.

Raw type. You cannot use it together with `Simple`. A good choice if your email content requires advanced setup. This type must satisfy the following requirements:
  * The email must consist of a header and content separated by a blank line.
  * All the required header fields must be present.
  * For a MIME email, all fragments must be properly formatted.
  * Attachments must be in a format supported by {{ postbox-name }}.
  * Encoding: `Base64`.
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

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `400 AccountSuspendedException` | For this service account, sending email is disabled permanently. ||
|| `400 SendingPausedException` | For this service account, sending email is disabled temporarily. ||
|| `400 MessageRejected` | The email contains invalid data. ||
|| `400 MailFromDomainNotVerifiedException` | The address the email comes from is not verified. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|| `429 LimitExceededException` | The request [limit](../../concepts/limits.md) was exceeded. ||
|#

## See also {#see-also}

* [How to use the Amazon S3 API to work with {{ postbox-name }}](../index.md)
* [Authentication with the {{ postbox-full-name }} API](../../api-ref/authentication.md)