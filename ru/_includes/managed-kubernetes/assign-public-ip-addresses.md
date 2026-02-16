Чтобы выдать доступ в интернет узлам кластера {{ managed-k8s-name }}, выполните одно из действий:
* Назначьте [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) узлам кластера, указав `--network-interface ipv4-address=nat` или `--network-interface ipv6-address=nat`.
* [Включите доступ к узлам {{ managed-k8s-name }} из интернета](../../managed-kubernetes/operations/node-group/node-group-update.md#node-internet-access) после того, как создадите группу узлов.
