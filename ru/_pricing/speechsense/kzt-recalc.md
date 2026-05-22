#|
|| **Тип пересчета** | **Цена за 1 000 символов,<br>вкл. НДС** ||
|| Pro-теги | {{ sku|KZT|speechsense.reinit.tag.v1|string }} ||
|| Ассистент, модель YandexGPT Pro | {{ sku|KZT|speechsense.reinit.assistant.v1|string }} ||
|| Ассистент, модель YandexGPT Lite | {% calc [currency=KZT] {{ sku|KZT|speechsense.reinit.assistant.v1|number }} / 6 %} ||
|| Ассистент, модель Qwen3 235B | {% calc [currency=KZT] {{ sku|KZT|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|| Ассистент, модель DeepSeek V3.2 | {% calc [currency=KZT] {{ sku|KZT|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|#