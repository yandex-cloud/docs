

{% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} × 2 + $0.000216 × 60 + $0.00166 × 20 = {% calc [currency=USD] 8 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} + {% calc [currency=USD] 0,000216 × 60 %} + {% calc [currency=USD] 0,00166 × 20 %}

Total: {% calc [currency=USD] 8 × {{ sku|USD|foundation_models.text_generation.v1|number }} + 0,000216 × 60 + 0,00166 × 20 %}.

Where:

* {% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %}: Cost of processing per 1000 tokens.
* {% calc [currency=USD] 4 × {{ sku|USD|foundation_models.text_generation.v1|number }} %} × 2: Cost of processing per 2000 tokens.
* $0.000216: Cost of processing per 1 second of the incoming audio.
* $0.000216 × 60: Cost of processing per 60 seconds of the incoming audio.
* $0.00166: Cost of processing per 1 second of the outgoing audio.
* $0.00166 × 20: Cost of processing per 20 seconds of the outgoing audio.