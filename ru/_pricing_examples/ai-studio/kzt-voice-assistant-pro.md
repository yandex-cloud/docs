{% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} × 2 + 0,13 ₸ × 60 + 0,10 ₸ × 20 = {% calc [currency=KZT] 8 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} + {% calc [currency=KZT] 0,13 × 60 %} + {% calc [currency=KZT] 0,10 × 20 %}

Итого: {% calc [currency=KZT] 8 × {{ sku|KZT|foundation_models.text_generation.v1|number }} + 0,13 × 60 + 0,10 × 20 %}.

Где:

* {% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} — стоимость обработки 1000 токенов.
* {% calc [currency=KZT] 4 × {{ sku|KZT|foundation_models.text_generation.v1|number }} %} × 2 — стоимость обработки 2000 токенов.
* {{ sku|KZT|foundation_models.realtime_audio.input.v1|string }} — стоимость обработки 1 секунды входящего аудио.
* {{ sku|KZT|foundation_models.realtime_audio.input.v1|string }} × 60 — стоимость обработки 60 секунд входящего аудио.
* {{ sku|KZT|foundation_models.realtime_audio.output.v1|string }} — стоимость обработки 1 секунды исходящего аудио.
* {{ sku|KZT|foundation_models.realtime_audio.output.v1|string }} × 20 — стоимость обработки 20 секунд исходящего аудио.