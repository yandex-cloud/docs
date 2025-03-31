> {{ sku|KZT|speechsense.analysis.text.v2|string }} × 100 000 + {{ sku|KZT|speechsense.analysis.text.v2|pricingRate.100000|string }} × 50 000,03 = {% calc [currency=KZT] round(({{ sku|KZT|speechsense.analysis.text.v2|number }} × 100 000 + {{ sku|KZT|speechsense.analysis.text.v2|pricingRate.100000|number }} × 50 000,03) × 100) / 100 %}
>
> Итого: {% calc [currency=KZT] round(({{ sku|KZT|speechsense.analysis.text.v2|number }} × 100 000 + {{ sku|KZT|speechsense.analysis.text.v2|pricingRate.100000|number }} × 50 000,03) × 100) / 100 %} — стоимость аналитики 150 000 023 символов текстовых диалогов.

Где:
* {{ sku|KZT|speechsense.analysis.text.v2|string }} — стоимость анализа тысячи символов текста для первых 100 000 тысяч.
* {{ sku|KZT|speechsense.analysis.text.v2|pricingRate.100000|string }} — стоимость анализа тысячи символов текста для последующих 50 000,023 тысяч.