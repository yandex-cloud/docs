# Мониторинг и логи

* [Как я могу отслеживать состояние кластера Managed Service for Kubernetes?](#monitoring)

* [Я могу получить логи моей работы в сервисах?](#logs)


* [Можно ли самостоятельно сохранять логи?](#auto-logging)


* [Можно ли использовать сервис Yandex Cloud Logging для просмотра логов?](#master-logging)

#### Как я могу отслеживать состояние кластера Managed Service for Kubernetes? {#monitoring}

[Получите статистику кластера](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md). Описание доступных метрик кластера приводится в [справочнике](../metrics.md).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../tutorials/fluent-bit-logging.md).


#### Можно ли использовать сервис Yandex Cloud Logging для просмотра логов? {#master-logging}

Да, для этого настройте отправку логов в [Cloud Logging](../../logging/index.md) при [создании](../operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../operations/kubernetes-cluster/kubernetes-cluster-update.md) [кластера Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster). Настройка доступна только в CLI, Terraform и API.