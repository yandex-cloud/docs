Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

Образ {{ coi }} в реестре [{{ container-registry-full-name }}](../../container-registry/) может обновляться и меняться в соответствии с релизами. При этом образ на виртуальной машине не обновится автоматически до последней версии. Чтобы создать группу ВМ с последней версией {{ coi }}, необходимо самостоятельно проверить ее наличие:

{% list tabs %}

- CLI

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Результат:
  
  ```bash
  id: <идентификатор последней версии COI>
  folder_id: standard-images
  ...
  ```

- Marketplace

  1. Перейдите на страницу {{ marketplace-name }} и выберите образ с нужной конфигурацией:
     * [{{ coi }}](/marketplace/products/yc/container-optimized-image).
     * [{{ coi }} GPU](/marketplace/products/yc/container-optimized-image-gpu).
  1. В блоке **Идентификаторы продукта** скопируйте значение `image_id`.

{% endlist %}