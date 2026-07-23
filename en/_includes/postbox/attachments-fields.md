* `FileName`: Attachment file name. Type: String. This is a required field. It should not contain the `/` and `\` symbols. The file extension must not be on the [list of limitations](../../postbox/concepts/restrictions.md).
* `RawContent`: Base64-encoded file contents. Type: String (byte). This is a required field. Should not be empty.
* `ContentType`: MIME type of the content, e.g., `application/pdf`. Type: String. This is an optional field. If not specified, the type can be identified from file extension. If unable to figure out the type, use `application/octet-stream`.
* `ContentDescription`: Attachment description, transmitted in the `Content-Description` MIME header. Type: String. This is an optional field.
* `ContentDisposition`: Attachment display mode. Type: String. This is an optional field. The values ​​are not case sensitive:
  * `ATTACHMENT`: Attachment provided as a separate file. This is a default value.
  * `INLINE`: Attachment embedded into the body of the email, e.g., image in HTML. The email must contain an HTML body.
* `ContentId`: Attachment ID you can reference from HTML using the `cid:` scheme. Type: String. Required field for attachments with `ContentDisposition`: `INLINE`. It must be unique within the email.
* `ContentTransferEncoding`: Content encoding method. Type: String. This is an optional field. The only supported value is `base64` (case insensitive).

For more information on attachment restrictions, see [{#T}](../../postbox/concepts/restrictions.md).
