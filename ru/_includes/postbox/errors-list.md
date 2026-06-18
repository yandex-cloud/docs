Возможные ошибки:

#|
|| **Код ошибки** | **Описание** ||
|| `400 BadRequestException` | В запросе неправильно указаны заголовки или параметры. ||
|| `400 BadRequestException: sender is not allowed` | [Отправитель](../../postbox/concepts/glossary.md#sender) не входит в список разрешенных отправителей, которые указаны в настройках адреса. ||
|| `400 AccountSuspendedException` | Возможность отправлять почту для сервисного аккаунта, от имени которого выполняется запрос, навсегда ограничена. ||
|| `400 SendingPausedException` | Возможность отправлять почту для сервисного аккаунта, от имени которого выполняется запрос, временно ограничена. ||
|| `400 MessageRejected` | Письмо содержит некорректные данные. ||
|| `400 MailFromDomainNotVerifiedException` | Адрес, с которого отправляется письмо, не верифицирован. ||
|| `404 NotFoundException` | Запрошенный ресурс не найден. ||
|| `429 TooManyRequestsException` | При вызове запроса превышена [квота](../../postbox/concepts/limits.md#postbox-quotas). ||
|| `400 LimitExceededException` | При вызове запроса превышен [лимит](../../postbox/concepts/limits.md). ||
|#
