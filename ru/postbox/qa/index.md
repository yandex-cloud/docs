---
title: Вопросы и ответы про {{ postbox-full-name }}
description: На странице представлены вопросы и ответы про {{ postbox-name }}.
---

# Общие вопросы про {{ postbox-name }}

#### Поддерживаются ли кириллические домены? {#cyrillic-domains}

Да, {{ postbox-name }} поддерживает кириллические домены ([IDN](https://{{ lang }}.wikipedia.org/wiki/Internationalized_domain_name)). Чтобы использовать кириллический домен, при [создании адреса](../operations/create-address.md) укажите его в кодировке [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Например, домен `пример.рф` в формате Punycode будет выглядеть как `xn--e1afmkfd.xn--p1ai`.

#### Можно ли использовать основной домен организации {{ yandex-360 }} для рассылок {{ postbox-name }}? {#domain-yandex-360-mailing}

Да, домен организации {{ yandex-360 }} можно указать в настройках адреса и отправлять с него письма.

#### При использовании домена {{ yandex-360 }} действуют квоты и лимиты {{ yandex-360 }} или {{ postbox-name }}? {#domain-yandex-360-limits}

При использовании любых доменов действуют квоты и лимиты {{ postbox-name }}. Подробнее см. раздел [{#T}](../concepts/limits.md).
