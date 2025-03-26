Образы продуктов, размещаемых в Marketplace, должны соответствовать [требованиям](../../marketplace/operations/create-image.md#requirements).

Если у вас нет образа ВМ, создайте его:

* [с помощью Packer](../../tutorials/infrastructure-management/packer-quickstart.md). Тогда образ автоматически загрузится в {{ compute-name }}.<br>Рекомендации по созданию образа:
    * В качестве базового используйте образ из [публичного каталога](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ yandex-cloud }}.
    * Посмотрите [примеры packer-рецептов](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer/packer).
    * [Автоматизируйте](../../tutorials/infrastructure-management/jenkins.md) сборку образов с помощью Jenkins.
* используя другие удобные для вас инструменты. Тогда вам потребуется самостоятельно [загрузить](../../compute/operations/image-create/upload.md) образ в {{ compute-name }}.

{% include [available-image-format](../compute/available-image-format.md) %}
