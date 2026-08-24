Получите список идентификаторов доступных [семейств образов](../../compute/concepts/image.md#family):

```bash
yc compute image list \
  --folder-id standard-images \
  --limit 0 \
  --jq '.[].family' | sort | uniq
```

Результат:

```text
...
ubuntu-2204-lts
ubuntu-2204-lts-oslogin
ubuntu-2004-lts-gpu
...
```