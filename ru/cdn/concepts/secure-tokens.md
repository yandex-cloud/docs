# Защищенные токены

С помощью _защищенных токенов_ (_secure token_) вы можете ограничить доступ к файлам [CDN-ресурса](./resource.md). Это используется, например, для временного или платного доступа к файлам, а также для обеспечения безопасности чувствительных данных.

Доступ к файлам осуществляется по [подписанным ссылкам](#protected-link) с ограниченным сроком действия, query-параметры которых содержат защищенный токен. CDN-сервер по хэшу сверяет полученный токен с секретным ключом CDN-ресурса и переданными в HTTP-запросе данными и разрешает или запрещает доступ к файлу.

Также с помощью защищенных токенов можно задать доверенный IP-адрес, с которого будет разрешен доступ к CDN-ресурсу.

Вы можете [включить](../operations/resources/enable-secure-token.md#enable-secure-token) для CDN-ресурса доступ по защищенному токену с помощью [консоли управления]({{ link-console-main }}), [CLI](../../cli/cli-ref/managed-services/cdn/resource/update.md), [{{ TF }}]({{ tf-provider-resources-link }}/cdn_resource) или [API](../api-ref/Resource/update.md). Для вступления изменений в силу может потребоваться до 15 минут.

Если для CDN-ресурса включен доступ по защищенному токену, контент доступен только по подписанным ссылкам. Чтобы сохранить доступ к части контента по обычным ссылкам, [создайте](../operations/resources/create-resource.md) для этого контента еще один CDN-ресурс с отдельным [источником](./origins.md).

Подробности о защищенном токене см. в документации CDN-провайдера EdgeЦентр:
* [Secure token. Обзор функции](https://support.edgecenter.ru/knowledge_base/item/268821?sid=57227)
* [Документация API](https://apidocs.edgecenter.ru/cdn#tag/Resources/operation/change_cdn_resource)

## Подписанная ссылка {#protected-link}

_Подписанная ссылка_ [генерируется](#link-generation-code) вне CDN-ресурса, например на основном легковесном сайте, и содержит следующие query-параметры:
* `md5` — защищенный токен в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64), который является [MD5](https://ru.wikipedia.org/wiki/MD5)-хэшем строки, состоящей из элементов:
  * Секретный ключ — произвольная строка длиной от 6 до 32 символов.
  * Срок действия ссылки — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого доступ к файлу будет запрещен. Начать скачивание файла можно до истечения срока действия, а завершить можно и после.
  * Путь к файлу в источнике.
  * (опционально) Доверенный IP-адрес, с которого разрешено скачивать файл. Задается, если для CDN-ресурса включено ограничение доступа по IP-адресу. Если ограничение не задано, доступ к файлам будет разрешен с любых IP-адресов. Задать ограничение доступа по IP-адресу можно как при [включении](../operations/resources/enable-secure-token.md#enable-secure-token) доступа по защищенному токену, так и позднее.
* `expires` — срок действия ссылки в Unix-формате.

Пример подписанной ссылки:

> http://cdn.example.com/files/image.jpg?md5=xu7AXOAOQ********Ua0xw&expires=1701609223

## Примеры {#link-generation-code}

Чтобы сформировать подписанную ссылку, воспользуйтесь одним из примеров.

### Подписанная ссылка с ограничением доступа по IP-адресу {#link-code-ip-access}

{% list tabs group=programming_language %}

- PHP {#php}

  ```php
  <?php

  $secret = '<секретный_ключ>';
  $path = '<путь_к_файлу>';
  $ip = '<IP-адрес>';
  $expires = time() + <срок_действия_ссылки>;
  $hostname = '<доменное_имя>';
  $link = "$expires$path$ip $secret";
  $md5 = md5($link, true);
  $md5 = base64_encode($md5);
  $md5 = strtr($md5, '+/', '-_');
  $md5 = str_replace('=', '', $md5);
  $url = "{$hostname}{$path}?md5={$md5}&expires={$expires}";

  ?>
  ```

  Где:
  * `$secret` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
  * `$path` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `$ip` — доверенный IP-адрес, c которого будет разрешен доступ к файлу.
  * `$expires` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной, `<срок_действия_ссылки>` — срок действия ссылки в секундах с момента генерации ссылки.
  * `$hostname` — [доменное имя](./resource.md#hostnames) CDN-ресурса. Например: `cdn.example.com`.
  * `$url` — готовая [подписанная ссылка](#protected-link) на файл.

- Python {#python}

  ```python
  import base64 
  from hashlib import md 
  from time import time 
  ip = '<IP-адрес>' 
  secret = '<секретный_ключ>' 
  path = f'<путь_к_файлу>' 
  expires = int(time()) + <срок_действия_ссылки> 
  hostname = '<доменное_имя>' 
  token = base64.encodebytes(md5(f"{expires}{path}{ip} {secret}".encode()).digest()).decode().replace("\n", "").replace("+", "-").replace("/", "_").replace("=", "") 
  secured_url = f"{hostname}{path}?md5={token}&expires={expires}" 
  ```

  Где:
  * `ip` — доверенный IP-адрес, c которого будет разрешен доступ к файлу.
  * `secret` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
  * `path` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `expires` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной, `<срок_действия_ссылки>` — срок действия ссылки в секундах с момента генерации ссылки.
  * `hostname` — [доменное имя](./resource.md#hostnames) CDN-ресурса. Например: `cdn.example.com`.
  * `secured_url` — готовая [подписанная ссылка](#protected-link) на файл.

- OpenSSL {#openssl}

  ```bash
  echo -n '<срок_действия_ссылки><путь_к_файлу><IP-адрес> <секретный_ключ>' | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d ='<срок_действия_ссылки><путь_к_файлу><IP-адрес> <секретный_ключ>' = '{expires}{path}{ip} {secret_key}'
  ```

  Где:
  * `<срок_действия_ссылки>` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной.
  * `<путь_к_файлу>` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `<IP-адрес>` — доверенный IP-адрес, c которого будет разрешен доступ к файлу.
  * `<секретный_ключ>` — секретный ключ — произвольная строка длиной от 6 до 32 символов.

{% endlist %}

### Подписанная ссылка без ограничения доступа по IP-адресу {#link-code-no-ip}

{% list tabs group=programming_language %}

- PHP {#php}

  ```php
  <?php

  $secret = '<секретный_ключ>';
  $path = '<путь_к_файлу>';
  $expires = time() + <срок_действия_ссылки>;
  $hostname = '<доменное_имя>';
  $link = "$expires$path $secret";
  $md5 = md5($link, true);
  $md5 = base64_encode($md5);
  $md5 = strtr($md5, '+/', '-_');
  $md5 = str_replace('=', '', $md5);
  $url = "{$hostname}{$path}?md5={$md5}&expires={$expires}";

  ?>
  ```

  Где:
  * `$secret` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
  * `$path` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `$expires` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной, `<срок_действия_ссылки>` — срок действия ссылки в секундах с момента генерации ссылки.
  * `$hostname` — [доменное имя](./resource.md#hostnames) CDN-ресурса. Например: `cdn.example.com`.
  * `$url` — готовая [подписанная ссылка](#protected-link) на файл.

- Python {#python}

  ```python
  import base64 
  from hashlib import md5 
  from time import time 
  secret = '<секретный_ключ>'
  path = f'<путь_к_файлу>'  
  expires = int(time()) + <срок_действия_ссылки> 
  hostname = '<доменное_имя>' 
  token = base64.encodebytes(md5(f"{expires}{path} {secret}".encode()).digest()).decode().replace("\n", "").replace("+", "-").replace("/", "_").replace("=", "") 
  secured_url = f"{hostname}{path}?md5={token}&expires={expires}" 
  ```

  Где:
  * `secret` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
  * `path` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `expires` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной, `<срок_действия_ссылки>` — срок действия ссылки в секундах с момента генерации ссылки.
  * `hostname` — [доменное имя](./resource.md#hostnames) CDN-ресурса. Например: `cdn.example.com`.
  * `secured_url` — готовая [подписанная ссылка](#protected-link) на файл.

- OpenSSL {#openssl}

  ```bash
  echo -n '<срок_действия_ссылки><путь_к_файлу> <секретный_ключ>' | openssl md5 -binary | openssl base64 | tr +/ -_ | tr -d = '<срок_действия_ссылки><путь_к_файлу> <секретный_ключ>' = '{expires}{path} {secret_key}'
  ```

  Где:
  * `<срок_действия_ссылки>` — момент времени в [Unix-формате](https://ru.wikipedia.org/wiki/Unix-время), после которого ссылка станет недействительной.
  * `<путь_к_файлу>` — путь к файлу, для доступа к которому генерируется ссылка. Например: `/files/image.jpg`.
  * `<секретный_ключ>` — секретный ключ — произвольная строка длиной от 6 до 32 символов.

{% endlist %}

### См. также {#see-also}

* [{#T}](../operations/resources/enable-secure-token.md)
* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)
