# Устранение ошибки `ConnectTimeoutError` при установке пакетов через pip


## Описание проблемы {#issue-description}

Попытка установки новых пакетов Python в проекте {{ ml-platform-short-name }} возвращает ошибку:
```
% pip install langchain
Defaulting to user installation because normal site-packages is not writeable
WARNING: Retrying (Retry (total=4, connect=None, read=None, redirect=None, status=None))
after connection broken by; ConnectTimeoutError(pip._v endor.urllib3.connection.HTTPSConnection object at 0x7f711cb08df0;
Connection to pypi.org timed out. (connect timeout=15)))
```

## Решение {#issue-resolution}

Необходимо проверить, указана ли в проекте подсеть и указан ли в ее параметрах NAT-шлюз для выхода в интернет. NAT-шлюз можно настроить по [этой инструкции](../../../vpc/operations/create-nat-gateway.md).

Если это не поможет, то нужно будет убрать из расширенных настроек проекта группу безопасности и подсеть. 