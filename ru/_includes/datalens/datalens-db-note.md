{% note warning %}
              
 У пользователя должно быть установлено одно из следующих значений параметра [readonly]({{ ch.docs }}/operations/settings/permissions-for-queries/#settings_readonly):
         
  * `0` — разрешены все запросы.
  * `1` — разрешены только запросы на чтение данных. В этом случае в [настройках]({{ ch.docs }}/operations/settings/settings) {{ CH }} укажите:

    * `join_use_nulls = 1`
    * `send_progress_in_http_headers = 0`
    * `output_format_json_quote_denormals = 1`

    Для использования разрешения в {{ datalens-short-name }} в дополнительных настройках подключения для параметра `Readonly` выберите значение `1`.

  * `2` — разрешены запросы на чтение данных и изменение настроек.
          
{% endnote %}