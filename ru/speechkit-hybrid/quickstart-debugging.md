# Поиск и устранение ошибок при создании демонстрационного стенда

Если во время [создания демонстрационного стенда](quickstart.md) {{ sk-hybrid-name }} возникли проблемы, проведите диагностику, чтобы найти ошибки:

1. [Подключитесь к ВМ по SSH](../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Здесь `<имя_пользователя>` — имя учетной записи пользователя ВМ. Публичный IP-адрес ВМ доступен в [консоли управления]({{ link-console-main }}), на странице ВМ.

1. Проверьте, открыты ли порты `8080` и `9080` для приема клиентских запросов:

   ```bash
   telnet <публичный_адрес_ВМ> 8080 && telnet <публичный_адрес_ВМ> 9080
   ```

   В команде укажите публичный IP-адрес ВМ, которая была создана вместе с [инфраструктурой](quickstart.md#create-infrastructure). Узнайте, как [получить IP-адрес ВМ](../compute/operations/vm-info/get-info.md#outside-instance).

1. Проверьте список загруженных Docker-образов:

   ```bash
   docker images --digests
   ```

   Убедитесь, что присутствуют нужные образы. Они загружаются в реестр {{ container-registry-full-name }} после того, как вы [передали команде {{ speechkit-name }}](quickstart.md#get-started) идентификатор реестра.

   Ожидаемый результат:

   ```text
   REPOSITORY                                        TAG   DIGEST             IMAGE ID  CREATED  SIZE
   cr.yandex/crp33...7i/release/stt/v100/stt_server  0.21  sha256:83245...6b  0d1...89  ...      15.3GB
   cr.yandex/crp33...7i/release/tts/v100/tts_server  0.21  sha256:41c1f...ea  d3a...7d  ...      16.1GB
   cr.yandex/crp33...7i/release/envoy                0.21  sha256:853ed...cb  6f7...31  ...      220MB
   cr.yandex/crp33...7i/release/license_server       0.21  sha256:44d24...3d  59e...62  ...      1.23GB
   ```

   Если вы меняли теги образов, убедитесь, что во время [нагрузочного тестирования](quickstart.md#stt-and-tts) вы использовали нужный Docker-образ. Для этого в столбце `DIGEST` сравните хеш-суммы использованного вами образа и образа в полученном списке.

1. Убедитесь, что из образов {{ sk-hybrid-name }} успешно запущены Docker-контейнеры:

   ```bash
   docker ps -a
   ```

   Пример ожидаемого результата:

   ```text
   CONTAINER ID  IMAGE                                                  ...  STATUS            ...
   659...a0      cr.yandex/crp33...7i/release/stt/v100/stt_server:0.21  ...  Up About an hour  ...
   af3...1f      cr.yandex/crp33...7i/release/tts/v100/tts_server:0.21  ...  Up About an hour  ...
   e42...36      cr.yandex/crp33...7i/release/envoy:0.21                ...  Up About an hour  ...
   a4a...43      cr.yandex/crp33...7i/release/license_server:0.21       ...  Up About an hour  ...
   ```

1. Проверьте список открытых сетевых соединений и сетевую конфигурацию:

   1. Установите утилиту `netstat`:

      ```bash
      sudo apt install net-tools
      ```

   1. Убедитесь, что сервисы {{ sk-hybrid-name }} готовы обслуживать сетевые соединения на выделенных им портах. Список портов см. в файле `docker-compose.yaml`. Он хранится в файле [node-deploy.tf](https://github.com/yandex-cloud-examples/yc-speechkit-hybrid-deployment/blob/main/node-deploy.tf), в переменной `COMPOSE_V100_STT_TTS`.

      Выполните команду, чтобы получить информацию о сетевых соединениях сервисов:

      ```bash
      sudo netstat -tulpn && sudo ip addr
      ```

      Ожидаемый результат:

      ```text
      Proto  Recv-Q  Send-Q  Local Address  Foreign Address  State   PID/Program name
      tcp         0       0  0.0.0.0:8080   0.0.0.0:*        LISTEN  1582/envoy
      tcp         0       0  0.0.0.0:9080   0.0.0.0:*        LISTEN  1582/envoy
      tcp         0       0  0.0.0.0:17882  0.0.0.0:*        LISTEN  1688/asr_server
      tcp         0       0  0.0.0.0:17982  0.0.0.0:*        LISTEN  1637/tts_server
      tcp         0       0  0.0.0.0:9091   0.0.0.0:*        LISTEN  1582/envoy
      tcp6        0       0  :::8085        :::*             LISTEN  1581/java
      tcp6        0       0  :::8086        :::*             LISTEN  1581/java
      tcp6        0       0  :::8087        :::*             LISTEN  1581/java
      tcp6        0       0  :::17880       :::*             LISTEN  1688/asr_server
      tcp6        0       0  :::17980       :::*             LISTEN  1637/tts_server
      tcp6        0       0  :::9087        :::*             LISTEN  1581/java
      tcp6        0       0  :::8003        :::*             LISTEN  1581/java
      ```

1. Убедитесь, что состояние драйвера GPU в норме. Его интеграция с используемой системой контейнеризации является одним из [аппаратных требований](system-requirements.md#hardware).

   1. Узнайте версию ядра NVIDIA:

      ```bash
      cat /proc/driver/nvidia/version
      ```

      Пример ожидаемого результата:

      ```text
      NVRM version: NVIDIA UNIX x86_64 Kernel Module 470.199.02 ...
      ```

   1. Проверьте состояние драйвера GPU:

      ```bash
      sudo nvidia-smi
      ```

      Пример ожидаемого результата:

      ```text
      +-----------------------------------------------------------------------------+
      | NVIDIA-SMI 470.199.02   Driver Version: 470.199.02   CUDA Version: 11.4     |
      |-------------------------------+----------------------+----------------------+
      | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
      | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
      |===============================+======================+======================|
      |   0  Tesla V100-SXM2...  Off  | 00000000:8B:00.0 Off |                    0 |
      | N/A   33C    P0    36W / 300W |      0MiB / 32510MiB |      2%      Default |
      +-------------------------------+----------------------+----------------------+
      ```

   1. Убедитесь, что драйвер GPU был успешно интегрирован в систему контейнеризации:

      ```bash
      nvidia-container-cli info
      ```

      Пример ожидаемого результата:

      ```text
      NVRM version:   470.199.02
      CUDA version:   11.4
      Device Index:   0
      Device Minor:   0
      Model:          Tesla V100-SXM2-32GB
      Brand:          Tesla
      GPU UUID:       GPU-1af...cb
      Bus Location:   00000000:8b:00.0
      Architecture:   7.0
      ```

1. Проверьте, есть ли ошибки вида `WARNING`, `ERROR`, `EMERG` или `ALERT` в STDOUT-выводе контейнеров. Для этого выгрузите вывод в текстовые файлы. Выполните следующую команду в директории репозитория `yc-speechkit-hybrid-deployment`:

   ```bash
   mkdir -p logs ; cd ./logs
   for c in $(docker ps --format '{{.Names}}' | awk '{print $NF}'); do echo $c && docker logs $c &> $c.log; done
   ```

   Если [обращаетесь в техническую поддержку]({{ link-console-support }}), сообщите ей, какую команду вы выполнили, и отправьте полученные текстовые файлы.

1. Изучите содержимое файла `docker-compose.yaml`, с помощью которого осуществляется запуск Docker-контейнеров.

   `docker-compose.yaml` описан в файле `node-deploy.tf`, в переменной `COMPOSE_V100_STT_TTS`. Содержимое переменной автоматически выгружается в файл `docker-compose.yaml`. Он размещается и собирается на ВМ, где запускается {{ sk-hybrid-name }}.

   Во время сборки могут возникнуть ошибки. Чтобы их обработать, убедитесь, что содержимое файла `docker-compose.yaml` соответствует информации о конфигурации окружения. Эта информация была собрана по описанным выше шагам.
