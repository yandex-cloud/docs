# Лицензии Microsoft в {{ yandex-cloud }}

{% include [ms-licensing-personal-data-note](../_includes/ms-licensing-personal-data-note.md) %}

{% if product == "cloud-il" %}

## Использование ПО Microsoft в {{ yandex-cloud }} {#images}

{{ yandex-cloud }} предоставляет готовые образы с предустановленными Microsoft Windows Server в редакции Datacenter{% if product == "yandex-cloud" %} и Microsoft SQL Server{% endif %}. Лицензии на ПО в этих образах полностью соответствуют требованиям Microsoft. {% if product == "yandex-cloud" %}При использовании готовых образов {{ yandex-cloud }} вы оплачиваете необходимые лицензии и ресурсы {{ compute-name }}. Оплата будет начисляться в зависимости от [тарифного плана](pricing.md).{% endif %} 

{% if product == "cloud-il" %}

{% include [windows-trial](../_includes/compute/windows-trial.md) %}

{% endif %}

Использование образов {{ yandex-cloud }} с включенной лицензией на ПО Microsoft имеет ряд преимуществ:

* {{ yandex-cloud }} следит за соответствием лицензионным требованиям и управлением отчетностью об использовании лицензий.
* В {{ marketplace-name }} доступны различные версии Windows Server{% if product == "yandex-cloud" %} и SQL Server{% endif %}.
{% if product == "yandex-cloud" %}
* Клиентские лицензии для Windows Server уже включены, их не нужно покупать отдельно.
{% endif %}
* Образы Windows Server включают в себя две лицензии службы удаленных рабочих столов для администрирования системы.  

Используя ПО Microsoft в {{ yandex-cloud }}, вы соглашаетесь с [Условиями использования]{% if product == "yandex-cloud" %}{% if lang == "ru" %}(https://yandex.ru/legal/cloud_terms_marketplace/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_terms_marketplace/?lang=en){% endif %}{% endif %}{% if product == "cloud-il" %}(../legal/marketplace-terms.md){% endif %} {{ marketplace-full-name }} и с условиями использования [Microsoft License Terms](https://www.microsoft.com/licensing/contracts).

{% if product == "yandex-cloud" %}

### Особенности использования лицензий {{ MS }} в {{ compute-full-name }} {#sql-server-compute-licensing}

Использование лицензий {{ MS }} в сервисе {{ compute-full-name }} тарифицируется на авансовой основе. Это означает, что плата взимается в начале периода тарификации еще до фактического потребления ресурсов. В списке ниже под виртуальной машиной понимается виртуальная машина с образом {{ MS }}.

* Период тарификации — один календарный месяц.
* Если в течение периода тарификации вы создали новую виртуальную машину (в т. ч. путем восстановления из [снимка диска](../compute/concepts/backups.md)), то взимается полная стоимость лицензий за весь период тарификации.
* Если в течение периода тарификации вы остановили или удалили виртуальную машину, стоимость лицензий в этом периоде не возвращается.
* При первом запуске виртуальной машины, остановленной до начала текущего периода тарификации, взимается полная стоимость лицензий за весь период тарификации. Если виртуальная машина останавливалась и запускалась несколько раз за один период, плата за лицензии взимается только при первом запуске.
* Если в течение периода тарификации вы изменили конфигурацию виртуальной машины и снизили потребление ресурсов, стоимость освободившихся лицензий в этом периоде не возвращается. Новая стоимость начинает действовать с первого числа следующего периода тарификации.
* Если в течение периода тарификации вы изменили конфигурацию виртуальной машины и увеличили потребление ресурсов, то вам понадобятся дополнительные лицензии. При этом взимается полная стоимость этих лицензий за весь период тарификации независимо от даты внесения изменений.

{% endif %}

{% endif %}

## Использование собственных лицензий в {{ yandex-cloud }} {#byol}

Если у вас уже есть корпоративные лицензии Microsoft в рамках соглашений Microsoft Software Assurance ([SA]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3){% endif %}) или Microsoft Enterprise Agreement ([EA]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2){% endif %}), вы можете воспользоваться ими в {{ yandex-cloud }}. {% if product == "yandex-cloud" %}При этом оплата будет начисляться по тарифу [BYOL](pricing.md).{% endif %}

