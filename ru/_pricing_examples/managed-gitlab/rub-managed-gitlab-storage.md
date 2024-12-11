> 30 × {{ sku|RUB|gitlab.instance.disk|month|string }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|string }} = {% calc [currency=RUB] 30 × {{ sku|RUB|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|RUB|gitlab.backup|month|number }} %}

  Где:

  * 30 — объем хранилища (в гигабайтах).
  * {{ sku|RUB|gitlab.instance.disk|month|string }} — стоимость месяца использования 1 ГБ хранилища.
  * 20 — объем каждой резервной копии.
  * 7 — срок хранения резервных копий.
  * {{ sku|RUB|gitlab.backup|month|string }} — стоимость хранения 1 ГБ резервных копий.