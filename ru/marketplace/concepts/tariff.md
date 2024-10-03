---
title: Тариф в {{ marketplace-full-name }}
---

# Тариф

_Тариф_ — это стоимость использования программного продукта, которую видят пользователи {{ marketplace-short-name }}. В тариф должны быть включены:
* желаемая стоимость продукта — сумма без НДС, которую издатель хочет получить за использование своего продукта;
* комиссия в размере 20% от желаемой стоимости продукта, которую взимает {{ yandex-cloud }};
* НДС.

При расчете в конце отчетного периода {{ yandex-cloud }} вычтет из тарифа свою комиссию и НДС, если ваше юридическое лицо не является плательщиком НДС. 

Для разных типов продуктов доступны разные типы тарифов:

{% include [types](../../_includes/marketplace/types-of-charge.md) %}

Совместимость разных типов продуктов и тарифов представлена в таблице ниже.

|   | Free | BYOL | PAYG (ядро в час, инстанс в час, оперативная память в час) | PAYG (другая схема тарификации) | Subscription |
|-----|-----|-----|-----|-----|-----|
| {{ compute-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| {{ cos-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| {{ managed-k8s-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| {{ cloud-apps-name }} | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| SaaS | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |