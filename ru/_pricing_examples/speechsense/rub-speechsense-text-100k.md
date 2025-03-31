> {{ sku|RUB|speechsense.analysis.text.v2|string }} × 90 000,02 = {% calc [currency=RUB] round({{ sku|RUB|speechsense.analysis.text.v2|number }} × 90 000,02 × 100) / 100 %}
>
> Итого: {% calc [currency=RUB] round({{ sku|RUB|speechsense.analysis.text.v2|number }} × 90 000,02 × 100) / 100 %} — стоимость аналитики 90 000 015 символов текстовых диалогов.

Где:
* {{ sku|RUB|speechsense.analysis.text.v2|string }} — стоимость анализа тысячи символов текста для первых 100 000 тысяч.