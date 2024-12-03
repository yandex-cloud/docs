* первые 2 000 писем — бесплатно;
* с 2 001 по 10 000 письмо (всего 8 000 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.2|string }} за каждую 1 000 писем;
* с 10 001 по 50 000 письмо (всего 40 000 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.10|string }} за каждую 1 000 писем;
* с 50 001 по 65 500 письмо (всего 15 500 писем) — по {{ sku|KZT|postbox.email.count.v1|pricingRate.50|string }} за каждую 1 000 писем.

Сумма оплаты за 65 500 писем в месяц составит:

> (8 × {{ sku|KZT|postbox.email.count.v1|pricingRate.2|string }}) + (40 × {{ sku|KZT|postbox.email.count.v1|pricingRate.10|string }}) + (15,5 × {{ sku|KZT|postbox.email.count.v1|pricingRate.50|string }}) = {% calc [currency=KZT] (8 × {{ sku|KZT|postbox.email.count.v1|pricingRate.2|number }}) + (40 × {{ sku|KZT|postbox.email.count.v1|pricingRate.10|number }}) + (15,5 × {{ sku|KZT|postbox.email.count.v1|pricingRate.50|number }}) %}