Воспользоваться лицензией можно в общей инфраструктуре по правилам программы [Перемещение лицензий](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) и в пределах выделенного оборудования в соответствии с правилами Microsoft Product Terms.

{% if product == "cloud-il" %}

### Использование существующих лицензий с программой перемещения лицензий {#mobility}

Перемещение лицензий доступно клиентам с корпоративными лицензиями Microsoft на использование программного обеспечения по действующим договорам Microsoft Software Assurance (SA). Наличие действующего договора SA является обязательным требованием для участия в программе перемещения лицензий и использования лицензированного ПО Microsoft в сервисе {{ compute-name }}. Перемещение лицензий облегчает переход пользователей в {{ yandex-cloud }} и позволяет пользователям с бессрочными лицензиями продолжить их использование без дополнительных расходов на лицензирование.

Для программы перемещения лицензий действует ряд ограничений:

1. Программа перемещения лицензий не применима к клиентским и серверным операционным системам и прикладным приложениям Windows.
1. Условия программы не распространяются на приложения в составе образов {{ compute-name }}. {% if product == "yandex-cloud" %}Например, Microsoft SQL Server в составе образа в {{ marketplace-name }} не попадает под действие программы. {% endif %}Вы можете использовать лицензии на своих виртуальных машинах, не используя подготовленные образы {{ marketplace-name }}.
1. Серверные приложения должны входить в перечень правомочных продуктов, который включает в себя: 

    * Exchange Server 
    * SharePoint Server
    * SQL Server Standard Edition
    * SQL Server Enterprise Edition
    * SQL Server Business Intelligence Edition
    * Skype for Business Server
    * System Center Server
    * Dynamics CRM Server
    * Dynamics AX Server
    * Project Server
    * Visual Studio Team Foundation Server
    * BizTalk Server
    * Forefront Identity Manager
    * Forefront Unified Access Gateway
    * Remote Desktop Services
    
    Полные правила программы перемещения лицензий представлены в официальной документации [Microsoft]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

#### Требования программы перемещения лицензий для Microsoft SQL Server {#SQLmobility}

Количество лицензий для работы Microsoft SQL Server в виртуальной среде зависит от версии SQL Server и используемых ресурсов. Однако по условиям Microsoft необходимо минимум 4 лицензии, чтобы обеспечить лицензирование 4 ядер процессора. Минимальное необходимое количество лицензий не зависит от модели лицензирования.

При запуске ПО Microsoft по программе перемещения лицензий ответственность за соблюдение правил лицензирования несете вы. Более подробную информацию о [требованиях программы перемещения лицензий](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=2) для Microsoft SQL Server вы найдете на официальном сайте Microsoft.

{% endif %}

### Правила перехода по программе перемещения лицензий {#rules}

Для использования лицензий в {{ yandex-cloud }} по программе перемещения лицензий необходимо заполнить форму регистрации для предоставления отчета в Microsoft. Использование лицензий имеет ограничения. Ознакомьтесь с ними в документации Microsoft Product Terms и у вашего поставщика (Licensing service provider). Процесс перехода к использованию лицензий подробно описан в [документации Microsoft](http://download.microsoft.com/download/7/9/b/79bd917e-760b-48b6-a266-796b3e47c47a/License_Mobility_Customer_Verification_Guide.pdf). 


{% if product == "yandex-cloud" %}

### Использование существующих лицензий на выделенном хосте {{ yandex-cloud }} {#dedicated-hosts}

[Выделенный хост](../compute/concepts/dedicated-host.md) — это физический сервер, предназначенный для размещения исключительно ваших виртуальных машин в {{ yandex-cloud }}. 

Если для поддержки ваших продуктов необходимо отдельно выделенное оборудование, вы можете использовать лицензии на ПО Microsoft на выделенном хосте {{ compute-name }}. Обязательное условие использования ваших лицензий на выделенном оборудовании — наличие действующего соглашения с бессрочными лицензиями Microsoft.

Использование выделенного оборудования с собственными лицензиями будет дешевле, чем использование лицензий, приобретенных у {{ yandex-cloud }}.

{% endif %}
