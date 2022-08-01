# Лицензирование Windows

Правила использования программного обеспечения Microsoft регламентируются условиями лицензионного соглашения с Microsoft, заключаемого при приобретении продуктов Microsoft. Ответственность за соблюдение условий лицензирования Microsoft несет пользователь. Ниже изложены рекомендации по лицензированию. Вы не обязаны полагаться на изложенные положения, они не имеют юридической силы. Если у вас есть вопросы по поводу лицензирования и прав на использование программного обеспечения Microsoft, проконсультируйтесь со своим юридическим отделом или торговым посредником Microsoft. Информация на этой странице соответствует [текущим условиям использования продуктов Microsoft]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

## Лицензирование: общие вопросы {#common}

#### Какие отношения существуют между Microsoft и {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} имеет лицензию на распространение ПО Microsoft в рамках соглашения Services Provider License Agreement (SPLA) в целях предоставления программных услуг. Также, {{ yandex-cloud }} является авторизованным партнером Microsoft по программе [Мобильность лицензий]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.

#### Предоставляет ли {{ yandex-cloud }} расширенную поддержку продуктов Microsoft? {#expanded-support}

Нет, на данный момент команда {{ yandex-cloud }} не предоставляет консультаций по продуктам Microsoft.

#### Что такое мобильность лицензий? {#license-mobility}

Мобильность лицензий — это преимущество, доступное клиентам с корпоративными лицензиями Microsoft на использование соответствующего серверного программного обеспечения по действующим договорам Microsoft Software Assurance (SA). Мобильность лицензий позволяет клиентам использовать соответствующее ПО Microsoft в работе со сторонними поставщиками облачных решений, такими как {{ yandex-cloud }}. См. дополнительные сведения на [сайте Microsoft]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.

#### Какое ПО Microsoft можно запускать на платформе {{ yandex-cloud }}? {#supported-soft}

На платформе {{ yandex-cloud }} можно запускать серверное программное обеспечение, доступное в рамках программы [Мобильность лицензий]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.

#### Как узнать, применима ли программа Мобильности лицензий для того или иного продукта Microsoft? {#check-license-mobility}

Соответствующая информация включена в условия использования продуктов Microsoft. Возможность участия того или иного продукта в программе Мобильности лицензий указана в соответствующем разделе [договора Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}. В число продуктов, участвующих в программе мобильности лицензий, входят Remote Desktop Services, System Center, Exchange и SharePoint.

#### Нужно ли иметь действующий договор Software Assurance и участвовать в программе мобильности лицензий, чтобы использовать собственные лицензии Microsoft в {{ yandex-cloud }}? {#sa-for-license-mobility}

Да. При использовании лицензированного ПО Microsoft в сервисе Compute Cloud наличие действующего договора Software Assurance и участие в программе Мобильности лицензий являются обязательными требованиями. Наличие действующего договора Software Assurance всегда является необходимым условием для участия в программе Мобильности лицензий.

#### Почему нужно указывать адрес при использовании продуктов Microsoft? {#ms-licensing-address}

{% if product == "yandex-cloud" %}С 24 января 2022 г. для использования продуктов Microsoft{% endif %}{% if product == "cloud-il" %}Для использования продуктов Microsoft{% endif %} необходимо указывать пользовательские данные и адреса физических и юридических лиц — это требования лицензионной политики Microsoft. Если данные не заполнены, запустить продукты Microsoft будет нельзя.

#### Можно ли использовать собственные лицензии в {{ compute-name }}? {#custom}

Вопросы о лицензировании Windows Server подробно рассмотрены в разделе [{#T}](../../compute/qa/licensing.md).

Если же речь о других программных продуктах, которые вы хотите использовать внутри ВМ, изучите приобретенную вами лицензию или обратитесь в техническую поддержку самого продукта — вам подскажут, возможно ли продукт с этой лицензией использовать в {{ yandex-cloud }}.

### Лицензирование: Windows Server {#windows-server}

#### Можно ли приобрести Windows Server у {{ yandex-cloud }}? {#buy-windows-server}

Да, вы можете [приобрести](/marketplace?categories=databases&operationSystems=WINDOWS) виртуальную машину с предустановленным образом Windows Server 2012 R2, Windows Server 2016 или Windows Server 2019 у {{ yandex-cloud }}. Лицензия на Windows Server входит в стоимость.

#### Как активировать Windows Server {#activate-windows-server}

Проблемы с активацией могут возникнуть, если у ВМ нет доступа в интернет.

1. Убедитесь, что у ВМ есть доступ в интернет.
1. Выполните в PowerShell от имени Администратора следующие команды:

   ```powershell
   Test-NetConnection {{ ms-kms-host }} -Port {{ ms-kms-port }}
   cscript.exe C:\Windows\System32\slmgr.vbs /dli
   cscript.exe C:\Windows\System32\slmgr.vbs /skms {{ ms-kms-host }}:{{ ms-kms-port }}
   cscript.exe C:\Windows\System32\slmgr.vbs /ato
   Get-Date
   Get-TimeZone
   ```

   Если активация так и не произошла, пришлите нам вывод этих команд.

#### Применима ли Мобильность лицензий к Windows Server? {#lm-windows-server}

Нет, согласно условиям использования продуктов Microsoft, Мобильность лицензий не распространяется на операционные системы Windows Server.

### Лицензирование: другие продукты Microsoft {#other-products}

#### Можно ли приобрести другие продукты Microsoft с включенными лицензиями для использования в Compute Cloud? {#buy-other-products}

Да. В настоящий момент {{ yandex-cloud }} предоставляет лицензии Windows Server, {% if product == "yandex-cloud" %}Microsoft SQL Server, RDS, {% endif %}а также перенос лицензий на серверное программное обеспечение в рамках программы [Мобильности лицензий]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}. Возможность лицензирования MSDN, ОС Windows, Microsoft Office и других продуктов не предоставляется.