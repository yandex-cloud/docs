# Хостинг статических сайтов

Вы можете разместить свой статический сайт в Object Storage. Статический сайт строится на клиентских технологиях, таких как HTML, CSS и JavaScript. Он не может содержать каких-либо скриптов, требующих запуска на стороне веб-сервера. 

Страницы статического сайта — это [объекты](object.md) в [бакете](bucket.md), [ключи](object.md#key) объектов соответствуют пути к странице на сайте, а полный URL страницы имеет вид `http(s)://website.yandexcloud.net/<имя_бакета>/<ключ_объекта>`. {#static-site-information}

{% note info %}

Для работы хостинга необходим [публичный доступ](../operations/buckets/bucket-availability.md) к бакету. Иначе при обращении к сайту Object Storage вернет пользователю ответ с кодом 403.

{% endnote %}

Object Storage позволяет настроить бакет:

* Для хостинга статического сайта.

  {% cut "Загрузите в бакет содержимое вашего сайта и укажите главную страницу сайта" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <IndexDocument>
        <Suffix>index.html</Suffix>
    </IndexDocument>
    <ErrorDocument>
        <Key>error.html</Key>
    </ErrorDocument>
  </WebsiteConfiguration>
  ```

  {% endcut %}

* Для переадресации всех запросов.

  Переадресация всех запросов нужна для автоматического перенаправления всех обращений к бакету на другой URL или бакет, например при смене домена. При этом данные остаются доступными без изменения клиентских запросов.

  {% cut "Вы можете указать хост, на который будут перенаправляться все запросы, а также задать протокол для передачи запросов" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <RedirectAllRequestsTo>
        <HostName>example.com</HostName>
        <Protocol>http</Protocol>
    </RedirectAllRequestsTo>
  </WebsiteConfiguration>
  ```

  {% endcut %}

* Для условной переадресации запросов.

  С помощью правил переадресации можно перенаправить на другую веб-страницу запросы к удаленным объектам или запросы, возвращающие ошибку. Переадресация происходит в соответствии с условием, состоящим из префикса ключа объекта и HTTP-кода ответа.
  
  Если запрос соответствует условиям нескольких правил переадресации, сработает последнее подходящее правило. При этом глубина совпадения ключа объекта с указанным в условии префиксом не имеет значения.

  В сервисе действуют [лимиты](limits.md#storage-limits) на максимальное количество правил для условной переадресации запросов.

  {% cut "Пример правила, которое перенаправляет запрос к удаленной папке на другую страницу" %}

  ```xml
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
    <RoutingRules>
      <RoutingRule>
        <Condition>
          <KeyPrefixEquals>temp/</KeyPrefixEquals>
        </Condition>
        <Redirect>
          <ReplaceKeyWith>folderdeleted.html</ReplaceKeyWith>
        </Redirect>
      </RoutingRule>
    </RoutingRules>
  </WebsiteConfiguration>
  ```

  {% endcut %}

Настроить [хостинг статического сайта](../operations/hosting/setup.md#hosting), [переадресацию всех запросов](../operations/hosting/setup.md#redirects) или [условную переадресацию запросов](../operations/hosting/setup.md#redirects-on-conditions) можно с помощью консоли управления Yandex Cloud.

Все варианты настройки хостинга доступны через [HTTP API](../s3/api-ref/hosting.md), совместимый с Amazon S3.

После настройки бакета для хостинга сайт становится доступен по адресу:


```
http(s)://<имя_бакета>.website.yandexcloud.net
```

или

```
http(s)://website.yandexcloud.net/<имя_бакета>
```

{% note info %}

При использовании URL в формате `http(s)://<имя_бакета>.storage.yandexcloud.net` протокол HTTPS доступен для бакета только в том случае, если имя бакета не содержит точек. Например:

* `https://example.storage.yandexcloud.net` — для этого бакета протокол HTTPS доступен.
* `http://example.ru.storage.yandexcloud.net` — для этого бакета HTTPS недоступен.

Это связано с тем, что в Object Storage используются [сертификаты Wildcard](https://en.wikipedia.org/wiki/Wildcard_certificate), которые поддерживают только один уровень поддоменов.

Чтобы поддержать для бакета с точкой в имени протокол HTTPS, [загрузите собственный сертификат безопасности](../operations/hosting/certificate.md) в Object Storage.

{% endnote %}

Переадресация запросов с HTTP на HTTPS включается автоматически после настройки доступа к бакету по HTTPS. Дополнительных настроек для такой переадресации не требуется.


{% note alert %}

Поддержка протокола TLS версий 1.0 и 1.1 в Object Storage прекращена с 1 августа 2025 года.

Подробнее см. на странице [Протокол TLS](tls.md).

{% endnote %}



При обращении к сайту вы будете получать ответы с кодами, описанными в разделе [Коды ответов статического сайта](../s3/api-ref/hosting/answer-codes.md).

При хостинге сайта вы можете:

* [Поддержать несколько доменных имен](../operations/hosting/multiple-domains/index.md).
* [Использовать собственный домен](../operations/hosting/own-domain.md).

  Чтобы использовать протокол HTTPS с собственным доменом, укажите [FQDN](../../glossary/fqdn.md) нужного домена в имени бакета.

Управлять доменами Yandex Cloud DNS можно как в настройках бакета, так и в сервисе [Cloud DNS](../../dns/operations/index.md).

Из бакета с публичным доступом файлы можно получить по публичной ссылке как по протоколу HTTP, так и по протоколу HTTPS, даже если для бакета не [настроен](../operations/hosting/setup.md) хостинг сайта. В этом случае для доступа по протоколу HTTPS будет использован сертификат от [GlobalSign](https://www.globalsign.com/ru-ru) на уровне облака.

### См. также {#see-also}

* [Настройка хостинга](../operations/hosting/setup.md)
* [Собственный домен](../operations/hosting/own-domain.md)
* [Поддержка нескольких доменных имен](../operations/hosting/multiple-domains/index.md)
* [Настройка HTTPS](../operations/hosting/certificate.md)
* [Как исправить некорректный MIME-тип объектов при их загрузке в бакет?](../qa.md#qa-mime-type)


### Примеры использования {#examples}

* [Получение статистики посещения сайта с использованием S3 Select](../tutorials/user-agent-statistics.md)
* [Статический сайт в Yandex Object Storage](../tutorials/static/index.md)
* [Хостинг статического сайта на фреймворке Gatsby в Yandex Object Storage](../tutorials/gatsby-static-website.md)
* [Разработка навыка Алисы и сайта с авторизацией](../tutorials/alice-shareable-todolist.md)