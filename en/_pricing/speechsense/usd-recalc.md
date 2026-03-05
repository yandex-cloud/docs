#|
|| **Recalculation type** | **Price per 1,000 characters,<br>without VAT** ||
|| Pro tags | {% calc [currency=USD] 0,012 / 120 %} ||
|| Assistant,, YandexGPT Pro model | {{ sku|USD|speechsense.analysis.assistant.v1|string }} ||
|| Assistant, YandexGPT Lite model | {% calc [currency=USD] {{ sku|USD|speechsense.analysis.assistant.v1|number }} / 6 %} ||
|| Assistant, Qwen3 235B model | {% calc [currency=USD] {{ sku|USD|speechsense.analysis.assistant.v1|number }} * 2 %} ||
|#