> 2,023 × ({{ sku|USD|speechkit.tts_gpu.v1|string }} / 1,000,000) = {% calc [currency=USD] 2023 × ({{ sku|USD|speechkit.tts_gpu.v1|number }} / 1 000 000) %}
>
> Total: {% calc [currency=USD] 2023 × ({{ sku|USD|speechkit.tts_gpu.v1|number }} / 1 000 000) %}.

Where:

* {{ sku|USD|speechkit.tts_gpu.v1|string }}: Cost per 1M characters.
* {{ sku|USD|speechkit.tts_gpu.v1|string }} / 1,000,000: Cost per character.