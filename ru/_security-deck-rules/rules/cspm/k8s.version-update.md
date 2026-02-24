### Используется одна из трех последних версий Kubernetes и ведется мониторинг обновлений {#version-update}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | k8s.version-update ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Данное правило требует ручной проверки версии Kubernetes и мониторинга обновлений.

{% endnote %}

Для Kubernetes доступно как автоматическое, так и ручное обновление [кластера](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#kubernetes-cluster) и [группы узлов](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#node-group). Вы можете в любое время запросить обновление кластера Kubernetes или его узлов вручную до [последней поддерживаемой версии](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/release-channels-and-updates). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания. Kubernetes регулярно выпускает обновления. Для соответствия стандартам ИБ:

* выберите подходящий канал обновления и настройте автоматическое применение обновлений, либо применяйте обновления вручную сразу после публикации в выбранном канале;

* проверьте, что настройки обновлений соответствуют стандартам ИБ;

* используйте одну из трех последних версий Kubernetes, так как любые обновления, в том числе обновления безопасности, выпускаются только для них.

#### Инструкции и решения по выполнению

* [Инструкция как обновить кластер автоматически](https://yandex.cloud/ru/docs/managed-kubernetes/operations/update-kubernetes#cluster-upgrade)
* [Инструкция как обновить кластер вручную](https://yandex.cloud/ru/docs/managed-kubernetes/operations/update-kubernetes#cluster-manual-upgrade)