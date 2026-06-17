# Общие вопросы про Yandex Cloud Postbox

#### Поддерживаются ли кириллические домены? {#cyrillic-domains}

Да, Yandex Cloud Postbox поддерживает кириллические домены ([IDN](https://ru.wikipedia.org/wiki/Internationalized_domain_name)). Чтобы использовать кириллический домен, при [создании адреса](../operations/create-address.md) укажите его в кодировке [Punycode](https://ru.wikipedia.org/wiki/Punycode). Например, домен `пример.рф` в формате Punycode будет выглядеть как `xn--e1afmkfd.xn--p1ai`.

#### Можно ли использовать основной домен организации Яндекс 360 для рассылок Yandex Cloud Postbox? {#domain-yandex-360-mailing}

Да, домен организации Яндекс 360 можно указать в настройках адреса и отправлять с него письма.

#### При использовании домена Яндекс 360 действуют квоты и лимиты Яндекс 360 или Yandex Cloud Postbox? {#domain-yandex-360-limits}

При использовании любых доменов действуют квоты и лимиты Yandex Cloud Postbox. Подробнее в разделе [Квоты и лимиты в Yandex Cloud Postbox](../concepts/limits.md).