### Ошибка при работе с пакетами `docker-ce` и `containerd` на внешнем узле {#docker-containerd}

Чтобы диагностировать и исправить ошибку:

1. Посмотрите список служб, которые работают некорректно:

   ```bash
   sudo systemctl --failed
   ```

   Результат:

   ```text
   UNIT LOAD ACTIVE SUB DESCRIPTION
   docker.socket loaded failed failed Docker Socket for the API
   LOAD = Reflects whether the unit definition was properly loaded.
   ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
   SUB = The low-level unit activation state, values depend on unit type.
   1 loaded units listed.
   ```

1. Проверьте состояние `docker.socket`:

   ```bash
   sudo systemctl status docker.socket
   ```

   Результат:

   ```text
   docker.socket - Docker Socket for the API
   Loaded: loaded (/lib/systemd/system/docker.socket; disabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Tue 2024-02-10 09:53:37 UTC; 6s ago
   Triggers: ● docker.service
   Listen: /run/docker.sock (Stream)
   CPU: 1ms
   Feb 10 09:53:37 ext-node systemd[1]: Starting Docker Socket for the API...
   Feb 10 09:53:37 ext-node systemd[7052]: docker.socket: Failed to resolve group docker: No such process
   Feb 10 09:53:37 ext-node systemd[1]: docker.socket: Control process exited, code=exited, status=216/GROUP
   Feb 10 09:53:37 ext-node systemd[1]: docker.socket: Failed with result 'exit-code'.
   Feb 10 09:53:37 ext-node systemd[1]: Failed to listen on Docker Socket for the API.
   ```

1. Посмотрите ошибки в системных логах:

   ```bash
   sudo journalctl -xe
   ```

   Результат:

   ```bash
   ...
   Feb 10 09:56:40 ext-node maintainer[19298]: E: Sub-process /usr/bin/dpkg returned an error code (1)
   ...
   ```

1. Переустановите пакеты и исправьте ошибки:

   ```bash
   sudo apt install -f
   ```

1. Когда установщик спросит, что делать с файлом `config.toml`, введите `N`, чтобы оставить текущую версию файла.