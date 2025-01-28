---
title: Как сбросить пароль root-пользователя на сервере {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете сбросить пароль на сервере {{ baremetal-name }} с помощью загрузочного CD-образа Rescue-CD.
---

# Сбросить пароль root-пользователя на сервере

Пароль root-пользователя генерируется при [аренде](./server-lease.md) сервера {{ baremetal-name }}. Пользователь должен самостоятельно сохранить этот пароль, так как после запуска сервера посмотреть или восстановить его будет невозможно.

Если вы потеряли пароль root-пользователя сервера {{ baremetal-name }}, вы можете создать новый пароль. В зависимости от ситуации, вы можете сделать это несколькими способами.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- Если сохранился доступ к серверу по SSH-ключу

  Если у вас сохранилась возможность подключаться к серверу от имени root-пользователя с помощью SSH-ключа, указанного при аренде сервера, вы можете изменить пароль root-пользователя, не прибегая к Rescue-CD:

  1. Подключитесь к серверу по SSH:

      ```bash
      ssh root@<публичный_IP-адрес_сервера>
      ```
  1. {% include [reset-root-password](../../../_includes/baremetal/instruction-steps/reset-root-password.md) %}

- Если нет доступа к серверу

  Если у вас нет возможности подключиться к серверу с помощью SSH-ключа, указанного при аренде сервера, восстановите пароль root-пользователя при помощи загрузочного CD-образа Rescue-CD. Дальнейшие действия необходимо выполнять в [KVM-консоли](./server-kvm.md).

  Чтобы изменить пароль root-пользователя или другие настройки сервера {{ baremetal-name }}:

  1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
  1. {% include [rescue-chroot-to-server-fs2](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs2.md) %}
  1. {% include [rescue-chroot-to-server-fs3](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs3.md) %}
  1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
  1. {% include [reset-root-password](../../../_includes/baremetal/instruction-steps/reset-root-password.md) %}
  1. {% include [rescue-chroot-to-server-fs5](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs5.md) %}
  1. {% include [rescue-chroot-to-server-fs6](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs6.md) %}
  1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
  1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)