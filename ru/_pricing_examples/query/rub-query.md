#### Пример 1 {#example-1}

Запрос вычитал 250 ГБ данных из {{ objstorage-full-name }}.

В этом случае стоимость запроса составит:
> (250 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|string }}) = {% calc [currency=RUB] 250 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|number }} %}

#### Пример 2 {#example-2}

Запрос считал 100 ГБ данных из {{ objstorage-full-name }}, 10 ГБ данных из {{ mch-name }}, 20 ГБ данных из {{ mpg-name }}.

Общий объем считанных данных составит:
> (100 + 10 + 20) = 130 ГБ

Стоимость запроса в этом случае составит:
> (130 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|string }}) = {% calc [currency=RUB] 130 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|number }} %}

#### Пример 3 {#example-3}

Запрос считал 1 МБ данных из {{ objstorage-full-name }}.

Общий объем считанных данных составит:
> (max(1 МБ, 10 МБ)) = 10 МБ = 0,01 ГБ

Стоимость запроса в этом случае составит:
> (0,01 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|string }}) = {% calc [currency=RUB] 0,01 × {{ sku|RUB|yq.network.ingress.v1|pricingRate.10|number }} %}