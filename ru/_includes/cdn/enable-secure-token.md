* Укажите **{{ ui-key.yacloud.cdn.field_secure-key }}** — произвольную строку длиной от 6 до 32 символов. Секретный ключ потребуется для генерации [подписанных ссылок](../../cdn/concepts/secure-tokens.md#protected-link).

    Сохраненный секретный ключ вы всегда сможете посмотреть в консоли управления или с помощью команды [CLI](../../cli/) `yc cdn resource list`.
* В поле **{{ ui-key.yacloud.cdn.field_secure-key-type }}** задайте ограничение на доступ к контенту по IP-адресу:

   * `{{ ui-key.yacloud.cdn.value_secure-key-type-enable }}` — доступ к файлам будет разрешен только с определенного IP-адреса получателя контента. IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://ru.wikipedia.org/wiki/MD5)-хэша для подписанной ссылки.
   * `{{ ui-key.yacloud.cdn.value_secure-key-type-disable }}` — доступ к файлам будет разрешен с любых IP-адресов.