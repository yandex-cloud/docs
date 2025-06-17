---
title: Правила тарификации для {{ backup-full-name }}
description: В статье содержатся правила тарификации сервиса {{ backup-name }}.
editable: false
---

# Правила тарификации для {{ backup-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


## Из чего складывается стоимость использования {{ backup-name }} {#rules}

Стоимость {{ backup-name }} зависит от количества защищенных ресурсов — виртуальных машин {{ compute-full-name }} и серверов {{ baremetal-full-name }}, а также суммарного объема хранилища, занятого резервными копиями.

### Защита ресурсов {#vms}

ВМ {{ compute-name }} или сервер {{ baremetal-name }} начинают тарифицироваться в {{ backup-name }} после того, как они были привязаны к [политике резервного копирования](./concepts/policy.md). Плата продолжает взиматься, пока ресурс не будет отвязан от политики независимо от статуса ресурса.

Если вы удалите ВМ в [{{ compute-full-name }}](../compute/) с помощью [консоли управления]({{ link-console-main }}), ВМ также будет отвязана от всех политик. Если вы удалите ВМ с помощью CLI, {{ TF }} или API, она не будет автоматически отвязана от политик, сделайте это самостоятельно.

Сервер {{ baremetal-name }} также нужно отвязывать от политик самостоятельно.

Минимальная единица тарификации — 1 защищенный ресурс (ВМ или сервер {{ baremetal-name }}) в час.

### Использование хранилища {#backups}

Плата взимается за суммарный объем хранилища, занимаемый резервными копиями.

Минимальная единица тарификации — час хранения 1 МБ данных.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

Если защищаемый ресурс был остановлен или удален, его резервные копии продолжают храниться в {{ backup-name }}, и за их объем продолжает взиматься плата. На размер резервных копий влияют:
* заполненность диска ВМ или сервера {{ baremetal-name }};
* количество измененных данных при регулярном резервном копировании;
* возможность сжатия данных.

{% note info %}

Чтобы сократить затраты, удалите ненужные резервные копии удаленных ВМ или серверов {{ baremetal-name }}, от аренды которых вы отказались.

{% endnote %}

Объем резервных копий защищаемого ресурса может быть как меньше размера диска самого ресурса, например, при малой заполненности диска и хорошей сжимаемости данных, так и больше, например, когда резервных копий много, а данные на них постоянно меняются и плохо сжимаются.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Цены за месяц использования формируются из расчета 720 часов в месяц.

### Защищенные {{ backup-name }} ресурсы {#prices-vms}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-vm-backups](../_pricing/backup/rub-vm-backups.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-vm-backups](../_pricing/backup/kzt-vm-backups.md) %}

{% endlist %}



### Хранение резервных копий {#prices-backups}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-backup-size](../_pricing/backup/rub-backup-size.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-backup-size](../_pricing/backup/kzt-backup-size.md) %}

{% endlist %}



## Пример расчета стоимости {#price-example}

Пример расчета стоимости {{ backup-name }} за один месяц для следующей конфигурации:
* к политикам резервного копирования привязана 1 ВМ;
* суммарный объем резервных копий составляет 50 ГБ.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-backup](../_pricing_examples/backup/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-backup](../_pricing_examples/backup/kzt.md) %}

{% endlist %}



