### Кластеры Kubernetes проверяются на соответствие требованиям CIS {#cis}
#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | k8s.cis ||
|#

#### Описание

**Как работает правило:** проверяется, что включен набор правил CIS Benchmark для Kubernetes, если в области контроля модуля [Контроль Kubernetes (KSPM)](https://yandex.cloud/ru/docs/security-deck/concepts/kspm) есть кластеры и узлы Kubernetes.

Набор правил CIS Benchmark для Kubernetes — это один из стандартов безопасности модуля KSPM, которые можно подключить к [окружению](https://yandex.cloud/ru/docs/security-deck/concepts/workspace) Security Deck. Он реализует рекомендации международного стандарта [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) и содержит правила проверки безопасной конфигурации компонента kubelet на рабочих узлах кластера.

Kubelet имеет широкие полномочия (управление подами, доступ к секретам, логам, exec в контейнеры), поэтому его небезопасная конфигурация — один из самых опасных векторов повышения привилегий в кластере.

Правила набора помогают обнаруживать ключевые классы угроз:
* несанкционированный доступ к API kubelet;
* аутентификация по сертификатам между apiserver и kubelet;
* ротация сертификатов;
* права доступа к конфигурационным файлам (`kubelet.conf`, `config.yaml`, файл службы);
* режим авторизации и разрешение kubelet управлять `iptables`.

При каждом срабатывании правила вы получаете [алерт](https://yandex.cloud/ru/docs/security-deck/concepts/alerts) с подробной информацией о нарушении, списком фактов и затронутых ресурсов, рекомендациями по исправлению.

#### Инструкции и решения по выполнению

Включите проверку по требованиям CIS Benchmark для Kubernetes:
1. Перейдите в сервис [Security Deck](https://center.yandex.cloud/security/).
2. На панели слева выберите **Окружение** и в открывшемся окне выберите нужное [окружение](https://yandex.cloud/ru/docs/security-deck/concepts/workspace) Security Deck.
3. Нажмите кнопку **Параметры окружения**.
4. Перейдите на вкладку **Модули контроля**.
5. Раскройте список стандартов для модуля **Контроль Kubernetes (KSPM)**.
6. Включите опцию **Требования стандарта CIS Benchmark™ для Kubernetes**.