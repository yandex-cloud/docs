{% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} × 2 + $0.000216 × 60 + $0.00166 × 20 = {% calc [currency=USD] 8 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} + {% calc [currency=USD] 0,000216 × 60 %} + {% calc [currency=USD] 0,00166 × 20 %}

Total: {% calc [currency=USD] 8 × {{ sku|USD|foundation_models.text_generation.v1|number }} + 0,000216 × 60 + 0,00166 × 20 %}.

Where:

* {% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %}: Cost of processing 1,000 tokens.
* {% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} × 2: Cost of processing 2,000 tokens.
* {{ sku|USD|foundation_models.realtime_audio.input.v1|string }}: Cost of processing 1 second of incoming audio.
* {{ sku|USD|foundation_models.realtime_audio.input.v1|string }} × 60: Cost of processing 60 seconds of incoming audio.
* {{ sku|USD|foundation_models.realtime_audio.output.v1|string }}: Cost of processing 1 second of outgoing audio.
* {{ sku|USD|foundation_models.realtime_audio.output.v1|string }} × 20: Cost of processing 20 seconds of outgoing audio.