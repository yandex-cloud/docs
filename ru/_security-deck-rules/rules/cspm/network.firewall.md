### Для объектов облака используется межсетевой экран или группы безопасности {#firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.firewall ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет наличие групп безопасности для следующих типов ресурсов:
`enum <resource-type>`

{% endnote %}

{% note warning "**Ручная проверка**" %}

Данное правило требуется ручной проверки. После проверки и обновления, отметьте ее выполнение вручную.

{% endnote %}

Встроенный механизм групп безопасности позволяет управлять доступом ВМ к ресурсам и группами безопасности Yandex Cloud или ресурсам в интернете. Группа безопасности — это набор правил для входящего и исходящего трафика, который можно назначить на сетевой интерфейс ВМ. Группы безопасности работают как stateful firewall, то есть отслеживают состояние сессий: если правило разрешает создать сессию, ответный трафик будет автоматически разрешен. Инструкцию по настройке групп безопасности см. в разделе [Создать группу безопасности](https://yandex.cloud/ru/docs/vpc/operations/security-group-create). Указать группу безопасности можно в настройках ВМ.

Группы безопасности могут использоваться для защиты:

* ВМ.
* [Управляемых баз данных](https://yandex.cloud/ru/services#data-platform)
* [Балансировщиков нагрузки Yandex Application Load Balancer](https://yandex.cloud/ru/docs/application-load-balancer/concepts/application-load-balancer)
* [Кластеров Yandex Managed Service for Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes)

Вы можете управлять сетевым доступом без групп безопасности, например, с помощью отдельной ВМ — межсетевой экран на основе образа NGFW из Yandex Cloud Marketplace, либо своего собственного образа. Использование NGFW может быть критично для тех клиентов, которым необходима следующая функциональность:

* Составление логов сетевых соединений.
* Потоковый анализ трафика на предмет зловредного контента.
* Обнаружение сетевых атак по сигнатурам.
* Другая функциональность классических NGFW-решений.

Убедитесь, что в ваших облаках используется что-либо из списка:

* Группы безопасности на каждом объекте облака.
* Отдельная ВМ NGFW из Cloud Marketplace.
* [Принцип BYOI, например: собственный образ диска](https://yandex.cloud/ru/docs/compute/operations/image-create/upload)

#### Инструкции и решения по выполнению

* Примените группы безопасности на все объекты, на которых группа отсутствует.
* Для применения группы безопасности с помощью Terraform используйте настройку [групп безопасности (dev/stage/prod) с помощью Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
* Для использования NGFW установите на [ВМ межсетевой экран (NGFW): Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
* Инструкция по использованию [UserGate NGFW в облаке](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing)
* NGFW в [режиме active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md)