---
title: FQDN хостов и эндпоинт кластера в {{ mkf-full-name }}
description: 'Узнайте, как выбрать и получить адрес подключения к кластеру {{ mkf-name }}: эндпоинт кластера или FQDN хостов-брокеров.'
alternate:
  - href: ru/managed-kafka/operations/connect/fqdn.md
    type: text/markdown
    title: Markdown version
---

# FQDN хостов и эндпоинт кластера

Для первоначального подключения к кластеру {{ mkf-name }} можно использовать эндпоинт кластера или FQDN отдельных хостов-брокеров. Эндпоинт — стабильное доменное имя (FQDN) кластера.

## Выбрать адрес подключения {#choose-address}

#|
|| **Адрес** | **Когда использовать** ||
|| [Эндпоинт кластера](#get-cluster-endpoint) | Чтобы сохранить один адрес подключения при изменении состава хостов. Клиент должен перебирать IP-адреса из ответа DNS и обновлять DNS-кеш. ||
|| [FQDN хостов-брокеров](#get-fqdn) | Чтобы явно задать брокеров для первоначального подключения, а также если эндпоинт недоступен или клиент не поддерживает перебор IP-адресов. Укажите несколько брокеров, чтобы клиент мог подключиться при недоступности одного из них. ||
|#

Подробнее о работе адресов читайте в разделах [Имя хоста и FQDN](../../concepts/network.md#hostname) и [Эндпоинт кластера](../../concepts/network.md#cluster-endpoint).

## Получить эндпоинт {#get-cluster-endpoint}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. [Перейдите]({{ link-console-main }}/link/managed-kafka) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите на имя нужного кластера.
  1. На вкладке **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.kafka.cluster.section_cluster-endpoint }}** скопируйте значение поля **{{ ui-key.yacloud.kafka.cluster.field_fqdn }}**.

{% endlist %}

Эндпоинт имеет вид:

```text
c-<идентификатор_кластера>.{{ dns-zone }}
```

Если эндпоинт не отображается в консоли управления, используйте для подключения [FQDN нескольких хостов-брокеров](#get-fqdn).

## Получить FQDN хостов-брокеров {#get-fqdn}

Пример FQDN хоста-брокера:

```text
{{ host-name }}.{{ dns-zone }}
```

FQDN можно получить несколькими способами:

* Посмотрите FQDN в консоли управления:

    1. Перейдите на страницу кластера.
    1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста-брокера. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Запросите список хостов в кластере](../cluster-hosts.md) с помощью CLI или API.

При работе с [{{ mkf-short-name }} REST API](../../concepts/available-apis.md) можно отсылать запросы к любому хосту-брокеру: API доступно со всех хостов-брокеров кластера.

## Настроить клиент {#configure-connection}

Перед подключением выполните [предварительную настройку](index.md).

1. Укажите выбранный адрес и порт в параметре `bootstrap.servers` клиента. Если вы используете FQDN хостов-брокеров, укажите несколько адресов с портами через запятую.

   {% list tabs group=connection %}

   - Подключение с SSL {#with-ssl}

     Для эндпоинта кластера:

     ```properties
     bootstrap.servers=c-<идентификатор_кластера>.{{ dns-zone }}:{{ port-mkf-ssl }}
     security.protocol=SASL_SSL
     ```

     Для хостов-брокеров:

     ```properties
     bootstrap.servers=<FQDN_брокера_1>:{{ port-mkf-ssl }},<FQDN_брокера_2>:{{ port-mkf-ssl }}
     security.protocol=SASL_SSL
     ```

   - Подключение без SSL {#without-ssl}

     Для эндпоинта кластера:

     ```properties
     bootstrap.servers=c-<идентификатор_кластера>.{{ dns-zone }}:{{ port-mkf-text }}
     security.protocol=SASL_PLAINTEXT
     ```

     Для хостов-брокеров:

     ```properties
     bootstrap.servers=<FQDN_брокера_1>:{{ port-mkf-text }},<FQDN_брокера_2>:{{ port-mkf-text }}
     security.protocol=SASL_PLAINTEXT
     ```

   {% endlist %}

   
   Подключение без SSL доступно только для кластеров без публичного доступа.


   Название параметра зависит от библиотеки. Например, в `kafka-python` используется `bootstrap_servers`. Остальные параметры аутентификации и шифрования задайте по [примерам кода](code-examples.md).

1. Если вы используете эндпоинт кластера, убедитесь, что клиент перебирает все IP-адреса из ответа DNS. Рекомендации для библиотек:

   #|
   || **Библиотека** | **Настройка перебора IP-адресов** ||
   || Java `kafka-clients` 2.6.0 и новее | Рекомендуемый вариант: `client.dns.lookup=use_all_dns_ips` включен по умолчанию. Убедитесь, что приложение не переопределяет это значение. [Подробнее](https://kafka.apache.org/26/generated/consumer_config.html#client.dns.lookup). ||
   || Java `kafka-clients` 2.1.0–2.5.x | Явно задайте `client.dns.lookup=use_all_dns_ips` для производителей и потребителей: в этих версиях перебор адресов по умолчанию выключен. [Подробнее](https://kafka.apache.org/21/generated/producer_config.html). ||
   || `librdkafka` и клиенты на ее основе: `Confluent.Kafka`, `confluent-kafka`, `node-rdkafka` | Перебор адресов поддерживается по умолчанию. Если версия библиотеки предоставляет параметр `client.dns.lookup`, сохраните значение `use_all_dns_ips`. [Подробнее](https://docs.confluent.io/platform/current/clients/librdkafka/html/md_CONFIGURATION.html). ||
   |#

   Если версия Java `kafka-clients` ниже 2.1.0, обновите библиотеку. Для других клиентов проверьте поддержку перебора адресов в документации используемой библиотеки. Если клиент не поддерживает перебор, укажите в его настройках FQDN нескольких брокеров вместо эндпоинта.

1. [Настройте обновление DNS-кеша](#dns-cache), чтобы клиент получал актуальные IP-адреса после изменения состава хостов.

## Настроить DNS-кеш {#dns-cache}

Проверьте время хранения результатов DNS-запросов в клиентской библиотеке, среде выполнения и операционной системе. Бессрочное кеширование может помешать подключению после замены или удаления хостов, даже если эндпоинт кластера остается прежним.

Для Java задайте конечное время кеширования в файле `conf/security/java.security` используемой JDK. Например:

```properties
networkaddress.cache.ttl=30
networkaddress.cache.negative.ttl=0
```

В этом примере успешный ответ DNS кешируется на 30 секунд, а неуспешный — не кешируется. Эти параметры относятся к свойствам безопасности Java и не задаются через `-D` или `System.setProperty()`. Подробнее в [документации Java](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/net/doc-files/net-properties.html#address-cache).

Перезапустите приложение, чтобы применить изменения.

В `librdkafka` время кеширования адресов задается параметром `broker.address.ttl` в миллисекундах. Его значение по умолчанию — `1000`. Дополнительно учитывайте настройки DNS-кеша операционной системы. Подробнее в [документации библиотеки](https://docs.confluent.io/platform/current/clients/librdkafka/html/md_CONFIGURATION.html).

## Что дальше {#whats-next}

* [{#T}](clients.md)
* [{#T}](code-examples.md)
