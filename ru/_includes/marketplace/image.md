Образы продуктов, размещаемых в Marketplace, должны соответствовать [требованиям](../../marketplace/operations/create-image.md#requirements).

Если у вас нет образа ВМ, создайте его:

* [с помощью Packer](../../tutorials/infrastructure-management/packer-quickstart). Тогда образ автоматически загрузится в {{ compute-name }}.<br>Рекомендации по созданию образа:
	* В качестве базового используйте образ из [публичного каталога](../../compute/operations/images-with-pre-installed-software/get-list) {{ yandex-cloud }}.
	* Посмотрите [примеры packer-рецептов](https://github.com/yandex-cloud/examples/tree/master/jenkins-packer/packer).
	* [Автоматизируйте](../../tutorials/infrastructure-management/jenkins) сборку образов с помощью Jenkins.
* используя другие удобные для вас инструменты. Тогда вам потребуется самостоятельно [загрузить](../../compute/operations/image-create/upload.md) образ в {{ compute-name }}. Поддерживаемые форматы образов: Qcow2, VMDK и RAW.
