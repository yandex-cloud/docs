---
title: "Хостинг статических сайтов (html, css, javascript)"
description: "Хостинг статических сайтов – позволяет разместить статический сайт, построенный на HTML, CSS и JavaScript. Сайт не может содержать каких-либо скриптов, требующих запуска на стороне веб-сервера."
---

# Хостинг статических сайтов

Вы можете разместить свой статический сайт в {{ objstorage-name }}. Статический сайт строится на клиентских технологиях, таких как  HTML, CSS и JavaScript. Он не может содержать каких-либо скриптов, требующих запуска на стороне веб-сервера.

{% note info %}

Для работы хостинга необходим [публичный доступ](../operations/buckets/bucket-availability.md) к бакету. Иначе при обращении к сайту {{ objstorage-name }} вернет пользователю ответ с кодом 403.

{% endnote %}

{{ objstorage-name }} позволяет настроить бакет:

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

  Используя правила маршрутизации можно перенаправлять запросы в соответствии с префиксами имен объектов или HTTP-кодами ответов. Вы можете перенаправить на другую веб-страницу запрос к удаленному объекту или перенаправить запросы, возвращающие ошибку.

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

Настроить [хостинг статического сайта](../operations/hosting/setup.md#hosting), [переадресацию всех запросов](../operations/hosting/setup.md#redirects) или [условную переадресацию запросов](../operations/hosting/setup.md#redirects-on-conditions) можно с помощью консоли управления {{ yandex-cloud }}.

Все варианты настройки хостинга доступны через [HTTP API](../s3/api-ref/hosting.md), совместимый с Amazon S3.

После настройки бакета для хостинга сайт становится доступен по адресу:


```
http(s)://<имя_бакета>.{{ s3-web-host }}
```

или

```
http(s)://{{ s3-web-host }}/<имя_бакета>
```

{% include [bucket-https](../../_includes/storage/bucket-https.md) %}

{% include [redirect-https](../../_includes/storage/redirect-https.md) %}


При обращении к сайту вы будете получать ответы с кодами, описанными в разделе [{#T}](../s3/api-ref/hosting/answer-codes.md).

При хостинге сайта вы можете:

* [Поддержать несколько доменных имен](../operations/hosting/multiple-domains.md).
* [Использовать собственный домен](../operations/hosting/own-domain.md).

  Чтобы использовать протокол HTTPS с собственным доменом, укажите [FQDN](../../glossary/fqdn.md) нужного домена в имени бакета.

Управлять доменами {{ dns-full-name }} можно как в настройках бакета, так и в сервисе [{{ dns-name }}](../../dns/operations/index.md).

{% include [public-link](../../_includes/storage/public-link.md) %}

