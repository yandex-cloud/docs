# Ошибки

При возникновении ошибки {{ cns-name }} отвечает сообщением с соответствующим HTTP-кодом и дополнительным описанием в формате XML или JSON в зависимости от указанного параметра `ResponseFormat`.

Схема данных:

{% list tabs %}

- XML

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <ErrorResponseXML>
	  <RequestId>string</RequestId>
	  <Error>
		  <Code>string</Code>
		  <Message>string</Message>
	  </Error>
  </ErrorResponseXML>
  ```

- JSON

  ```json
  {
    "ErrorResponse": {
      "RequestId": "string",
      "Error": {
        "Code": "string",
        "SubCode": "string",
        "Message": "string"
      }
    }
  }
  ```

{% endlist %}

Где:
* `RequestId` — идентификатор запроса.
* `Code` — код ошибки.
* `Message` — описание ошибки.

## Перечень общих кодов ошибок {#errors}

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | InvalidParameter | InvalidParameter | Передан неверный параметр. Название параметра содержится в поле `ParamName`.
400 | InvalidParameter | InvalidAttribute | Передан неверный атрибут. Название атрибута содержится в поле `ParamName`.
403 | AuthorizationError | NoCredentials | [AWS Signature V4](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-signing.html) или [IAM-токен](../../iam/concepts/authorization/iam-token.md) не переданы, либо переданы в некорректном формате.
403 | AuthorizationError | Unauthenticated | Аутентификация не пройдена.
403 | AuthorizationError | Unauthorized | Недостаточно прав для выполнения операции.
404 | NotFound | AccountNotFound | Аккаунт (идентификатор [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud)) не найден.
404 | NotFound | FolderNotFound | [Каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) с указанным идентификатором не существует.
429 | ThrottlingException | TooManyRequests | Слишком много запросов. Уменьшите частоту обращений.

## Перечень кодов ошибок, специфичных для действий с PlatformApplication и PlatformEndpoint {#errors-push}

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
404 | NotFound | AppNotFound | Канала мобильных push-уведомлений с указанным идентификатором (ARN) не существует.
404 | NotFound | EndpointNotFound | Мобильного эндпоинта с указанным идентификатором (ARN) не существует.

## Перечень кодов ошибок, специфичных для действий с SMS {#errors-sms}

HTTP | Код ошибки | Дополнительный код | Описание
--- | --- | --- | ---
400 | serError | SMSChannelIsBanned | Канал SMS-уведомлений заблокирован.
404 | NotFound | SMSChannelNotFound | Канал SMS-уведомлений с указанным идентификатором (ARN) не существует.