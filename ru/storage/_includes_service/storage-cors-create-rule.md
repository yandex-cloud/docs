Чтобы создать правило:

1. Заполните поля:
   * **{{ ui-key.yacloud.storage.bucket.cors.column_description }}** — описание правила в произвольной форме.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-origin }}** — перечень доменов, разделенных запятыми. Каждый домен записывается в отдельное поле `AllowedOrigin` конфигурации CORS. Пример: `http://*.example.com, http://some.another.dom`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-method }}** — HTTP-методы, разрешенные в запросе к объекту, разделенные запятыми. Каждый метод записывается в отдельное поле `AllowedMethod` конфигурации CORS. Пример: `GET, PUT, HEAD, POST, DELETE`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_allowed-header }}** — разрешенные заголовки в запросе к объекту, разделенные запятыми. Каждый заголовок записывается в отдельное поле `AllowedHeader` конфигурации CORS. Пример: `X-Request-Id, X-Request-With`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_expose-header }}** — заголовки, разрешенные к показу в JavaScript-приложении в браузере, разделенные запятыми. Каждый заголовок записывается в отдельное поле `ExposeHeader` конфигурации CORS. Пример: `X-Amz-Request-Id`.
   * **{{ ui-key.yacloud.storage.bucket.cors.column_max-age-seconds }}** — время в секундах, в течение которого браузер сохраняет в кэше результат запроса к объекту методом `OPTIONS`.
1. Нажмите **{{ ui-key.yacloud.storage.bucket.cors.button_save }}**.

Вы можете добавить одновременно несколько правил. Чтобы добавить новое правило, нажмите **{{ ui-key.yacloud.storage.bucket.cors.label_add-cors-settings }}** и повторите предыдущие шаги.
