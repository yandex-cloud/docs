| Service | Price per unit of tariffing, <br>without VAT |
| --- | --- |
| Speech recognition, per 1 minute | $0.0065 |
| Speech synthesis, per 1 minute | $0.005 |
| Text generation, per 1000 tokens | {% calc [currency=USD] ((2 × {{ sku|USD|foundation_models.text_generation.v1|number }}) × 100) / 100 %} |