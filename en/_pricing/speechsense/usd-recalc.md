#|
|| **Recalculation type** | **Price per 1,000 characters,<br>without VAT** ||
|| Pro tags | {{ sku|USD|speechsense.reinit.tag.v1|string }} ||
|| Assistant,, YandexGPT Pro model | {{ sku|USD|speechsense.reinit.assistant.v1|string }} ||
|| Assistant, YandexGPT Lite model | {% calc [currency=USD] {{ sku|USD|speechsense.reinit.assistant.v1|number }} / 6 %} ||
|| Assistant, Qwen3 235B model | {% calc [currency=USD] {{ sku|USD|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|| Assistant, DeepSeek V3.2 model | {% calc [currency=USD] {{ sku|USD|speechsense.reinit.assistant.v1|number }} * 2 %} ||
|#