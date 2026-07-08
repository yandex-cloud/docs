The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `400 BadRequestException: sender is not allowed` | The [sender](../../postbox/concepts/glossary.md#sender) is not listed among the allowed senders in the address settings. ||
|| `400 AccountSuspendedException` | The service account that sent the request was permanently restricted from sending emails. ||
|| `400 SendingPausedException` | The service account that sent the request was temporarily restricted from sending emails. ||
|| `400 MessageRejected` | The email contains invalid data. ||
|| `400 MailFromDomainNotVerifiedException` | The address the email comes from is not verified. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../postbox/concepts/limits.md#postbox-quotas) was exceeded. ||
|| `400 LimitExceededException` | The request [limit](../../postbox/concepts/limits.md) was exceeded. ||
|#
