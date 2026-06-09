# Устранение ошибки `The request signature we calculated does not match the signature you provided.`


## Описание проблемы {#issue-description}

При попытке работы с бакетом {{ objstorage-short-name }} через стороннюю утилиту (консольные клиенты, десктопные клиенты, SDK) возникает ошибка:

```
An error occurred 
(SignatureDoesNotMatch) when calling the PutObject operation: 

The request signature we calculated does not match the signature you provided. 
Check your key and signing method.
```

## Решение {#issue-resolution}

Часто ошибка говорит о том, что неверно указан [статический ключ доступа](../../../iam/concepts/authorization/access-key.md). Проверьте, что статический ключ корректен и указан в правильном формате.

Чтобы провести более глубокую диагностику, выполните операцию с помощью [AWS CLI](../../../storage/tools/aws-cli.md) с использованием параметра `--debug`. Вывод будет содержать отладочную информацию: например, промежуточные результаты расчета подписи, с которыми можно свериться.


## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса отправьте вывод операции, выполненной через [AWS CLI](../../../storage/tools/aws-cli.md) с использованием параметра `--debug`.