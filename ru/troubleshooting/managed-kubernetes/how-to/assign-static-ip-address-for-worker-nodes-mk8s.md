# Назначение статических внешних IP-адресов для узлов кластера Managed Service for Kubernetes

## Описание задачи {#case-description}
Возникла необходимость закрепить статический внешний адрес за узлами нод-группы Manaded Service for Kubernetes.

## Решение {#case-resolution}
Задать статический IP для кластера Kubernetes или его узлов не получится. При использовании публичного адреса [назначается](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) случайный IP-адрес из пула адресов Yandex Cloud.

Для того чтобы ноды кластера имели статический публичный IP-адрес, воспользуйтесь одним из вариантов:
- Разместите кластер [за балансировщиком нагрузки со статическим внешним IP-адресом](../../../managed-kubernetes/operations/create-load-balancer.md);
- Настройте маршрутизацию трафика в интернет с использованием [NAT-инстанса](../../../tutorials/routing/nat-instance.md) со статическим внешним IP-адресом.
