### Доступ к компонентам Kubernetes ограничен по IP-адресам, портам и протоколам {#network-firewall-scope}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | k8s.network-firewall-scope ||
|#

#### Описание

Рекомендуется использовать [группы безопасности](https://yandex.cloud/ru/docs/vpc/concepts/security-groups), чтобы настроить безопасный доступ к компонентам кластеров Kubernetes по принципу минимальных привилегий. Для доступа к компонентам кластера открывайте только необходимые порты по необходимым сетевым протоколам и только для доверенных IP-адресов.

#### Инструкции и решения по выполнению

[Создайте ](https://yandex.cloud/ru/docs/vpc/operations/security-group-create)группу безопасности и [настройте](https://yandex.cloud/ru/docs/managed-kubernetes/operations/connect/security-groups) ее для применения в кластере Kubernetes.

При настройке руководствуйтесь ключевыми принципами настройки групп безопасности для кластеров Kubernetes:

* Не используйте правила безопасности с широкими правилами доступа:

    * **Диапазон портов**: `0-65535`.
    * **Протокол**: `Любой`.
    * **Источник**: `CIDR`.
    * **CIDR-блоки**: IPv4 `0.0.0.0/0` или IPv6 `::/0` (доступ открыт с любых адресов).
* Создавайте отдельные группы безопасности для:

    * [мастеров](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#master) Kubernetes;
    * [узлов](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#node-group) Kubernetes;
    * [балансировщиков нагрузки](https://yandex.cloud/ru/docs/application-load-balancer/concepts/application-load-balancer) и [Ingress-контроллеров](https://yandex.cloud/ru/docs/application-load-balancer/tools/k8s-ingress-controller/);
    * баз данных и бэкендов;
    * [бастионных хостов](https://yandex.cloud/ru/docs/tutorials/routing/bastion).
* В правилах безопасности используйте ссылки на другие группы безопасности вместо IP-адресов ресурсов (в поле **Источник**/**Назначение** выбирайте **Группы безопасности** вместо **CIDR**). Это позволит сохранить сетевой доступ при изменении IP-адресов ресурсов.
* Ограничьте исходящий трафик. Рекомендуется явно задавать диапазоны IP-адресов, портов и протоколы назначения в правилах безопасности для исходящего трафика.
* Включите логирование работы кластеров Kubernetes.
* Активируйте [Flow Logs Kubernetes](https://yandex.cloud/ru/docs/security/domains/kubernetes#flow-logs-kubernetes) для мониторинга трафика.