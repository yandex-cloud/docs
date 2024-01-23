# Разделение ответственности за обеспечение безопасности

Безопасность систем, использующих облачные сервисы, требует разделения ответственности между клиентом (владельцем конечной системы) и провайдером (владельцем облачной инфраструктуры). Это разделение зависит от модели облачных сервисов: [IaaS (Infrastructure as a Service)](/blog/posts/2022/01/iaas), [PaaS (Platform as a Service)](/blog/posts/2023/03/paas) или [SaaS (Software as a Service)](/blog/posts/2023/03/saas).

Визуально его можно представить таблицей, где:

- ![image](../../_assets/circle-ededed.svg =18x18) Клиент
- ![image](../../_assets/circle-80bdf9.svg =18x18) {{ yandex-cloud }}

|     | Собственная <br> инфраструктура | IaaS | PaaS | SaaS |
| --- | :---: | :---: | :---: | :---: |
| Управление доступом к данным | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) |
| Безопасность приложений | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Безопасность ОС | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Сетевая безопасность (Overlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Резервирование | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Шифрование | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Логи аудита | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Безопасность хранилища данных и оборудования | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Сетевая безопасность (Underlay) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |
| Физическая безопасность и катастрофоустойчивость (DR) | ![image](../../_assets/circle-ededed.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) | ![image](../../_assets/circle-80bdf9.svg) |

Во всех четырех ситуациях только клиент контролирует и управляет правами доступа. Остальная ответственность зависит от модели.

## Собственная инфраструктура {#own}
На клиенте лежит вся ответственность за обеспечение безопасности на всех уровнях.

## IaaS {#iaas}
Провайдер отвечает за физическую безопасность и отказоустойчивость самой платформы, защищает сеть, собирает и анализирует события безопасности гипервизоров и других компонентов инфраструктуры.

Клиент должен сам выполнять резервное копирование виртуальных машин, защищать виртуальную сеть, обеспечивать безопасность гостевых операционных систем, контролировать доступ и оберегать учетные записи пользователей облака.

## PaaS {#paas}
Провайдер отвечает за обеспечение защиты более высокоуровневых слоев инфраструктуры. Он защищает виртуальные машины и выполняет резервное копирование баз данных.

Клиент самостоятельно проводит классификацию данных, обеспечивает разграничение доступа к данным, настраивает процессы для их защиты, а также отвечает за управление правами пользователей и взаимодействие со сторонними сервисами.

## SaaS {#saas}

Провайдер отвечает за большинство аспектов безопасности: доступность и целостность данных, мониторинг и логирование, защиту сети, компонентов сервиса и самого приложения, обеспечение безопасности на физическом уровне.

Клиент отвечает за управление доступом пользователей к данным.
