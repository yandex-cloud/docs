В поле **{{ ui-key.yacloud.alb.label_route-action }}** выберите одну из опций: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}` или `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. В зависимости от выбранной опции:

{% list tabs %}

- {{ ui-key.yacloud.alb.label_route-action-route }}

  * {% include [console-create-http-route-choose-bg](./console-create-http-route-choose-bg.md) %}
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** укажите путь, по которому HTTP-роутер должен перенаправлять трафик. Если ранее в поле **{{ ui-key.yacloud.alb.label_path }}** вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен. Если была выбрана опция `{{ ui-key.yacloud.alb.label_match-prefix }}`, будет изменено только начало.
  * {% include [console-create-http-route-host-rwrite](./console-create-http-route-host-rwrite.md) %}
  * {% include [console-create-http-route-native-rate-limiter](./console-create-http-route-native-rate-limiter.md) %}
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_timeout }}** укажите максимальное время, на которое может быть установлено соединение.
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_idle-timeout }}** укажите максимальное время keep-alive, в течение которого соединение может простаивать без передачи данных.
  * (Опционально) В поле **{{ ui-key.yacloud.alb.label_upgrade-types }}**:

      * (Опционально) Укажите список протоколов, на которые группа бэкендов может перейти в рамках TCP-соединения по запросу клиента. Используйте кнопку **{{ ui-key.yacloud_billing.alb.button_add-upgrade-type }}**, чтобы добавлять дополнительные протоколы.
      * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_web-socket }}**, если вы хотите использовать протокол [WebSocket](https://ru.wikipedia.org/wiki/WebSocket).

- {{ ui-key.yacloud.alb.label_route-action-redirect }}

  * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код, по которому будет осуществляться перенаправление:

      * `301 Moved Permanently`;
      * `302 Found`;
      * `303 See Other`;
      * `307 Temporary Redirect`;
      * `308 Permanent Redirect`.
  * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace }}** и укажите тип модификации пути, по которому HTTP-роутер должен перенаправлять трафик:

      * `{{ ui-key.yacloud.alb.label_replace-exact }}` — чтобы полностью заменить путь запроса на значение, заданное в поле справа.
      * `{{ ui-key.yacloud.alb.label_replace-prefix }}` — чтобы изменить префикс пути запроса на значение, заданное в поле справа.

      {% note info %}

      Если в поле **{{ ui-key.yacloud.alb.label_path }}** выше вы выбрали опцию `{{ ui-key.yacloud.alb.label_match-exact }}`, путь будет полностью заменен, даже если в поле **{{ ui-key.yacloud.alb.label_replace }}** выбрана опция `{{ ui-key.yacloud.alb.label_replace-prefix }}`.

      {% endnote %}

  * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_strict-query }}**, чтобы удалять из запросов все query-параметры.
  * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-scheme }}**, чтобы изменять схему в запросах на схему, заданную в поле справа.

      Если в исходном URI использована схема `http` (`https`) и указан порт `80` (`443`), при изменении схемы порт будет удален.
  * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-host }}** и в поле справа укажите новый хост.
  * (Опционально) Включите опцию **{{ ui-key.yacloud.alb.label_replace-port }}** и в поле справа укажите новый порт.

- {{ ui-key.yacloud.alb.label_route-action-statusResponse }}

  * В поле **{{ ui-key.yacloud.alb.label_http-status-code }}** выберите код статического ответа, который будет отправляться на запрос.
  * В поле **{{ ui-key.yacloud.alb.label_body }}** задайте тело статического ответа на запросы. Для этого нажмите кнопку **{{ ui-key.yacloud.alb.button_select }}** и в открывшемся окне:

      * В поле **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** выберите:

          * `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` — чтобы выбрать текстовый файл, содержащий тело ответа.
          * `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` — чтобы указать текст ответа в текстовом поле.
          * Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

{% endlist %}