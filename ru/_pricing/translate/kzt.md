| Услуга | Цена за 1 млн символов до 31 декабря 2025 года,<br/>вкл. НДС | Цена за 1 млн символов с 1 января 2026 года,<br/>вкл. НДС |
| ----- | ----- | ----- |
| Перевод | {{ sku|KZT|ai.mt.translate|string }} | {% calc [currency=KZT] round(({{ sku|KZT|ai.mt.translate|number }} / 112 × 116) × 100) / 100 %} | 
| Определение языка | {{ sku|KZT|ai.mt.detect|string }} | {% calc [currency=KZT] round(({{ sku|KZT|ai.mt.detect|number }} / 112 × 116) × 100) / 100 %} |
