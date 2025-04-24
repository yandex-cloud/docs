> 2023 × ({{ sku|RUB|speechkit.tts_gpu.v1|string }} / 1 000 000) = {% calc [currency=RUB] round(2023 × ({{ sku|RUB|speechkit.tts_gpu.v1|number }} / 1 000 000) × 100) / 100 %}
>
> Итого: {% calc [currency=RUB] round(2023 × ({{ sku|RUB|speechkit.tts_gpu.v1|number }} / 1 000 000) × 100) / 100 %}.
  
Где:

* {{ sku|RUB|speechkit.tts_gpu.v1|string }} — стоимость за 1 млн символов.
* {{ sku|RUB|speechkit.tts_gpu.v1|string }} / 1 000 000 — стоимость за 1 символ.