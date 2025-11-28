{% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} × 2 + 0,026 ₽ × 60 + 0,02 ₽ × 20 = {% calc [currency=RUB] 8 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} + {% calc [currency=RUB] 0,026 × 60 %} + {% calc [currency=RUB] 0,02 × 20 %}

Итого: {% calc [currency=RUB] 8 × {{ sku|RUB|foundation_models.text_generation.v1|number }} + 0,026 × 60 + 0,02 × 20 %}.

Где:

* {% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} — стоимость обработки 1000 токенов.
* {% calc [currency=RUB] 4 × {{ sku|RUB|foundation_models.text_generation.v1|number }} %} × 2 — стоимость обработки 2000 токенов.
* {{ sku|RUB|foundation_models.realtime_audio.input.v1|string }} — стоимость обработки 1 секунды входящего аудио.
* {{ sku|RUB|foundation_models.realtime_audio.input.v1|string }} × 60 — стоимость обработки 60 секунд входящего аудио.
* {{ sku|RUB|foundation_models.realtime_audio.output.v1|string }} — стоимость обработки 1 секунды исходящего аудио.
* {{ sku|RUB|foundation_models.realtime_audio.output.v1|string }} × 20 — стоимость обработки 20 секунд исходящего аудио.
