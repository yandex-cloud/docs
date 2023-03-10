# Лицензирование Microsoft

Правила использования программного обеспечения Microsoft регламентируются условиями лицензионного соглашения с Microsoft, заключаемого при приобретении продуктов Microsoft. Ответственность за соблюдение условий лицензирования Microsoft несет пользователь. Ниже изложены рекомендации по лицензированию. Вы не обязаны полагаться на изложенные положения, они не имеют юридической силы. Если у вас есть вопросы по поводу лицензирования и прав на использование программного обеспечения Microsoft, проконсультируйтесь со своим юридическим отделом или торговым посредником Microsoft. Информация на этой странице соответствует [текущим условиям использования продуктов Microsoft]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/product-licensing/products){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/product-licensing/products){% endif %}.

### Общие вопросы {#common}

{% if product == "cloud-il" %}

#### Какие отношения существуют между Microsoft и {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} имеет лицензию на распространение ПО Microsoft в рамках соглашения Services Provider License Agreement (SPLA) в целях предоставления программных услуг.

#### Предоставляет ли {{ yandex-cloud }} расширенную поддержку продуктов Microsoft? {#expanded-support}

Нет, на данный момент команда {{ yandex-cloud }} не предоставляет консультаций по продуктам Microsoft.

{% endif %}

{% if product == "yandex-cloud" %}

#### Что такое перемещение лицензий? {#license-mobility}

{% include [ms-license-mobility-desc](../../_includes/ms-license-mobility-desc.md) %}

#### Какое ПО Microsoft можно запускать на платформе {{ yandex-cloud }}? {#supported-soft}

На платформе {{ yandex-cloud }} можно запускать серверное программное обеспечение, доступное в рамках программы [Перемещение лицензий]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}.


#### Как узнать, применима ли программа перемещения лицензий для того или иного продукта Microsoft? {#check-license-mobility}

Соответствующая информация включена в условия использования продуктов Microsoft. Возможность участия того или иного продукта в программе перемещения лицензий указана в соответствующем разделе [договора Software Assurance]{% if lang == "ru" %}(https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility){% endif %}{% if lang == "en" %}(https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-license-mobility){% endif %}. В число продуктов, участвующих в программе перемещения лицензий, входят Remote Desktop Services, System Center, Exchange и SharePoint.


#### Нужно ли иметь действующий договор Software Assurance и участвовать в программе перемещения лицензий, чтобы использовать собственные лицензии Microsoft в {{ yandex-cloud }}? {#sa-for-license-mobility}

Да. При использовании лицензированного ПО Microsoft в сервисе {{ compute-name }} наличие действующего договора Software Assurance и участие в программе перемещения лицензий являются обязательными требованиями.

{% endif %}


#### Почему нужно указывать адрес при использовании продуктов Microsoft? {#ms-licensing-address}

{% if product == "yandex-cloud" %}С 24 января 2022 г. для использования продуктов Microsoft{% endif %}{% if product == "cloud-il" %}Для использования продуктов Microsoft{% endif %} необходимо указывать имена пользователей, названия и налоговые идентификаторы юридических лиц, адреса физических и юридических лиц — это требования лицензионной политики Microsoft. Данные **могут быть отправлены в Microsoft**. Если данные не заполнены, вы не сможете запустить продукты Microsoft.

#### Можно ли использовать продукты Microsoft с собственными лицензиями в {{ compute-name }}? {#custom}

Вопросы о лицензировании Windows Server подробно рассмотрены в разделе {% if product == "yandex-cloud" %}[{#T}](../../microsoft/byol.md){% endif %}{% if product == "cloud-il" %}[Лицензирование Windows Server](#windows-server){% endif %}.

Если же речь о других программных продуктах, которые вы хотите использовать внутри ВМ, изучите приобретенную вами лицензию или обратитесь в Microsoft, чтобы проверить, возможно ли продукт с этой лицензией использовать в {{ yandex-cloud }}.


{% if product == "cloud-il" %}

#### Поддерживает ли {{ yandex-cloud }} перемещение лицензий? {#license-mobility}

{% include [ms-license-mobility-desc](../../_includes/ms-license-mobility-desc.md) %}

Сейчас {{ yandex-cloud }} не поддерживает перемещение лицензий.

{% endif %}

{% if product == "cloud-il" %}

### Лицензирование Windows Server {#windows-server}

#### Можно ли приобрести Windows Server у {{ yandex-cloud }}? {#buy-windows-server}

Да, вы можете приобрести виртуальную машину с предустановленным образом Windows Server. См. [список доступных продуктов](/marketplace?type=COMPUTE_IMAGE&operationSystems=WINDOWS&sortBy=name-a-z&categories=os&search=Windows+Server) в {{ marketplace-full-name }}.

#### Как активировать Windows Server? {#activate-windows-server}

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

#### Можно ли использовать собственные лицензии Windows Server в {{ compute-name }}? {#custom-windows-server}

Вы можете использовать собственные лицензии Windows Server в составе собственных образов, соблюдая правила лицензий.

{% endif %}

{% if product == "cloud-il" %}

### Лицензирование других продуктов Microsoft {#other-products}

#### Можно ли приобрести другие продукты Microsoft с включенными лицензиями для использования в {{ compute-name }}? {#buy-other-products}

Все продукты Microsoft, доступные в {{ yandex-cloud }}, [перечислены в {{ marketplace-full-name }}](/marketplace?type=COMPUTE_IMAGE&search=Microsoft&operationSystems=WINDOWS).

{% endif %}