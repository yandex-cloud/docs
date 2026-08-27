#### Quotas {#postbox-quotas}

#|
|| Type of limit | Value ||
|| Maximum number of recipients per email
`postbox.recipients_per_email.count` | 200 ||
|| Maximum size of an email with attachments 
`postbox.email.size` | 10 MB ||
|| Maximum number of [addresses](../../postbox/concepts/glossary.md#adress) 
`postbox.identities.count` | 10 ||
|| Maximum email send rate 
`postbox.send.rate` | 1 email per second ||
|| Maximum rate of [SendBulkEmail](../../postbox/operations/send-bulk-email.md) method calls per cloud
`postbox.send_bulk.rate` | 1 request per second ||
|| Maximum number of emails that can be sent within a 24-hour time interval 
`postbox.emails_sent.count` | 200 ||
|| Maximum number of [configurations](../../postbox/concepts/glossary.md#configuration) 
`postbox.configuration_sets.count` | 5 ||
|#

#### Limits {#postbox-limits}

The [SendBulkEmail](../../postbox/operations/send-bulk-email.md) method has the following limits:

#|
|| Type of limit | Value ||
|| Maximum number of `BulkEmailEntries` elements per request | 50 ||
|| Maximum total number of recipients across all `BulkEmailEntries` elements^1^ | 500 ||
|| Maximum total size of the subject and body in a global template (`TemplateContent.Subject`, `TemplateContent.Text`, and `TemplateContent.Html`) | 1 MB ||
|| Maximum number of variables per global template | 50 ||
|#

^1^ When counting recipients, the addresses from `ToAddresses`, `CcAddresses`, and `BccAddresses` are included.
