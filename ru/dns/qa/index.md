---
title: Вопросы и ответы про {{ dns-full-name }}
description: На странице представлены вопросы и ответы про {{ dns-name }}.
---

# Общие вопросы про {{ dns-name }}

#### Почему списывается плата за {{ dns-name }}, если в моем облаке нет DNS-зон? {#dns-fee-without-usage}

[Публичные DNS-запросы](../concepts/dns-zone.md#public-zones) с [виртуальных машин](../../glossary/vm.md) к DNS-серверам {{ yandex-cloud }} также [тарифицируются](../pricing.md#public-dns-requests).

Поэтому сервис {{ dns-name }} используется даже в том случае, если в вашем облаке нет никаких DNS-зон, кроме сервисных.

Рекомендуем использовать [кеширующие резолверы](../tutorials/local-dns-cache.md), например: `systemd-resolved`, `dnsmasq`, `unbound`. С их помощью можно снизить количество публичных DNS-запросов и, таким образом, уменьшить расходы.

{% include [logs](../../_qa/logs.md) %}


#### Почему не получается добавить TXT-запись? {#dns-add-txt-record}

Ошибка возникает при попытке добавить еще одну TXT-запись того же типа рядом с существующей. Сервис поддерживает только одну TXT-запись, но она может хранить несколько значений.

Чтобы добавить новое значение:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет изменена запись зоны DNS.
1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
1. Нажмите на нужную зону.
1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив имени нужной записи и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
1. На открывшейся странице нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
1. В появившемся поле введите новое **{{ ui-key.yacloud.dns.label_records }}** записи.
1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни значения или выберите из предложенных.
1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

Подробнее в инструкции [{#T}](../operations/resource-record-update.md).