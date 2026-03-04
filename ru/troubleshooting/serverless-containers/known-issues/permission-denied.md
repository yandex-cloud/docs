

# Устранение ошибки 403 (Permission denied)

## Описание задачи {#case-description}

При попытке создать триггер, версию функции, ревизию контейнера или шлюз {{ api-gw-name }} возникает ошибка `Permission denied` с кодом статуса `403`.

Примеры сообщений об ошибках:

```text
url: https://console.yandex.cloud/folders/b1g*****************/functions/create-trigger; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```text
url: https://console.yandex.cloud/folders/b1g*****************//serverless-containers/containers/bba*****************/editor; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```text
url: https://console.yandex.cloud/folders/b1gXXXXXXXXXXXXXXXXX/api-gateway/create; 
message: Permission denied; status: 403; 
description: Permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

## Диагностика {#diagnosis}

### Общие проверки

1. **Проверьте роли пользователя**. Убедитесь, что у вашего аккаунта есть роль на каталог или облако, позволяющая создавать ресурсы (обычно `editor` или выше).
1. **Проверьте статус облака**. Облако должно находиться в статусе `ACTIVE`.
    *  Если облако в статусе ожидания удаления (`PENDING_DELETION`), работа с ресурсами невозможна. Попробуйте [отменить удаление облака](../../../resource-manager/operations/cloud/delete#cancel-delete).
    *  Если облако заблокировано (например из-за задолженности), необходимо устранить причину блокировки.

В большинстве случаев ошибка возникает, когда у сервисного аккаунта, от имени которого работает ресурс, нет прав на взаимодействие с другими сервисами.
Если в тексте встречается ошибка `Error PERMISSION_DENIED in client lockbox`, значит, у сервисного аккаунта нет ролей для доступа к секретам в {{ lockbox-full-name }}.

Если ошибка возникает при работе с триггерами — убедитесь, что у сервисного аккаунта, привязанного к функции, контейнеру или триггеру, есть необходимые роли:
*  **{{ objstorage-short-name }}**: нет доступа к бакету на чтение и/или запись. По умолчанию для смонтированных бакетов может быть выбран режим «Только чтение». Проверьте [роли для хранилища](../../../storage/security/).
*  **Вызов функции или контейнера**: Нет роли `functions.functionInvoker` (для функций) или `serverless-containers.containerInvoker` (для контейнеров).
*  **Дополнительные роли для типов триггеров**:
    *  **{{ message-queue-short-name }}**: нужна роль `editor` на каталог с очередью сообщений.
    *  **{{ container-registry-short-name }}**: нужна роль `container-registry.images.puller` для загрузки образов.
    *  **{{ yds-full-name }}**: нужна роль `yds.admin` на поток данных.
    *  **{{ cloud-logging-name }}**: нужна роль `logging.reader` на лог-группу.
    *  **Триггер почты**: (опционально) роль `storage.uploader` для сохранения вложений.
*   **Dead Letter Queue (DLQ)**: если используется DLQ, нужна роль `ymq.writer` на очередь для записи сообщений, которые не удалось обработать.

{% note alert %}

Частая ошибка: роли назначены сервисному аккаунту на самого себя (`sa assign-role ... --subject service-account:<id_самого_са>`). 
Для работы с ресурсами внутри каталога необходимо назначать hjkb сервисному аккаунту на каталог или конкретный ресурс, а не на самого себя.

{% endnote %}
