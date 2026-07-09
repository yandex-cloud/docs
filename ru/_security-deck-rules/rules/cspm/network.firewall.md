### Для объектов облака используется межсетевой экран или группы безопасности {#firewall}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | network.firewall ||
|#

#### Описание

{% note info %}

При данном контроле автоматически проверяется, что на каждом подключенном к ВМ сетевом интерфейсе есть дополнительные назначенные группы безопасности, кроме группы безопасности по умолчанию.

Если используется наложенный межсетевой экран, просьба вручную отметить контроль выполненным.

{% endnote %}

Встроенный механизм групп безопасности позволяет управлять доступом ВМ к ресурсам и группами безопасности Yandex Cloud или ресурсам в интернете. Группа безопасности — это набор правил для входящего и исходящего трафика, который можно назначить на сетевой интерфейс ВМ. Группы безопасности работают как stateful firewall, то есть отслеживают состояние сессий: если правило разрешает создать сессию, ответный трафик будет автоматически разрешен. Инструкцию по настройке групп безопасности см. в разделе [Создать группу безопасности](https://yandex.cloud/ru/docs/vpc/operations/security-group-create). Указать группу безопасности можно в настройках ВМ.

Группы безопасности могут использоваться для защиты:

* ВМ * [Управляемых баз данных](https://yandex.cloud/ru/services#data-platform) * [Балансировщиков нагрузки](https://yandex.cloud/ru/docs/application-load-balancer/concepts/application-load-balancer) Yandex Application Load Balancer * [Кластеров](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#kubernetes-cluster) Yandex Managed Service for Kubernetes®

Вы можете управлять сетевым доступом без групп безопасности, например с помощью отдельной ВМ — межсетевой экран на основе образа [NGFW](https://yandex.cloud/ru/marketplace/products/usergate/ngfw) из Yandex Cloud Marketplace либо своего собственного образа. Использование NGFW может быть критично для тех клиентов, которым необходима следующая функциональность:

* Составление логов сетевых соединений * Потоковый анализ трафика на предмет зловредного контента * Обнаружение сетевых атак по сигнатурам * Другая функциональность классических NGFW-решений

Убедитесь, что в ваших [облаках](https://yandex.cloud/ru/docs/resource-manager/concepts/resources-hierarchy#cloud) используется что-либо из списка:

* Группы безопасности на каждом объекте облака * Отдельная ВМ NGFW из Cloud Marketplace * Принцип [BYOI](https://en.wikipedia.org/wiki/Bring_your_own_operating_system), например [собственный образ](https://yandex.cloud/ru/docs/compute/operations/image-create/upload) диска

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению:**

* Примените группы безопасности на все объекты, на которых группа отсутствует. * Для применения группы безопасности с помощью Terraform [используйте](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation) настройку групп безопасности (dev/stage/prod) с помощью Terraform. * Для использования NGFW [установите](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM) на ВМ межсетевой экран (NGFW): Check Point. * [Инструкция по использованию UserGate NGFW в облаке](https://docs.google.com/document/d/1yYwHorzkwXwIUGeG3n_K6Zo-07BVYowZJL7q2bAgVR8/edit?usp=sharing). * NGFW в режиме [active-passive](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/network-sec/checkpoint-2VM_active-active/README.md).
