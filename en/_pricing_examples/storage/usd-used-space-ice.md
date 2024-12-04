For example, if the price for storing 1 GB of data in ice storage per month is {{ sku|USD|storage.bucket.used_space.ice|month|string }}, and a 3 GB object was in ice storage from January 1 through September 20 (8 months and 20 days), your storage charge will be calculated as follows:

> Total from January 1 through September 20
>
> : _A_ = 3 × (8 + (20 / 30)) × {{ sku|USD|storage.bucket.used_space.ice|month|string }} = (3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|string }} = {% calc [currency=USD] (3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %}
>
> September 20 after deleting the object
>
> : _B_ = (3 × 12 × {{ sku|USD|storage.bucket.used_space.ice|month|string }}) − _A_ = {% calc [currency=USD] 3 × 12 × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %} − {% calc [currency=USD] (3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|number }} %} = {% calc [currency=USD] (3 × 12 × {{ sku|USD|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|number }}) %}
>
> Total
>
> : _A_ + _B_ = {% calc [currency=USD] ((3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|number }}) + ((3 × 12 × {{ sku|USD|storage.bucket.used_space.ice|month|number }}) - ((3 × 260 / 30) × {{ sku|USD|storage.bucket.used_space.ice|month|number }})) %}