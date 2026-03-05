#|
|| **Тип пересчета** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| Pro-теги | {% calc [currency=KZT] 0,012 * 5 %} ||
|| Ассистент, модель YandexGPT Pro | {{ sku|KZT|speechsense.analysis.assistant.v1|string }} ||
|| Ассистент, модель YandexGPT Lite | {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|| Ассистент, модель Qwen3 235B | {% calc [currency=KZT] {{ sku|KZT|speechsense.analysis.assistant.v1|number }} * 2 %} ||
|#