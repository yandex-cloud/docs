Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
* `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ {{ coi }};
* `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ {{ coi }} GPU.

Минимальный размер загрузочного диска указан в параметре `min_disk_size`.
