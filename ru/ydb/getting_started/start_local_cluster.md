---
sourcePath: overlay/getting_started/start_local_cluster.md
---
В данном документе описан локальный режим запуска KiKiMR. Локальный режим может быть полезен для разработки, отладки и тестирования пользовательской функциональности. Локальный режим не предназначен для тестирования производительности.

## Готовый скрипт запуска {#ready-made-startup-script}
Это способ запустить KiKiMR "в одну команду" при наличии выкачанной Arcadia (далее предполагается, что arcadia находится в вашем `$HOME`)
1. Соберите бинарник KiKiMR
```
$ cd ~/arcadia/kikimr/driver/
$ ya make -r
```
2. Запустите скрипт https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/tools/local_kikimr/local_kikimr.sh (рабочая директория, из которой запускается скрипт, должна быть внутри дерева arcadia, в котором он лежит)
```
$ ~/arcadia/kikimr/tools/local_kikimr/local_kikimr.sh
```
3. Будет запущен локальный инстанс KiKiMR кластера. Можете зайти на http://localhost:8765, чтобы посмотреть состояние кластера.
4. Для остановки и запуска используйте команды (запускать в папке `~/local_kikimr`)
```
% cd ~/local_kikimr
$ ./basic_kikimr.bash stop
$ ./basic_kikimr.bash start
```
5. Будут доступны messagebus на порту 2134, GRPC на потру 2135 и http мониторинг на 8765.

### Что сделал скрипт? {#what-did-the-script-do}
1. Создал директорию `~/local_kikimr`
2. Сгенерировал в этой директории конфигурацию для запуска кластера
3. Создал `~/local_kikimr/file1` на 10GB эмулирующий блочное устройство, на котором работает KiKiMR; когда вы запишете свои данные, они попадут в этот файл
4. Запустил процесс `kikimr`, можете посмотреть через `ps aux | grep kikimr`
5. Процесс KiKiMR полностью работоспособен, по порту 2134 он принимает пользовательские запросы, можете написать программу, работающую с KiKiMR
6. KiKiMR кластер запущен локально с erasure encoding=none, т.е. данные сохраняются в одной копии локально в файл, устойчивости к сбоям диска нет

### Как управлять кластером? {#how-to-manage-a-cluster}
1. В директории `~/local_kikimr` находится скрипт `basic_kikimr.bash`, можете остановить KiKiMR и поднять заново
```
$ cd ~/local_kikimr
$ ./basic_kikimr.bash stop      # остановка KiKiMR
$ ./basic_kikimr.bash start     # запуск KiKiMR (с сохранением всех данных)
```
2. Если хотите почистить локальный инстанс KiKiMR, то достаточно стереть `~/local_kikimr` (остановив перед этим сервис). Данные будут также удалены.


## Пошаговая инструкция запуска KiKiMR в локальном режиме {#step-by-step-instructions-for-starting-kikimr-in-local-mode}
Если вы хотите кастомизировать локальный инстанс KiKiMR, и "Готовый скрипт запуска" вас не устраивает, или вы хотите понять что конкретно делает `local_kikimr.sh`, то этот раздел для вас.
KiKiMR может быть поднят локально используя файлы в качестве хранилища.

<span style="color:red;">Важно не указывать тип диска `SSD`, если файл лежит не на SSD</span>

  1. Соберите бинарник KiKiMR или возьмите готовый из пакета `yandex-search-kikimr-kikimr-bin`. Скрипты лежат в пакете `yandex-search-kikimr-kikimr-scripts`.
### Как собрать {#how-to-assemble}
```
cd ~/arcadia/kikimr/driver/
ya make -r
```

  2. Создайте файлы, которые будут использованы в качестве дисков KiKiMR, например один размером в 80GB
```
fallocate -l 85899345920 /var/tmp/kikimr.pdisk
```
<span style="color:red;">Использовать файлы маленького размера крайне не рекомендуется, работоспособность не гарантируется</span>.
<br>Стоит создавать файлы указанного выше или больше размера.

  3. Заполните конфигурационные файлы `drives.txt` и `servers.txt`. В drives.txt указан список файлов из пункта 2. В servers для локального запуска hostname сервера, на котором он будет запущен.
```
cd ~/arcadia/kikimr/scripts/
echo "ROT /var/tmp/kikimr.pdisk" > drives.txt
cat drives.txt
hostname > servers.txt
cat servers.txt
```
  4. Запустите генерацию конфигурационных файлов KiKiMR
```
cd ~/arcadia/kikimr/scripts/
./basic_kikimr.bash cfg --localhost --cfg-dir ./local --binary ~/arcadia/kikimr/driver/kikimr --drives ./drives.txt --servers ./servers.txt --erasure none --static-erasure none
```
  5. Сделайте локальный деплой KiKiMR
```
cd ~/arcadia/kikimr/scripts/
./basic_kikimr.bash deploy --cfg-dir ./local
```
После выполнения данной команды будет запущен KiKiMR, причем:
  * для HTTP мониторинга используется порт`8765`. Поменять его можно через опцию `--mon-port` в скрипте `basic_kikimr.bash`. По URL'у `yourhostname:8765/ver` можно проверить версию сборки.
  * в вашей домашней директории будет создана папка `~/kikimr-dir`, где будет лежать бинарник KiKiMR и его конфигурационные файлы.
  * файл с данными будет находиться по пути указанном в drives.txt.
  * для доступа к KiKiMR по messagebus по умолчанию используется порт `2134`. Его можно поменять в через опцию `--port` в скрипте `basic_kikimr.bash`.

  6. Для остановки KiKiMR используйте команду
```
./basic_kikimr.bash stop --cfg-dir ./local
```
Для повторного запуска без потери данных
```
./basic_kikimr.bash start --cfg-dir ./local
```

  7. Если не указывать папку установки локального kikimr - логи и настройки будут расположены в `~/kikimr-dir/`.

  8. Обновление конфигурации локальной инсталляции аналогично работе с кластером kikimr. То есть, например, для обновления конфигурации следует использовать `./basic_kikimr.bash update`. Подробнее [тут](https://wiki.yandex-team.ru/kikimr/user/startguide/#razvertyvanieizapuskkikimr)

Help для `basic_kikimr.bash` доступен при его запуске без параметров:
```
./basic_kikimr.bash
```
