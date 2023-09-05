# Не увеличился размер загрузочного диска


## Описание проблемы {#issue-description}

После увеличения загрузочного диска его размер поменялся в консоли, но не внутри ВМ.

## Решение {#issue-resolution}

Если после увеличения размера диска раздел на загрузочном диске не расширился автоматически, нужно использовать команды:

```
bash
sudo mount -o size=10M,rw,nodev,nosuid -t tmpfs tmpfs /tmp
sudo growpart /dev/vda 2
sudo resize2fs /dev/vda2
df -h
sudo umount /tmp
```
