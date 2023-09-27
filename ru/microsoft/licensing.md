---
title: "Лицензии Microsoft в {{ yandex-cloud }}"
description: "Из этой статьи вы узнаете, как управлять лицензиями на продукты Microsoft в {{ yandex-cloud }}."
---

# Лицензии Microsoft в {{ yandex-cloud }}

{% include [ms-licensing-personal-data-note](../_includes/ms-licensing-personal-data-note.md) %}


## Использование собственных лицензий в {{ yandex-cloud }} {#byol}

Если у вас уже есть корпоративные лицензии Microsoft в рамках соглашений Microsoft Software Assurance ([SA](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3)) или Microsoft Enterprise Agreement ([EA](https://www.microsoft.com/ru-ru/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2)), вы можете воспользоваться ими в {{ yandex-cloud }}. При этом оплата будет начисляться по тарифу [BYOL](pricing.md).


Воспользоваться лицензией можно в общей инфраструктуре по правилам программы [Перемещение лицензий](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) и в пределах выделенного оборудования в соответствии с правилами Microsoft Product Terms.





### Правила перехода по программе перемещения лицензий {#rules}

Для использования лицензий в {{ yandex-cloud }} по программе перемещения лицензий необходимо заполнить форму регистрации для предоставления отчета в Microsoft. Использование лицензий имеет ограничения. Ознакомьтесь с ними в документации Microsoft Product Terms и у вашего поставщика (Licensing service provider). Процесс перехода к использованию лицензий подробно описан в [документации Microsoft](http://download.microsoft.com/download/7/9/b/79bd917e-760b-48b6-a266-796b3e47c47a/License_Mobility_Customer_Verification_Guide.pdf).




### Использование существующих лицензий на выделенном хосте {{ yandex-cloud }} {#dedicated-hosts}

[Выделенный хост](../compute/concepts/dedicated-host.md) — это физический сервер, предназначенный для размещения исключительно ваших виртуальных машин в {{ yandex-cloud }}. 

Если для поддержки ваших продуктов необходимо отдельно выделенное оборудование, вы можете использовать лицензии на ПО Microsoft на выделенном хосте {{ compute-name }}. Обязательное условие использования ваших лицензий на выделенном оборудовании — наличие действующего соглашения с бессрочными лицензиями Microsoft.

Использование выделенного оборудования с собственными лицензиями будет дешевле, чем использование лицензий, приобретенных у {{ yandex-cloud }}.

