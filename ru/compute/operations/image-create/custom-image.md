# Подготовить свой образ диска

Вы можете использовать собственный файл с образом диска виртуальной машины под управлением ОС из семейства Linux. После подготовки образа [загрузите его](upload.md) в {{ compute-name }}.

Если вы подготовили программное обеспечение, которое может быть полезно другим, [предложите](../../../marketplace/operations/create-product.md) его в {{ marketplace-name }}.

## Настройте ОС в соответствии с требованиями {#requirements}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

### Установите virtio-драйверы {#virtio}

Чтобы образ соответствовал требованию о virtio-драйверах:

1. Проверьте, входят ли драйверы в конфигурацию ядра:
       
   ```sh
   grep -i virtio /boot/config-$(uname -r)
   ```
          
   Если на экране не появились строки, начинающиеся на `CONFIG_VIRTIO_BLK=` и `CONFIG_VIRTIO_NET=`, нужно заново скомпилировать ядро Linux с virtio-драйверами. В противном случае переходите к следующим шагам. 

1. Если на шаге 1 на экране появились строки `CONFIG_VIRTIO_BLK=y` и `CONFIG_VIRTIO_NET=y`, проверьте, что драйверы входят в состав ядра:
  
   ```sh
   grep -E "virtio.*" /lib/modules/"$(uname -r)"/modules.builtin
   ```
     
   * Если на экране появились строки с файлами `virtio_net.ko` и `virtio_blk.ko`, драйверы входят в состав ядра, устанавливать их не нужно.
   * Если на экране не появились такие строки, нужно заново скомпилировать ядро Linux с virtio-драйверами.
     
1. Если на шаге 1 на экране появились строки `CONFIG_VIRTIO_BLK=m` и `CONFIG_VIRTIO_NET=m`, проверьте, что драйверы установлены в качестве модулей ядра:
  
   {% list tabs %}
   
   - CentOS 6, 7
   
     Выполните следующую команду:
   
     ```sh
     sudo lsinitrd /boot/initramfs-$(uname -r).img | grep virtio
     ```
     
     * Если на экране появились строки с файлами `virtio_net.ko.xz` и `virtio_blk.ko.xz`, драйверы установлены в качестве модулей ядра.
     * Если на экране не появились такие строки, создайте резервную копию файла `initramfs` и установите драйверы:
  
       ```sh
       sudo cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
       sudo mkinitrd -f --with=virtio_blk --with=virtio_net /boot/initramfs-$(uname -r).img $(uname -r)
       ```
   
       После этого перезапустите ОС и проверьте, что драйверы появились в файле `initramfs` и загрузились:
       
       ```sh
       sudo lsinitrd /boot/initramfs-$(uname -r).img | grep virtio
       find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "virtio.*"
       ```
       
       После каждой из команд на экране должны появиться строки с файлами `virtio_net.ko.xz` и `virtio_blk.ko.xz`.
       
   - Debian, Ubuntu
   
     Выполните следующую команду:
   
     ```sh
     lsinitramfs /boot/initrd.img-$(uname -r) | grep virtio
     ```
     * Если на экране появились строки с файлами `virtio_net.ko` и `virtio_blk.ko`, драйверы установлены в качестве модулей ядра.
     * Если на экране не появились такие строки, установите драйверы:
  
       ```sh
       echo -e "virtio_net\nvirtio_blk" >> /etc/initramfs-tools/modules
       update-initramfs -u
       ```
   
       После этого перезапустите ОС и проверьте, что драйверы появились в файле `initrd` и загрузились:
       
       ```sh
       lsinitramfs /boot/initrd.img-$(uname -r) | grep virtio
       find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "virtio.*"
       ```
       
       После каждой из команд на экране должны появиться строки с файлами `virtio_net.ko` и `virtio_blk.ko`.
  
   {% endlist %}

### Настройте серийную консоль {#serial-console}

Серийная консоль — это способ получить доступ к ВМ вне зависимости от состояния сети или ОС. Используйте серийную консоль, например, для устранения неисправностей ВМ или при возникновении проблем с доступом через SSH. Подробнее см. в разделе [{#T}](../serial-console/index.md).

Чтобы к ВМ можно было подключаться с помощью серийной консоли, настройте для образа терминал `ttyS0` (порт COM1) в качестве системной консоли:

1. В файле с настройками GRUB `/etc/default/grub` добавьте в значение параметра `GRUB_CMDLINE_LINUX` опцию `console=ttyS0`. Строка с этим параметром должна иметь такой вид:
        
   ```sh
   GRUB_CMDLINE_LINUX="foo=bar baz console=ttyS0"
   ```
       
1. Убедитесь, что в файле `/etc/securetty` с перечислением терминалов, через которые пользователь `root` может войти в систему, есть строка `ttyS0`. Если файла не существует, создайте его.

   {% note info %}
  
   В некоторых ОС файл `/etc/securetty` не используется, и пользователю `root` по умолчанию разрешен доступ ко всем терминалам. Если вы хотите настраивать доступ с помощью этого файла, нужно добавить в файл `/etc/pam.d/login` указание на модуль `pam_securetty.so`. Подробнее см. `man pam_securetty` и `man pam.d`.
  
   {% endnote %} 
  
1. Выполните следующие команды:
   
   {% list tabs %}
   
   - CentOS 6, 7
     
     ```sh
     sudo stty -F /dev/ttyS0 9600                 # Устанавливает рекомендуемую скорость терминала ttyS0 — 9600 бод 
     sudo grub2-mkconfig -o /boot/grub2/grub.cfg  # Генерирует конфигурационный файл для GRUB
     sudo systemctl start getty@ttyS0             # Запускает getty на терминале ttyS0
     sudo systemctl enable getty@ttyS0            # Указывает, что getty нужно запускать при каждом включении ОС
     ```
   
   - Debian, Ubuntu
        
        ```sh
        sudo stty -F /dev/ttyS0 9600        # Устанавливает рекомендуемую скорость терминала ttyS0 — 9600 бод 
        sudo update-grub                    # Генерирует конфигурационный файл для GRUB
        sudo systemctl start getty@ttyS0    # Запускает getty на терминале ttyS0
        sudo systemctl enable getty@ttyS0   # Указывает, что getty нужно запускать при каждом включении ОС
        ```
 
   {% endlist %}
   
1. Перезапустите ОС.

После [создания ВМ из образа](upload.md#create-vm-from-user-image) ее нужно будет дополнительно [настроить для работы с серийной консолью](../serial-console/index.md). 

## Установите драйверы для совместимости с GPU {#gpu-drivers}

Чтобы образ был совместим с [GPU](../../concepts/gpus.md), при подготовке файла [установите драйверы NVIDIA](../vm-operate/install-nvidia-drivers.md).

## Создайте файл с образом {#create-image-file}

Поддерживаемые форматы: Qcow2, VMDK и VHD.

Рекомендуется использовать формат Qcow2 с оптимизированным размером кластера, чтобы ускорить импорт. Сконвертировать образ из других форматов можно с помощью утилиты `qemu-img`:
                                                                
```
qemu-img convert -p -O qcow2 -o cluster_size=2M <имя вашего файла образа> <имя нового файла образа>
```

{% note info %}

Не используйте программы для сжатия или архивирования при подготовке файла с образом.

{% endnote %}