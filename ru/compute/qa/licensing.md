# Лицензирование Windows

Правила использования программного обеспечения Microsoft регламентируются условиями лицензионного соглашения с Microsoft, заключаемого при приобретении продуктов Microsoft. Ответственность за соблюдение условий лицензирования Microsoft несет пользователь. Ниже изложены рекомендации по лицензированию. Вы не обязаны полагаться на изложенные положения, они не имеют юридической силы. Если у вас есть вопросы по поводу лицензирования и прав на использование программного обеспечения Microsoft, проконсультируйтесь со своим юридическим отделом или торговым посредником Microsoft. Информация на этой странице соответствует [текущим условиям использования продуктов Microsoft](https://www.microsoft.com/ru-ru/licensing/product-licensing/products).

#### Какие отношения существуют между Microsoft и {{ yandex-cloud }}? {#status}

{{ yandex-cloud }} имеет лицензию на распространение ПО Microsoft в рамках соглашения Services Provider License Agreement (SPLA) в целях предоставления программных услуг. Также, {{ yandex-cloud }} является авторизованным партнером Microsoft по программе [Мобильность Лицензий](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility).

#### Предоставляет ли {{ yandex-cloud }} расширенную поддержку продуктов Microsoft? {#expanded-support}

Нет, на данный момент команда {{ yandex-cloud }} не предоставляет консультаций по продуктам Microsoft.

#### Какое ПО Microsoft можно запускать на платформе {{ yandex-cloud }}? {#supported-soft}

На платформе {{ yandex-cloud }} можно запускать серверное программное обеспечение, доступное в рамках программы [Мобильность Лицензий](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility).

#### Что такое мобильность лицензий? {#license-mobility}

Мобильность лицензий — это преимущество, доступное клиентам с корпоративными лицензиями Microsoft на использование соответствующего серверного программного обеспечения по действующим договорам Microsoft Software Assurance (SA). Мобильность лицензий позволяет клиентам использовать соответствующее ПО Microsoft в работе со сторонними поставщиками облачных решений, такими как {{ yandex-cloud }}. См. дополнительные сведения на [сайте Microsoft](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility).

#### Как узнать, применима ли мобильность лицензий для того или иного продукта Microsoft? {#check-license-mobility}

Соответствующая информация включена в условия использования продуктов Microsoft. Возможность участия того или иного продукта в программе мобильности лицензий указана в соответствующем разделе договора Software Assurance. В число продуктов, участвующих в программе мобильности лицензий, входят Remote Desktop Services, System Center, Exchange и SharePoint.

#### Нужно ли иметь действующий договор Software Assurance и участвовать в программе мобильности лицензий, чтобы использовать собственные лицензии Microsoft в {{ yandex-cloud }}? {#sa-for-license-mobility}

При переносе лицензированного ПО в сервис Compute Cloud наличие действующего договора Software Assurance и участие в программе мобильности лицензий являются обязательными требованиями. Наличие действующего договора Software Assurance всегда является необходимым условием для участия в программе мобильности лицензий.

### Лицензирование: Windows Server {#windows-server}

#### Можно ли приобрести Windows Server у {{ yandex-cloud }}? {#buy-windows-server}

Да, вы можете приобрести виртуальную машину с предустановленным образом [Windows Server 2012](/marketplace/products/yc/windows-server-2012r2-datacenter) или [Windows Server 2016](/marketplace/products/yc/windows-server-2016-datacenter) в {{ marketplace-full-name }}. Лицензия на Windows Server входит в стоимость.

#### Как активировать Windows Server? {#activate-windows-server}

1. Убедитесь, что у ВМ есть доступ в интернет.
1. Выполните в PowerShell от имени Администратора следующие команды:

   ```powershell
   Test-NetConnection kms.cloud.yandex.net -Port 1688
   cscript.exe C:\Windows\System32\slmgr.vbs /dli
   cscript.exe C:\Windows\System32\slmgr.vbs /skms kms.cloud.yandex.net:1688
   cscript.exe C:\Windows\System32\slmgr.vbs /ato
   Get-Date
   Get-TimeZone
   ```

   Если активация так и не произошла, пришлите нам вывод этих команд.

#### Можно ли использовать собственные лицензии Windows Server в {{ compute-name }}? {#custom-windows-server}

Нет, на данный момент использовать собственные лицензии Windows Server нельзя.

#### Применима ли мобильность лицензий к Windows Server? {#lm-windows-server}

Нет, согласно условиям использования продуктов Microsoft, мобильность лицензий не распространяется на операционные системы Windows Server.

### Лицензирование: другие продукты Microsoft {#other-products}

#### Можно ли приобрести другие продукты Microsoft с включенными лицензиями для использования в {{ compute-name }}? {#buy-other-products}

Нет. В настоящий момент {{ yandex-cloud }} предоставляет только лицензии Windows Server, а также перенос лицензий на серверное программное обеспечение в рамках программы [Мобильность Лицензий](https://www.microsoft.com/ru-ru/licensing/licensing-programs/software-assurance-license-mobility). Возможность лицензирования MSDN, операционная система Windows, Microsoft Office и других продуктов пока не предоставляется.