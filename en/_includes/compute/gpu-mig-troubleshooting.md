#### "Not Supported" GPU reset error {#not-supported}

You may get the following error when running `sudo nvidia-smi -r`:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: Not Supported
  GPU 00000000:8C:00.0: Not Supported
```

This error indicates an active NVLink on your GPUs. [Disable](../../compute/operations/enable-mig.md#disable-nvlink) it and try resetting them again.

#### "In use by another client" GPU reset error {#in-use}

You may get the following error when running `sudo nvidia-smi -r`:

```text
The following GPUs could not be reset:
  GPU 00000000:8B:00.0: In use by another client
  GPU 00000000:8C:00.0: In use by another client

2 devices are currently being used by one or more other processes (e.g., Fabric Manager, CUDA application, graphics application such as an X server, or a monitoring application such as another instance of nvidia-smi). Please first kill all processes using these devices and all compute applications running in the system.
```

This means your GPUs are currently in use by another process, e.g., the `nvidia_drm` module with enabled `modeset=1`, or a user process holding a lock on the device.

To fix the issue:
1. Check if `nvidia_drm` is running with `modeset=1`:

    ```bash
    cat /sys/module/nvidia_drm/parameters/modeset
    ```

    If the output returns `Y`, disable `modeset`. Do to this, create a file named `/etc/modprobe.d/nomodeset.conf` with the following contents:

    ```text
    options nvidia-drm modeset=0
    ```

1. Update `initramfs` (Initial RAM File System):

    ```bash
    sudo update-initramfs -u
    ```

1. Identify the processes holding a lock on the device:

    ```bash
    sudo ls -l /proc/*/fd/* | grep /dev/nvidia
    ```

    {% cut "Example of the command output" %}

    ```bash
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/3 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/4 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/5 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/6 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 12:01 /proc/1574/fd/7 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/13 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/17 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/18 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/19 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/20 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/24 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/25 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/27 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/28 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/29 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/3 -> /dev/nvidiactl
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/39 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/43 -> /dev/nvidia0
    lrwx------ 1 root             root             64 Jun 17 11:59 /proc/904/fd/8 -> /dev/nvidia-modeset
    ```

    {% endcut %}

1. Terminate these processes by running `sudo kill -9 <process_PID>`.
1. Try resetting your GPUs again:

    ```bash
    sudo nvidia-smi -r
    ```

{% note tip %}

If the `modeset` value reverts to `1` after a VM reboot, check that your file system has no other configurations that override this setting:

```bash
sudo grep -R "modeset=1" /etc
```

{% endnote %}

#### "Unknown Error" when running nvidia-smi commands {#unknown-error}

If `nvidia-smi` commands, such as `nvidia-smi --gpu-reset`, return an `Unknown Error`, restart `nvidia-persistenced`:

```bash
sudo systemctl restart nvidia-persistenced
```

#### "Warning: persistence mode is disabled on device" error when enabling MIG mode {#persistence-mode}

If the `nvidia-smi -mig 1` command output alerts you with `Warning: persistence mode is disabled on device ...`, start `nvidia-persistenced`:

```bash
sudo systemctl start nvidia-persistenced
```