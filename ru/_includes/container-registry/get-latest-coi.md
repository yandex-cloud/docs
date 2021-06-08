Узнайте идентификатор последней версии [публичного образа](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

Образ {{ coi }} в реестре [{{ container-registry-full-name }}](../../container-registry/) может обновляться и меняться в соответствии с релизами. При этом образ на виртуальной машине не обновится автоматически до последней версии. Чтобы создать группу ВМ с последней версией {{ coi }}, необходимо самостоятельно проверить ее наличие:

{% list tabs %}

- CLI

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Результат выполнения команды:

  ```bash
  id: fd8iv792kirahcnqnt0q
  folder_id: standard-images
  created_at: "2021-01-29T13:30:22Z"
  name: container-optimized-image-1611926453
  description: Build by Assembly-Workshop-build-66870
  family: container-optimized-image
  storage_size: "6157238272"
  min_disk_size: "10737418240"
  product_ids:
  - f2elj2f52bbqe4af8tfd
  status: READY
  os:
    type: LINUX
  ```

{% endlist %}