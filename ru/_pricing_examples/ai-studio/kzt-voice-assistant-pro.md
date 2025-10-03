

{% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} × 2 + 0,13 ₸ × 60 + 0,10 ₸ × 20 = {% calc [currency=KZT] 8 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} + {% calc [currency=KZT] 0,13 × 60 %} + {% calc [currency=KZT] 0,10 × 20 %}

Итого: {% calc [currency=KZT] 8 × {{ sku|KZT|foundation_models.text_generation.v1|number }} + 0,13 × 60 + 0,10 × 20 %}.

Где:

* {% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} — стоимость обработки 1000 токенов.
* {% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} × 2 — стоимость обработки 2000 токенов.
* 0,13 ₸ — стоимость обработки 1 секунды входящего аудио.
* 0,13 ₸ × 60 — стоимость обработки 60 секунд входящего аудио.
* 0,10 ₸ — стоимость обработки 1 секунды исходящего аудио.
* 0,10 ₸ × 20 — стоимость обработки 20 секунд исходящего аудио.