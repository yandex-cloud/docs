{% note info %}

Чтобы создавать, изменять и редактировать [ВМ](../../compute/concepts/vm.md), необходима _минимальная_ [роль](../../compute/security/index.md#compute-editor) `compute.editor` на [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder). Для создания ВМ с лицензируемым образом дополнительно потребуется [роль](../../marketplace/security/index.md#license-manager-viewer) `license-manager.viewer`.

Для создания ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses) дополнительно потребуется [роль](../../vpc/security/index.md#vpc-public-admin) `vpc.publicAdmin`.

{% endnote %}