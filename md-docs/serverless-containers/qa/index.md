[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > Вопросы и ответы

# Общие вопросы про Serverless Containers

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Почему при попытке отправить запрос к API сервиса возвращается ошибка `Illegal duration format`? {#illegal-duration}

При отправке API-запроса, тело которого содержит параметры в формате `type.googleapis.com/google.protobuf.Duration`, сервис может вернуть ошибку:

```text
Illegal duration format; duration must end with 's' for type type.googleapis.com/google.protobuf.Duration
```

Передавать значения в этом формате необходимо с добавлением суффикса `s`.

Например:

```json
{
  "timeout": "120s"
}
```

#### Почему возникает ошибка `Code 502 Message Error during function invocation` после миграции приложения в Serverless Containers? {#error-502-message-error}

Ошибка с кодом 502 может возникать, когда код в контейнере отправляет HTTP-запрос, который завершается с ошибкой.

[Посмотрите](../operations/logs.md) журнал выполнения контейнера. Он может содержать полный текст ошибки вместе с упоминанием проблемного HTTP-запроса. Если в журнале нет полезных данных, [настройте](../operations/logs-write.md#structured-logs) запись структурированных логов для приложения внутри контейнера.

{% note info %}

При вызове контейнера через HTTPS некоторые HTTP-заголовки запроса и ответа изменяются, как описано в разделе [Фильтрация заголовков сообщений](../concepts/invoke.md#filter). При миграции приложения в Serverless Containers учитывайте эти изменения.



{% endnote %}

#### Почему возникает ошибка `user container exec format error` при попытке вызова контейнера Serverless Containers? {#error-user-container-exec-format-error}

Проблема возникает из-за использования неподходящей [среды выполнения](../concepts/runtime.md). 

Пересоберите контейнер с архитектурой `--platform=linux/amd64`.

#### Как исправить ошибку нехватки места? {#error-no-space-left}

{% cut "Как может отображаться ошибка" %}

```
zip I/O error: No space left on device
zip error: Output file write failure (write error on zip file)
```

```
===> executing build script
===> will start 'pip3.** install' in /function/code
...
ERROR: Could not install packages due to an OSError: [Errno 28] No space left on device
```

{% endcut %}

Максимальный объем хранилища ограничен [лимитами Serverless Containers](../concepts/limits.md#serverless-containers-limits). Лимиты — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если для приложения необходимо больше места, создайте виртуальную машину [Compute Cloud](https://yandex.cloud/ru/ru/services/compute) и разверните приложение на ней.

#### Как привязать статический IP-адрес к контейнеру? {#how-to-link-static-ip}

Привязать статический IP-адрес к контейнеру не получится, потому что контейнер может выполняться на ресурсах с разными адресами.

Если для решения задачи критично использование статического IP-адреса, [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину [Compute Cloud](https://yandex.cloud/ru/ru/services/compute), [сделайте ее публичный IP-адрес статическим](../../vpc/operations/set-static-ip.md) и установите среду выполнения для используемого вами языка программирования. Далее запускайте выполнение кода на виртуальной машине.

{% note info %}

Вы также можете использовать API-шлюз для вызова контейнера через собственный домен. Подробнее:

* [Подключение домена к API-шлюзу](../../api-gateway/operations/api-gw-domains.md)
* [Вызов контейнера с помощью API-шлюза](../../api-gateway/concepts/extensions/containers.md)

{% endnote %}

#### Почему возникает ошибка `Permission denied` с кодом статуса `403` при попытке создать ревизию контейнера? {#error-permission-denied}

{% cut "Как может отображаться ошибка" %}

```
url: https://console.yandex.cloud/folders/b1g*****************/functions/create-trigger; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```
url: https://console.yandex.cloud/folders/b1g*****************//serverless-containers/containers/bba*****************/editor; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```
url: https://console.yandex.cloud/folders/b1g*****************/api-gateway/create; 
message: Permission denied; status: 403; 
description: Permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

{% endcut %}

1. Проверьте роли пользователя. Убедитесь, что у сервисного аккаунта есть роль на каталог или облако, позволяющая создавать ресурсы (обычно `editor` или выше).
1. Проверьте статус облака. Облако должно находиться в статусе `ACTIVE`.
    * Если облако в статусе ожидания удаления (`PENDING_DELETION`), работа с ресурсами невозможна. Попробуйте [отменить удаление облака](../../resource-manager/operations/cloud/delete.md#cancel-delete).
    * Если облако заблокировано (например, из-за задолженности), необходимо устранить причину блокировки.

В большинстве случаев ошибка возникает, когда у сервисного аккаунта, от имени которого работает ресурс, нет прав на взаимодействие с другими сервисами. Например, если в тексте встречается ошибка `Error PERMISSION_DENIED in client lockbox`, значит, у сервисного аккаунта нет ролей для доступа к секретам Yandex Lockbox.

Если ошибка возникает при работе со смонтированным бакетом, убедитесь, что сервисному аккаунту назначена роль `storage.viewer` для чтения данных из бакета или роль `storage.uploader` для чтения данных из бакета и записи в него.

Если ошибка возникает при работе с триггерами, убедитесь, что у сервисного аккаунта, привязанного к функции, контейнеру или триггеру, есть необходимые роли:

* Вызов функции или контейнера: роль `functions.functionInvoker` для вызова функции или роль `serverless-containers.containerInvoker` для вызова контейнера.
* Дополнительные роли для триггеров:
    * Триггер для Message Queue: роль `ymq.reader` на каталог с очередью сообщений.
    * Триггер для Container Registry: роль `container-registry.images.puller` для загрузки Docker-образов.
    * Триггер для Cloud Logging: роль `logging.reader` на лог-группу.
    * Триггер для Data Streams: роль `yds.editor` на поток данных.
    * Триггер для почты: роль `storage.uploader` на бакет, если в нем сохраняются вложения из писем.
    * (Опционально) Dead Letter Queue: роль `ymq.writer` на очередь DLQ для записи сообщений, которые не удалось обработать.

{% note info %}

Частая причина ошибки — роль назначена сервисному аккаунту на сам сервисный аккаунт. Такая роль не дает доступа к другим ресурсам каталога. Для работы с ними назначьте роль сервисному аккаунту на каталог или конкретный ресурс.

{% endnote %}