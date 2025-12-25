| Количество | Цена до 31.12.2025, <br>вкл. НДС | Цена с 01.01.2026, <br>вкл. НДС |
| ----- | ----- | ----- |
| 1000 юнитов  | {{ sku|KZT|foundation_models.text_embedding.v1|string }} | {% calc [currency=KZT] round(({{ sku|KZT|foundation_models.text_embedding.v1|number }} / 112 × 116) × 100) / 100 %} |
