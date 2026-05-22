#|
|| **Тип пересчета** | **Цена за 1 000 символов,<br>вкл. НДС**  ||
|| Pro-теги | {{ sku|RUB|speechsense.reinit.tag.v1|string }} ||
|| Ассистент, модель YandexGPT Pro | {{ sku|RUB|speechsense.reinit.assistant.v1|string }} ||
|| Ассистент, модель YandexGPT Lite | {% calc [currency=RUB] {{ sku|RUB|speechsense.reinit.assistant.v1|number }} / 6 %} ||
|| Ассистент, модель Qwen3 235B | {% calc [currency=RUB] {{ sku|RUB|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|| Ассистент, модель DeepSeek V3.2 | {% calc [currency=RUB] {{ sku|RUB|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|#