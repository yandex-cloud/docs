## Перенесите stateless-нагрузки {#stateless}

Для переноса stateless-нагрузок экспортируйте манифесты исходного кластера, адаптируйте для применения в {{ yandex-cloud }} и примените в целевом кластере.

Чек-лист адаптации манифестов:

* Вендор-специфичные CRD заменены [сервисами {{ yandex-cloud }}]({{ link-cloud-services }}) или [решениями из {{ marketplace-full-name }}](../../../managed-kubernetes/operations/applications/marketplace.md).
* Устаревшие `apiVersion` заменены на актуальные для целевой версии Kubernetes.
* [Контроллер Gwin](../../../managed-kubernetes/alb-ref/gwin-index.md) (`gwin-default`) используется в `ingressClassName` и `gatewayClassName`.
* Аннотации ресурсов для настройки балансировщика нагрузки заменены на [аннотации {{ yandex-cloud }}](../../../managed-kubernetes/alb-ref/index.md).
* Ссылки на образы ведут в {{ cloud-registry-full-name }} (`{{ cloud-registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`).

Для очистки манифестов можно использовать утилиту [kubectl-neat](https://github.com/itaysk/kubectl-neat).
