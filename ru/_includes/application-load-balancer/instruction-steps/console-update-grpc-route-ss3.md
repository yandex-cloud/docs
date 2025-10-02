В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:

{% list tabs %}

- {{ ui-key.yacloud.alb.label_route-action-route }}

  * {% include [console-create-http-route-choose-bg](./console-create-http-route-choose-bg.md) %}
  * {% include [console-create-http-route-host-rwrite](./console-create-http-route-host-rwrite.md) %}
  * {% include [console-create-http-route-native-rate-limiter](./console-create-http-route-native-rate-limiter.md) %}
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_max-timeout }}** укажите максимальное время, на которое может быть установлено соединение. Клиент может указать в запросе HTTP-заголовок `grpc-timeout` с меньшим значением таймаута.
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время, в течение которого соединение может простаивать без передачи данных.

- {{ ui-key.yacloud.alb.label_route-action-statusResponse }}

  В поле **{{ ui-key.yacloud.alb.label_grpc-status-code }}** выберите код статического ответа, отправляемого балансировщиком в ответ на запрос:

  * `OK`;
  * `INVALID_ARGUMENT`;
  * `NOT_FOUND`;
  * `PERMISSION_DENIED`;
  * `UNAUTHENTICATED`;
  * `UNIMPLEMENTED`;
  * `INTERNAL`;
  * `UNAVAILABLE`.

{% endlist %}