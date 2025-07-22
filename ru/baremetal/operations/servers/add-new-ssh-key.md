---
title: Добавить новый SSH-ключ пользователя
description: Следуя данной инструкции, вы сможете добавить новый SSH-ключ пользователя ОС Linux на сервере {{ baremetal-name }} с помощью загрузочного CD-образа Rescue-CD.
---

# Добавить новый SSH-ключ пользователя

Публичный [SSH-ключ](../../../glossary/ssh-keygen.md) root-пользователя задается при [аренде](./server-lease.md) сервера {{ baremetal-name }}. Чтобы подключаться к серверу по SSH, пользователь должен обладать закрытой частью SSH-ключа.

Если вы утратили закрытую часть SSH-ключа, указанного при аренде сервера, вы можете добавить в профиль root-пользователя сервера новый публичный SSH-ключ.

## Создайте новую пару SSH-ключей {#create-new-key}

Прежде чем приступать к добавлению ключа на сервер {{ baremetal-name }}, создайте на вашем локальном компьютере новую пару SSH-ключей для доступа root-пользователя на сервер по SSH:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}

## Добавьте новый ключ в профиль root-пользователя {#add-the-new-key}

В зависимости от ситуации, вы можете добавить новый SSH-ключ несколькими способами.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- Если сохранился доступ к серверу по паролю

  Если у вас сохранилась возможность подключаться к серверу от имени root-пользователя с помощью пароля, сгенерированного при аренде сервера, вы можете добавить новый публичный SSH-ключ, не прибегая к Rescue-CD:

  1. [Подключитесь](./server-kvm.md) к KVM-консоли сервера {{ baremetal-name }}.
  1. В терминале KVM-консоли аутентифицируйтесь на сервере от имени root-пользователя:

      * В строке с запросом имени пользователя введите `root` и нажмите **ENTER**:

          ```bash
          my-server login: root
          ```
      * В появившейся строке `Password:` введите пароль root-пользователя, сгенерированный при аренде сервера.
  1. {% include [reset-authorized-keys1](../../../_includes/baremetal/instruction-steps/reset-authorized-keys1.md) %}
  1. {% include [reset-authorized-keys2](../../../_includes/baremetal/instruction-steps/reset-authorized-keys2.md) %}
  1. Выйдите из профиля root-пользователя в KVM-консоли:

      ```bash
      logout
      ```
  1. {% include [reset-authorized-keys3](../../../_includes/baremetal/instruction-steps/reset-authorized-keys3.md) %}

- Если нет доступа к серверу

  Если у вас нет возможности подключиться к серверу с помощью пароля root-пользователя, сгенерированного при аренде сервера, вы можете добавить новый публичный SSH-ключ root-пользователя при помощи загрузочного CD-образа Rescue-CD. Дальнейшие действия необходимо выполнять в [KVM-консоли](./server-kvm.md).

  Чтобы добавить новый публичный SSH-ключ root-пользователя или изменить другие настройки сервера {{ baremetal-name }}:

  1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
  1. {% include [rescue-chroot-to-server-fs2](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs2.md) %}
  1. {% include [rescue-chroot-to-server-fs3](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs3.md) %}
  1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
  1. {% include [reset-authorized-keys1](../../../_includes/baremetal/instruction-steps/reset-authorized-keys1.md) %}
  1. {% include [reset-authorized-keys2](../../../_includes/baremetal/instruction-steps/reset-authorized-keys2.md) %}
  1. {% include [rescue-chroot-to-server-fs5](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs5.md) %}
  1. {% include [rescue-chroot-to-server-fs6](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs6.md) %}
  1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
  1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}
  1. {% include [reset-authorized-keys3](../../../_includes/baremetal/instruction-steps/reset-authorized-keys3.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)