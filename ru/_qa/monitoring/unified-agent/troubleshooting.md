# Возможные ошибки {{ unified-agent-full-name }}

В этом разделе описаны типичные проблемы, которые могут возникнуть при работе {{ unified-agent-short-name }}, и методы их решения.

При возникновении любой ошибки убедитесь, что у вас установлена актуальная версия {{ unified-agent-short-name }}. Чтобы установить последнюю версию агента, воспользуйтесь [инструкцией](../../../monitoring/concepts/data-collection/unified-agent/installation.md#setup).

Ошибки {{ unified-agent-short-name }}, связанные с получением и передачей данных, делятся на две категории:

* `ERROR agent/[plugin_id]...` — ошибки при получении метрик от приложения, поставляющего данные. `plugin_id` — идентификатор [плагина](../../../monitoring/concepts/data-collection/unified-agent/inputs.md), с помощью которого агент получает данные.

* `ERROR agent/output-yc_metrics...` — ошибки при отправке метрик в {{ monitoring-name }}.

#### Message size [value] is greater than inflight limit [value], message dropped {#message-size-error}

Размер входящего сообщения превышает установленный предельный размер сообщения (`inflight.limit`), заданный в [настройках](../../../monitoring/concepts/data-collection/unified-agent/services.md#flow_control) буфера сессии `flow_control`. Часто ошибка возникает в `gRPC input`. 

Попробуйте увеличить заданное значение `flow_control.inflight.limit`.

Если ошибка повторяется, обратитесь в [техническую поддержку]({{ link-console-support }}).

#### Timed out while bytes receiving {#time-out-error}

Превышение лимита времени, отведенного на передачу данных.

Проверьте стабильность сетевого соединения и попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку]({{ link-console-support }}).

#### 500 Internal server error {#internal-error}

На сервере возникла внутренняя ошибка, не позволяющая нормально обработать запрос. Попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку]({{ link-console-support }}).

#### SSL library returned error {#ssl-error}

Неверный [TLS-сертификат](../../../certificate-manager/concepts/index.md) или ошибка при установке защищенного соединения. Попробуйте еще раз.

Если ошибка повторяется, обратитесь в [техническую поддержку]({{ link-console-support }}).