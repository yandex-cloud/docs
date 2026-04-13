### В Managed Service for Kubernetes® используется безопасная конфигурация {#secure-configuration}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | k8s.secure-configuration ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Проверьте, что у вас внедрены процессы контроля групп узлов.

{% endnote %}

В Managed Service for Kubernetes пользователь управляет всеми настройками групп узлов, настройками [мастера](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#master) — только частично. Пользователь отвечает за безопасность всего кластера.

Для безопасной конфигурации Kubernetes, включая конфигурацию узлов, существует стандарт [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes). В Yandex Cloud группы узлов Kubernetes по умолчанию разворачиваются с конфигурацией, которая соответствует стандарту CIS Kubernetes Benchmark.

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению:**

* С помощью инструмента [kube-bench](https://github.com/aquasecurity/kube-bench) проверьте конфигурацию группы узлов по стандарту CIS Kubernetes Benchmark. Инструмент официально поддерживает группы узлов Yandex Cloud.
* [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) — это бесплатный инструмент, который позволяет автоматизировать сканирование образов на уязвимости и проверку конфигурации на соответствие CIS Kubernetes Benchmark. Starboard Operator поддерживает интеграцию с kube-bench и используется для его автоматического запуска.
