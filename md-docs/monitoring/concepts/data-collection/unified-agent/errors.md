[Документация Yandex Cloud](../../../../index.md) > [Yandex Monitoring](../../../index.md) > [Агент сбора метрик](index.md) > Возможные ошибки

# Возможные ошибки Yandex Unified Agent

В этом разделе описаны типичные проблемы, которые могут возникнуть при работе Unified Agent, и методы их решения.

При возникновении любой ошибки убедитесь, что у вас установлена актуальная версия Unified Agent. Чтобы установить последнюю версию агента, воспользуйтесь [инструкцией](installation.md#setup).

Ошибки Unified Agent, связанные с получением и передачей данных, делятся на две категории:

* `ERROR agent/[plugin_id]...` — ошибки при получении метрик от приложения, поставляющего данные. `plugin_id` — идентификатор [плагина](inputs.md), с помощью которого агент получает данные.

* `ERROR agent/output-yc_metrics...` — ошибки при отправке метрик в Monitoring.

#### Message size [value] is greater than inflight limit [value], message dropped {#message-size-error}

Размер входящего сообщения превышает установленный предельный размер сообщения (`inflight.limit`), заданный в [настройках](services.md#flow_control) буфера сессии `flow_control`. Часто ошибка возникает в `gRPC input`. 

Попробуйте увеличить заданное значение `flow_control.inflight.limit`.

Если ошибка повторяется, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Timed out while bytes receiving {#time-out-error}

Превышение лимита времени, отведенного на передачу данных.

Проверьте стабильность сетевого соединения и попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### 500 Internal server error {#internal-error}

На сервере возникла внутренняя ошибка, не позволяющая нормально обработать запрос. Попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### SSL library returned error {#ssl-error}

Неверный [TLS-сертификат](../../../../certificate-manager/concepts/index.md) или ошибка при установке защищенного соединения. Попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).