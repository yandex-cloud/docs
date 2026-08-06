Арендуйте сервер:

```bash
yc baremetal server create \
  --folder-id <идентификатор_каталога> \
  --hardware-pool-id <пул> \
  --configuration-id <идентификатор_конфигурации> \
  --os-settings-spec "image-id=<идентификатор_образа>,storages=[{partitions=[{type=<файловая_система>,size-gib=<размер_раздела>,mount-point=<точка_монтирования>}],storage-type={raid={type=<уровень_RAID-массива>,disks=[{id=<номер_диска>,size-gib=<размер_диска>,type=<тип_диска>}]}}}],ssh-key={ssh-public-key=<содержимое_открытого_SSH-ключа>},password={password-plain-text=<пароль_пользователя>}" \
  --rental-period-id <период_аренды> \
  --network-interfaces '{interface={private-interface={native-subnet-id=<идентификатор_приватной_подсети>}}}' \
  --network-interfaces '{interface={public-interface={native-subnet-config={native-subnet={subnet-id=<идентификатор_публичной_подсети>}}}}}' \
  --name <имя_сервера> \
  --description "<описание_сервера>" \
  --labels <ключ_метки>=<значение_метки>
```
