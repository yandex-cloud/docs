---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Лицензии Microsoft в {{ yandex-cloud }}

## Использование ПО Microsoft в {{ yandex-cloud }}

{{ yandex-cloud }} предоставляет готовые образы с предустановленными Microsoft Windows Server в редакциях Standard и Datacenter и Microsoft SQL Server. Лицензии на ПО в этих образах полностью соответствуют требованиям Microsoft. При использовании готовых образов {{ yandex-cloud }} вы оплачиваете необходимые лицензии и ресурсы {{ compute-name }}. Оплата будет начисляться в зависимости от [тарифного плана](pricing.md). 

Использование купленных у {{ yandex-cloud }} образов с включенной лицензией на ПО Microsoft имеет ряд преимуществ:

* {{ yandex-cloud }} следит за соответствием лицензионным требованиям и управлением отчетностью об использовании лицензий.
* В {{ marketplace-name }} доступны различные версии Windows Server и SQL Server.
* Клиентские лицензии для Windows Server уже включены, их не нужно покупать отдельно.
* Образы Windows Server включают в себя две лицензии службы удаленных рабочих столов для администрирования системы.  

## Использование собственных лицензий в {{ yandex-cloud }} {#byol}

Если у вас уже есть корпоративные лицензии Microsoft в рамках соглашений Microsoft Software Assurance ([SA](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-default?activetab=software-assurance-default-pivot%3aprimaryr3)) или Microsoft Enterprise Agreement ([EA](https://www.microsoft.com/ru-ru/licensing/licensing-programs/enterprise?activetab=enterprise-tab%3aprimaryr2)), вы можете воспользоваться ими в {{ yandex-cloud }}. При этом оплата будет начисляться по тарифу [BYOL](pricing.md).

Воспользоваться лицензией можно в общей инфраструктуре по правилам программы [Мобильности лицензий](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility) и в пределах выделенного оборудования в соответствии с правилами Microsoft Product Terms.

### Использование существующих лицензий с программой Мобильности лицензий {#mobility}

Мобильность лицензий доступна клиентам с корпоративными лицензиями Microsoft на использование программного обеспечения по действующим договорам Microsoft Software Assurance (SA). Наличие действующего договора SA является обязательным требованием для участия в программе Мобильности лицензий и использования лицензированного ПО Microsoft в сервисе {{ compute-name }}. Мобильность лицензий облегчает переход пользователей в {{ yandex-cloud }} и позволяет пользователям с бессрочными лицензиями продолжить их использование без дополнительных расходов на лицензирование.

Для программы Мобильности лицензий действует ряд ограничений:

1. Программа Мобильности лицензий не применима к клиентским и серверным операционным системам и прикладным приложениям Windows.
1. Условия программы не распространяются на приложения в составе образов {{ compute-name }}. Например, Microsoft SQL Server в составе образа в {{ marketplace-name }} не попадает под действие программы. Вы можете использовать лицензии на своих виртуальных машинах, не используя подготовленные образы {{ marketplace-name }}.
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
    
    Полные правила программы Мобильности лицензий представлены в официальной документации [Microsoft](https://www.microsoft.com/ru-ru/licensing/product-licensing/products).

#### Требования программы Мобильности лицензий для Microsoft SQL Server {#SQLmobility}

Количество лицензий для работы Microsoft SQL Server в виртуальной среде зависит от версии SQL Server и используемых ресурсов. Однако по условиям Microsoft необходимо минимум 4 лицензии, чтобы обеспечить лицензирование 4 ядер процессора. Минимальное необходимое количество лицензий не зависит от модели лицензирования.

При запуске ПО Microsoft по программе поддержки Мобильности лицензий ответственность за соблюдение правил лицензирования несете вы. Более подробную информацию о [требованиях программы Мобильности лицензий](https://www.microsoftvolumelicensing.com/DocumentSearch.aspx?Mode=3&DocumentTypeId=2) для Microsoft SQL Server вы найдете на официальном сайте Microsoft.

### Правила перехода по программе Мобильности лицензий {#rules}

Для использования лицензий в {{ yandex-cloud }} по программе Мобильности лицензий необходимо заполнить форму регистрации для предоставления отчета в Microsoft. Использование лицензий имеет ограничения. Ознакомьтесь с ними в документации Microsoft Product Terms и у вашего поставщика (Licensing service provider). Процесс перехода к использованию лицензий подробно описан в [документации Microsoft](http://download.microsoft.com/download/7/9/b/79bd917e-760b-48b6-a266-796b3e47c47a/License_Mobility_Customer_Verification_Guide.pdf). 

### Использование существующих лицензий на выделенном хосте {{ yandex-cloud }} {#dedicated-hosts}

[Выделенный хост](../compute/concepts/dedicated-host.md) — это физический сервер, предназначенный для размещения исключительно ваших виртуальных машин в {{ yandex-cloud }}. 

Если для поддержки ваших продуктов необходимо отдельно выделенное оборудование, вы можете использовать лицензии на ПО Microsoft на выделенном хосте {{ compute-name }}. Обязательное условие использования ваших лицензий на выделенном оборудовании — наличие действующего соглашения с бессрочными лицензиями Microsoft.

Использование выделенного оборудования с собственными лицензиями будет дешевле, чем использование лицензий, приобретенных у {{ yandex-cloud }}.