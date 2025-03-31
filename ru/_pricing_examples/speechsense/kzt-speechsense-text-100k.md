> {{ sku|KZT|speechsense.analysis.text.v2|string }} × 90 000,02 = {% calc [currency=KZT] round({{ sku|KZT|speechsense.analysis.text.v2|number }} × 90 000,02 × 100) / 100 %}
>
> Итого: {% calc [currency=KZT] round({{ sku|KZT|speechsense.analysis.text.v2|number }} × 90 000,02 × 100) / 100 %} — стоимость аналитики 90 000 015 символов текстовых диалогов.

Где:
* {{ sku|KZT|speechsense.analysis.text.v2|string }} — стоимость анализа тысячи символов текста для первых 100 000 тысяч.