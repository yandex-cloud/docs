> 30 × {{ sku|KZT|gitlab.instance.disk|month|string }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|string }} = {% calc [currency=KZT] 30 × {{ sku|KZT|gitlab.instance.disk|month|number }} + 20 × 7 × {{ sku|KZT|gitlab.backup|month|number }} %}

  Где:

  * 30 — объем хранилища (в гигабайтах).
  * {{ sku|KZT|gitlab.instance.disk|month|string }} — стоимость месяца использования 1 ГБ хранилища.
  * 20 — объем каждой резервной копии.
  * 7 — срок хранения резервных копий.
  * {{ sku|KZT|gitlab.backup|month|string }} — стоимость хранения 1 ГБ резервных копий.