

{% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} × 2 + 0,026 ₽ × 60 + 0,02 ₽ × 20 = {% calc [currency=RUB] 8 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} + {% calc [currency=RUB] 0,026 × 60 %} + {% calc [currency=RUB] 0,02 × 20 %}

Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|foundation_models.text_generation.v1|number }} + 0,026 × 60 + 0,02 × 20 %}.

Где:

* {% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} — стоимость обработки 1000 токенов.
* {% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} × 2 — стоимость обработки 2000 токенов.
* 0,026 ₽ — стоимость обработки 1 секунды входящего аудио.
* 0,026 ₽ × 60 — стоимость обработки 60 секунд входящего аудио.
* 0,02 ₽ — стоимость обработки 1 секунды исходящего аудио.
* 0,02 ₽ × 20 — стоимость обработки 20 секунд исходящего аудио.