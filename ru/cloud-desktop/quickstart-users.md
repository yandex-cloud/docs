---
title: Начало работы с {{ cloud-desktop-name }} для пользователей
description: Следуя данной инструкции, вы сможете получить доступ и подключиться к рабочему столу.
---

# Начало работы с {{ cloud-desktop-full-name }} для пользователей

{{ cloud-desktop-name }} позволяет работать на удаленном рабочем столе, который настроил ваш администратор.

Чтобы начать работать с сервисом:

1. [Получите данные для подключения](#get-credentials).
1. [Подключитесь к рабочему столу](#connect-desktop).
1. Ознакомьтесь с основными [действиями с рабочим столом](#operations).


## Получите данные для подключения {#get-credentials}

{% list tabs group=instructions %}

- Витрина пользовательских рабочих столов {#desktop-showcase}

  {% include [get-credentials-desktop-showcase](../_includes/cloud-desktop/get-credentials-desktop-showcase.md) %}

{% endlist %}

## Подключитесь к рабочему столу {#connect-desktop}

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}


## Действия с рабочим столом {#operations}

### Запустить, перезапустить, остановить рабочий стол {#start-stop}

{% list tabs group=instructions %}

- Витрина пользовательских рабочих столов {#desktop-showcase}

  1. Откройте [Витрину пользовательских рабочих столов]({{ link-cloud-desktop-showcase }}).
  1. В карточке нужного рабочего стола нажмите:

      * ![image](../_assets/console-icons/play.svg) — чтобы запустить рабочий стол.
      * ![image](../_assets/console-icons/arrow-rotate-right.svg) — чтобы перезапустить.
      * ![image](../_assets/console-icons/power.svg) — чтобы остановить.

  1. Подтвердите действие.

{% endlist %}


### Сбросить пароль {#password-reset}

{% list tabs group=instructions %}

- Витрина пользовательских рабочих столов {#desktop-showcase}

  {% include [password-reset-desktop-showcase](../_includes/cloud-desktop/password-reset-desktop-showcase.md) %}

{% endlist %}

## Решение проблем {#problems}

**Не удается подключиться**

* Повторно загрузите RDP-файл рабочего стола. Возможно, прежний файл больше недействителен.
* Если вы забыли пароль от рабочего стола, нажмите **Сбросить пароль**.
* Если рабочий стол не отвечает, нажмите **Перезапуск**.
* Обратитесь к вашему системному администратору.