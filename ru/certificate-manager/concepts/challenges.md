# Проверка прав на домен

Для получения и обновления сертификата от Let's Encrypt пройдите процедуру проверки прав на каждый домен, указанный в сертификате. В {{ certificate-manager-name }} доступно два типа проверок: `HTTP` и `DNS`. При создании сертификата вы можете выбрать любой тип проверки. Проверка прав на домены может занять продолжительное время.

{% note info %}

Проверка прав на домены требуется только для сертификатов от Let's Encrypt. {{ certificate-manager-name }} не проверяет права на домены из импортированных пользовательских сертификатов.

{% endnote %}

{{ certificate-manager-name }} ожидает успешного завершения процедуры проверки по каждому домену из сертификата (статус всех проверок — `Valid`). После этого будет выпущен сертификат в Let's Encrypt. Статус сертификата изменится на `Issued`, и вы сможете использовать его в сервисах, интегрированных с {{ certificate-manager-name }}.

Если процедура проверки не будет выполнена в течение одной недели, сертификат перейдет в статус `Invalid` при получении сертификата или `Renewal_failed` при обновлении сертификата. Чтобы после этого получить сертификат, создайте новый запрос на выпуск сертификата от Let's Encrypt.

## Статусы процедуры проверки сертификата {#status}

Процедура проверки может находиться в следующих статусах:
* `Pending` — процедура проверки ожидает завершения. Факт завершения процедуры проверки определяет {{ certificate-manager-name }}.
* `Validating` — процедура проверки ожидает подтверждения от Let's Encrypt.
* `Valid` — процедура проверки успешно пройдена.
* `Invalid` — процедура проверки прав на конкретный домен завершилась с ошибкой или истек срок в одну неделю, отведенный на прохождение процедуры.
* `Renewal_failed` — процедура проверки прав при обновлении сертификата завершилась с ошибкой или истек срок в одну неделю, отведенный на прохождение процедуры.
* `Issued` — сертификат выпущен.

## HTTP {#http}

{% note info %}

Тип проверки `HTTP` не может использоваться для [Wildcard-сертификатов](../../glossary/ssl-certificate.md#types).

{% endnote %}

Для прохождения процедуры проверки прав на домен `example.com`:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** и нажмите на имя нужного сертификата.
1. Подготовьте файл, который позволит удостоверяющему центру Let's Encrypt убедиться, что вы являетесь владельцем указанного в сертификате домена:

    1. С помощью панели управления вашим хостингом создайте на сервере файл, имя и путь к которому соответствуют значению поля **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-url }}** в блоке **HTTP-запись**. Например:

        * `/.well-known/acme-challenge/` — путь размещения файла.
        * `di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1B********` — имя файла.

    1. Поместите в созданный файл значение поля **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_http-content }}** из блока **HTTP-запись**. Например:

        > di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1BLW0QUDbE._TYLpfPMbwHQZ1aEmsdpidY5bPUnVyDvqSO********

    В результате на вашем веб-сервере должен появиться файл `http://example.com/.well-known/acme-challenge/di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1B********`, содержащий текст `di2o3VRsbS6H_eUntKnW3Xcefw_1DOSpZ1BLW0QUDbE._TYLpfPMbwHQZ1aEmsdpidY5bPUnVyDvqSO********`.

1. Дождитесь, когда удостоверяющий центр Let's Encrypt выпустит сертификат, после чего статус сертификата изменится на `Issued`.
1. Удалите с вашего веб-сервера созданный для проверки сертификата файл.

## DNS {#dns}

