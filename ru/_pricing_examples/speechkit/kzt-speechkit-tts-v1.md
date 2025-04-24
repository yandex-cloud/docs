> 2023 × ({{ sku|KZT|speechkit.tts_gpu.v1|string }} / 1 000 000) = {% calc [currency=KZT] round(2023 × ({{ sku|KZT|speechkit.tts_gpu.v1|number }} / 1 000 000) × 100) / 100 %}
>
> Итого: {% calc [currency=KZT] round(2023 × ({{ sku|KZT|speechkit.tts_gpu.v1|number }} / 1 000 000) × 100) / 100 %}.

Где:

* {{ sku|KZT|speechkit.tts_gpu.v1|string }} — стоимость за 1 млн символов.
* {{ sku|KZT|speechkit.tts_gpu.v1|string }} / 1 000 000 — стоимость за 1 символ.