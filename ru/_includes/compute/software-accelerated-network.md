[Программное ускорение сети](../../compute/concepts/software-accelerated-network.md) происходит за счет переноса сетевой нагрузки с ядер [виртуальной машины](../../compute/concepts/vm.md) на специально выделенные ресурсы физического сервера. Так исключается борьба пользовательских и сетевых процессов за аппаратные ресурсы, на которых работает ВМ: весь сетевой трафик обрабатывается отдельно. Благодаря этому снижаются задержки и потери пакетов при передаче трафика, а вычислительные ресурсы ВМ освобождаются для обслуживания ваших приложений.

[Стоимость](../../compute/pricing.md#software-accelerated-network) дополнительных аппаратных ресурсов зависит от [платформы](../../compute/concepts/vm-platforms.md) и количества ядер ВМ.

Чтобы включить программно-ускоренную сеть, [измените настройки](../../compute/operations/vm-control/vm-update-resources.md#enable-software-accelerated-network) существующей ВМ или выберите опцию **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}** при [создании новой ВМ](../../compute/operations/vm-create/create-linux-vm.md).

## Рекомендации по использованию программно-ускоренной сети {#use-cases}

Программно-ускоренную сеть рекомендуется включать для уменьшения времени обработки запросов:
* На ВМ с пользовательскими инсталляциями баз данных при интенсивной работе с [диском](../../compute/concepts/disk.md).
* В [группах узлов](../../managed-kubernetes/concepts/index.md#node-group) [кластеров](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) [{{ managed-k8s-full-name }}](../../managed-kubernetes/) при работе внутрикластерных балансировщиков L7, например [Ingress-Nginx-контроллера](https://kubernetes.github.io/ingress-nginx/) или [Istio Ingress Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/).