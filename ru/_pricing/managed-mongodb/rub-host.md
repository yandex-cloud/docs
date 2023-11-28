| Ресурс        | Цена за 1 час                                        | Цена за 1 месяц                                            |
| ----- | ----: | ----: |
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }}   | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|month|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|month|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|month|string }} |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }}   | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|month|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|month|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|month|string }} |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|month|string }} |

Цена RAM зависит от [редакции MongoDB](../../managed-mongodb/concepts/editions.md).

* Для Community Edition:

    | Ресурс        | Цена за 1 час                                   | Цена за 1 месяц                                       |
    | ----- | ----: | ----: |
    | **Intel Broadwell** |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }} | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|month|string }} |
    | **Intel Cascade Lake** |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }} | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|month|string }} |
    | **Intel Ice Lake** |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }} | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|month|string }} |

* Для Enterprise Edition объем RAM выделяется и оплачивается квантами по 100 ГБ. Например, стоимость 16 ГБ RAM равна стоимости 100 ГБ, а 128 ГБ — 200 ГБ. При этом списание средств происходит единовременно за весь календарный месяц, в котором запущен кластер, вне зависимости от времени его фактической работы и даты запуска. Стоимость RAM для кластеров с редакцией Enterprise Edition — 230 000 ₽ за 100 ГБ в календарный месяц.

