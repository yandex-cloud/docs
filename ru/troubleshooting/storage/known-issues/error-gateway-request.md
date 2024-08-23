# Устранение ошибки `GATEWAY_REQUEST_ERROR`


## Описание проблемы {#issue-description}

При попытке изменения ACL-конфигурации бакета {{ objstorage-short-name }} появляется сообщение об ошибке:

```
message: Access Denied; 
status: undefined; 
description: Access Denied; 
code: GATEWAY_REQUEST_ERROR; 
Request ID: undefined; 
Trace ID: undefined;
```

## Решение {#issue-resolution}

Чаще всего ошибка `Access Denied` возникает из-за неправильно настроенной политики доступа. Для изменения ACL-конфигурации бакета необходима роль`storage.admin` или `storage.editor`.

Рекомендуем убедиться, что в поле **Ресурс** внутри политики доступа указано два значения: `bucket_name/*` и `bucket_name/`.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Имя бакета {{ objstorage-short-name }}.
1. Скриншот или полный текст сообщения об ошибке.