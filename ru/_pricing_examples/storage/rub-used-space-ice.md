Например, если цена за хранение 1&nbsp;ГБ данных в ледяном хранилище в месяц составляет {{ sku|RUB|storage.bucket.used_space.ice|month|string }}, а объект размером 3&nbsp;ГБ хранился в ледяном хранилище с 1 января по 20 сентября (8 месяцев и 20 дней), то его хранение тарифицируется следующим образом:

> С 1 января по 20 сентября суммарно
>
> : _A_ = 3 × (8 + (20 / 30)) × {{ sku|RUB|storage.bucket.used_space.ice|month|string }} = (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|string }} = {% calc [currency=RUB] (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %}
>
> 20 сентября, при удалении объекта
>
> : _B_ = (3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|string }}) − _A_ = {% calc [currency=RUB] 3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} − {% calc [currency=RUB] (3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }} %} = {% calc [currency=RUB] (3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) %}
>
> Итого
>
> : _A_ + _B_ = {% calc [currency=RUB] ((3 × 260 / 30) × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) + ((3 × 12 × {{ sku|RUB|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) {{ sku|RUB|storage.bucket.used_space.ice|month|number }})) %}