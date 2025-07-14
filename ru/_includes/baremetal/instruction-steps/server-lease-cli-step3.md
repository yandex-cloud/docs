Арендуйте сервер:

```bash
yc baremetal server create \
  --hardware-pool-id <пул> \
  --configuration-id <идентификатор_конфигурация> \
  --storage "partition={type=<файловая_система>,size-gib=<размер_раздела>,mount-point=<точка_монтирования>},raid-type=<уровень RAID-массива>,disk={id=<номер_диска>,size-gib=<размер_диска>,type=<тип_диска>}" \
  --os-settings "image-id=<идентификатор_образа>,image-name=<имя_образа>,ssh-key-public=<содержимое_открытого_SSH-ключа>,ssh-key-user-id=<идентификатор_пользователя_SSH-ключа>,password-plain-text=<пароль_пользователя>,password-lockbox-secret={secret-id=<идентификатор_секрета>,version-id=<версия_секрета>,key=<ключ_секрета>}" \
  --rental-period-id <период_аренды> \
  --network-interfaces private-subnet-id=<идентификатор_приватной_подсети> \
  --network-interfaces public-subnet-id=<идентификатор_публичной_подсети> \
  --name <имя_сервера> \
  --description "<описание_сервера>" \
  --labels <ключ_метки>=<значение_метки>
```