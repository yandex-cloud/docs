Арендуйте сервер:

```bash
yc baremetal v2 server create \
  --folder-id <идентификатор_каталога> \
  --server '{
    name="<имя_сервера>",
    description="<описание_сервера>",
    hardware-pool-id="<пул>",
    configuration=stock-configuration-id="<идентификатор_конфигурации>",
    next-rental-period-id="<период_аренды>",
    os-settings={
      image-id="<идентификатор_образа>",
      ssh-key=ssh-public-key-text="<содержимое_открытого_SSH-ключа>",
      password=password-plain-text="<пароль_пользователя>",
      storages=[{
        partitions=[{
          type=<файловая_система>,
          size-bytes=<размер_раздела_в_байтах>,
          mount-point="<точка_монтирования>"
        }],
        storage-type=raid={
          type=<уровень_RAID-массива>,
          disks=[{id="<номер_диска>",size-bytes=<размер_диска_в_байтах>,type=<тип_диска>}]
        }
      }]
    },
    network-interfaces=[
      {interface=private-interface={native-subnet-id="<идентификатор_приватной_подсети>"}},
      {interface=public-interface={native-subnet-config=native-subnet={subnet-id="<идентификатор_публичной_подсети>"}}}
    ],
    annotations={<ключ_метки>="<значение_метки>"}
  }'
```
