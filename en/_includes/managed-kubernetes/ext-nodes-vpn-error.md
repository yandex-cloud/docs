### Errors when using the `docker-ce` and `containerd` packages on an external node {#docker-containerd}

To diagnose and fix this error:

1. View the list of services that are not functioning properly:

   ```bash
   sudo systemctl --failed
   ```

   Result:

   ```text
   UNIT LOAD ACTIVE SUB DESCRIPTION
   docker.socket loaded failed failed Docker Socket for the API
   LOAD = Reflects whether the unit definition was properly loaded.
   ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
   SUB = The low-level unit activation state, values depend on unit type.
   1 loaded units listed.
   ```

1. Check the `docker.socket` status:

   ```bash
   sudo systemctl status docker.socket
   ```

   Result:

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

1. Look up errors in system logs:

   ```bash
   sudo journalctl -xe
   ```

   Result:

   ```bash
   ...
   Feb 10 09:56:40 ext-node maintainer[19298]: E: Sub-process /usr/bin/dpkg returned an error code (1)
   ...
   ```

1. Reinstall the packages and fix the errors:

   ```bash
   sudo apt install -f
   ```

1. When the installer prompts you for action with the `config.toml` file, enter `N` to keep the current version of the file.