Если у вас нет доступа к веб-серверу или необходимо получить [Wildcard-сертификат](../../glossary/ssl-certificate.md#types) с масками на поддомены вида `*.example.com`, используйте тип проверки `DNS`.

Для прохождения проверки вам необходимо добавить специальную DNS-запись одного из двух типов: `TXT` или `CNAME`.

{% note alert %}

Добавляйте только одну запись. Если добавить обе записи, возникнут конфликты в работе кеширующих серверов.

{% endnote %}

При использовании TXT-записи вам придется проходить проверку каждые 60 дней в рамках автоматического обновления сертификата.

При использовании CNAME-записи возможно пройти проверку только один раз. Для этого необходимо делегировать {{ certificate-manager-name }} право ответа в DNS-зоне домена, используемой при проверке. В этом случае проверки будут проходить автоматически.

### Добавление CNAME-записи {#cname}

Для автоматического прохождения проверки прав на домен `example.com`:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
1. В списке сертификатов выберите сертификат, который участвует в проверке.
1. Порядок действий на этом шаге будет зависеть от того, управляет вашим доменом сервис {{ dns-full-name }} или сторонний DNS-провайдер.

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, в блоке с типом записи `CNAME`, в поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_dns-record-set }}**, нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**. В открывшемся окне:

      1. Если в текущем каталоге есть подходящая зона DNS, она будет автоматически подставлена в поле **{{ ui-key.yacloud.dns.label_zone }}**. Если подходящей зоны DNS нет, нажмите **{{ ui-key.yacloud.dns.button_zone-create }}** и задайте ее параметры, чтобы [создать](../../dns/operations/zone-create-public.md) зону.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    - Сторонний DNS-провайдер {#third-party-dns-server}

      1. В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, в блоке с типом записи `CNAME`, в поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_value }}**, посмотрите значение записи для домена.
      1. Разместите у своего DNS-провайдера или на собственном [DNS-сервере](../../glossary/dns.md#dns-server) `CNAME`-запись для делегирования прав управления на DNS-зону, используемую для проверки:

          ```
          _acme-challenge.example.com CNAME <значение>
          ```
          Строка `<значение>` формируется по шаблону `<идентификатор_сертификата>.cm.yandexcloud.net.`

          {% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

    {% endlist %}

   {% include [checking-domain-rights](../../_includes/certificate-manager/checking-domain-rights.md) %}


### Добавление TXT-записи {#txt}

Для прохождения проверки прав на домен `example.com`:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
1. В списке сертификатов выберите сертификат, который участвует в проверке.
1. Порядок действий на этом шаге будет зависеть от того, управляет вашим доменом сервис {{ dns-full-name }} или сторонний DNS-провайдер.

    {% list tabs group=instructions %}

    - {{ dns-full-name }} {#dns}

      В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, в блоке с типом записи `TXT`, в поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_dns-record-set }}**, нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**. В открывшемся окне:

      1. Если в текущем каталоге есть подходящая зона DNS, она будет автоматически подставлена в поле **{{ ui-key.yacloud.dns.label_zone }}**. Если подходящей зоны DNS нет, нажмите **{{ ui-key.yacloud.dns.button_zone-create }}** и задайте ее параметры, чтобы [создать](../../dns/operations/zone-create-public.md) зону.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    - Сторонний DNS-провайдер {#third-party-dns-server}

      1. В разделе **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, в блоке с типом записи `TXT`, в поле **{{ ui-key.yacloud.certificate-manager.overview.challenge_label_value }}**, посмотрите значение записи для домена.
      1. Разместите у своего DNS-провайдера или на собственном DNS-сервере `TXT`-запись:

          ```
          _acme-challenge.example.com. IN TXT <значение>
          ```

    {% endlist %}

    {% include [checking-domain-rights](../../_includes/certificate-manager/checking-domain-rights.md) %}

1. После изменения статуса сертификата на `Issued` удалите с DNS-сервера добавленную `TXT`-запись.

## Автоматическая проверка прав {#auto}

В некоторых случаях процедура проверки прав на домен не требует участия пользователя.

### CNAME-запись на зону {#auto-cname}

Проверка проходит автоматически при соблюдении следующих условий:
* Сертификат находится в статусе `Renewing` — проходит процедуру [обновления](managed-certificate.md#renew).
* Для каждого домена сертификата настроена DNS-запись:

    ```
    _acme-challenge.example.com CNAME <идентификатор_сертификата>.cm.yandexcloud.net.
    ```

### Перенаправление статического сайта {{ objstorage-name }} {#auto-s3}

Проверка проходит автоматически при соблюдении следующих условий:
* Сертификат находится в статусе `Renewing` — проходит процедуру [обновления](managed-certificate.md#renew).
* Сертификат используется в [HTTPS-конфигурации](../../storage/operations/hosting/certificate#cert-manager) статического веб-сайта [{{ objstorage-name }}](../../tutorials/web/static/index.md).
* Для каждого домена сертификата настроен:
    * [алиас](../../storage/operations/hosting/own-domain.md) на бакет статического сайта, в котором используется этот сертификат;
    * или [переадресация](../../storage/operations/hosting/multiple-domains.md) на домен с алиасом на бакет.
* Сертификат не является [Wildcard-сертификатом](../../glossary/ssl-certificate.md#types) — не содержит масок на поддомены.

### Перенаправление на сервер валидации в веб-сервере {#auto-vs}

Проверка проходит автоматически при соблюдении следующих условий:
* Сертификат находится в статусе `Renewing` — проходит процедуру [обновления](managed-certificate.md#renew).
* Сертификат не является [Wildcard-сертификатом](../../glossary/ssl-certificate.md#types) — не содержит масок на поддомены.
* Для каждого домена сертификата в веб-сервере настроено перенаправление с
    ```
    http://<домен>/.well-known/acme-challenge/*
    ```
    на
    ```
    https://{{ api-host-certmanager-validation }}/<идентификатор_сертификата>/*
    ```
    Данный эндпоинт доступен только по IPv6.

Пример настройки перенаправления в nginx-конфигурации:
```
server {
  location ~ ^/.well-known/acme-challenge/([a-zA-Z0-9-_]+)$ {
    return 301 https://{{ api-host-certmanager-validation }}/<идентификатор_сертификата>/$1;
  }
}
```

#### См. также {#see-also}

* [Документация Let's Encrypt. Виды проверок](https://letsencrypt.org/ru/docs/challenge-types/)
