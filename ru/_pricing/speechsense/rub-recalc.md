#|
|| **Тип пересчета** | **Цена за 1 000 символов,<br>вкл. НДС**  ||
|| Pro-теги | {% calc [currency=RUB] 0,012 %} ||
|| Ассистент, модель YandexGPT Pro | {{ sku|RUB|speechsense.analysis.assistant.v1|string }} ||
|| Ассистент, модель YandexGPT Lite | {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|| Ассистент, модель Qwen3 235B | {% calc [currency=RUB] {{ sku|RUB|speechsense.analysis.assistant.v1|number }} * 2 %} ||
|#