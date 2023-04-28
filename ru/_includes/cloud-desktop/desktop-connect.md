{% list tabs %}

- Windows

  1. Запустите загруженный RDP-файл и нажмите кнопку **Подключить**.
  1. Введите пароль, сохраненный ранее.
  1. Измените пароль пользователя, установленный по умолчанию.

- macOS

  1. Установите и запустите [Microsoft Remote Desktop](https://itunes.apple.com/ru/app/microsoft-remote-desktop/id1295203466) — бесплатный официальный RDP-клиент для macOS.
  1. Запустите загруженный RDP-файл и нажмите кнопку **Continue**.
  1. Введите пароль, сохраненный ранее.
  1. Измените пароль пользователя, установленный по умолчанию.

  #### См. также {#mac-see-also}

  * [Начало работы с удаленным рабочим столом в macOS]({{ ms.docs }}/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

- Linux

  1. Установите [Remmina](https://remmina.org) — бесплатный RDP-клиент для Linux, в терминале выполните команды:

      ```bash
      sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
      sudo apt-get update
      sudo apt-get install remmina remmina-plugin-rdp
      ```

  1. Запустите загруженный RDP-файл.
  1. Введите пароль, сохраненный ранее.
  1. Измените пароль пользователя, установленный по умолчанию.

  #### См. также {#lin-see-also}

  * [Установка Remmina на дистрибутивы Linux, отличные от Ubuntu](https://remmina.org/how-to-install-remmina/)

{% endlist %}
