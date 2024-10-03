---
title: "Решение проблем в {{ video-full-name }}"
description: "В этой статье приводятся решения для возможных проблем, которые могут возникать при работе с {{ video-full-name }}."
---

# Решение проблем в {{ video-name }}

Ниже перечислены возможные проблемы при работе с {{ video-name }} и способы их решения.


## Не загружается видеоконтент {#loading-issues}

#### Вижу черный экран {#black-screen}

{% include [basic-browser-actions](../_qa/video/basic-browser-actions.md) %}


#### Вижу зеленый экран {#green-screen}

Перезагрузите браузер и устройство.

Если проблема не решилась, обновите драйверы вашей видеокарты:

{% list tabs %}

- Windows {#windows}

  {% include [update-drivers-windows](../_qa/video/update-drivers-windows.md) %}

{% endlist %}


#### Просмотр недоступен в моем браузере {#wrong-browser}

Устаревший браузер может не поддерживать технологии, которые используются для быстрой и удобной загрузки видео. Установите [последнюю версию вашего браузера]({{ link-yandex }}/soft/browsers/).


#### Доступ запрещен {#access-denied}

Видео было снято с публикации или удалено.


#### Не загружается страница {#page-doesnt-load}

Попробуйте последовательно выполнить следующие действия:

1. Проверьте, правильно ли вы указали адрес страницы.
1. Проверьте скорость интернета с помощью [Интернетометра]({{ link-yandex }}/internet/).
1. [Очистите кеш браузера]({{ link-yandex }}/support/common/browsers-settings/browsers-cache.html).
1. Отключите в браузере установленные расширения.

    {% include [disable-browser-extensions](../_qa/video/disable-browser-extensions.md) %}

## Не работает видеоплеер {#loading-issues}

#### Завис плеер {#video-doesnt-load}

{% include [basic-browser-actions](../_qa/video/basic-browser-actions.md) %}


#### Нет звука {#no-sound}

По умолчанию видео загружается без звука. Если у вас не получается увеличить громкость в видеоплеере:

* Убедитесь, что звук включен в браузере и на устройстве.
* Перезапустите браузер или устройство.


#### Нет кнопок управления видеоплеером {#buttons-dont-work}

{% cut "Отключите расширения" %}

{% include [disable-browser-extensions](../_qa/video/disable-browser-extensions.md) %}

{% endcut %}


{% cut "Обновите драйверы вашей видеокарты" %}

{% list tabs %}

- Windows {#windows}

  {% include [update-drivers-windows](../_qa/video/update-drivers-windows.md) %}

{% endlist %}

{% endcut %}


#### Отсутствуют нужные видеокодеки {#no-codecs}

{% list tabs %}

- Windows {#windows}

  В Windows версий 7, 8 и 10 с индексами N и KN нет нужных кодеков для работы видеоплеера.

  Вы можете скачать и установить их самостоятельно:

  * [Windows 7](https://support.microsoft.com/ru-ru/help/968212/description-of-the-windows-media-format-feature-pack-for-windows-7-n-a)
  * [Windows 8 и выше](https://support.microsoft.com/ru-ru/help/3145500/media-feature-pack-list-for-windows-n-editions)

- Ubuntu {#ubuntu}

  По умолчанию операционная система Ubuntu не содержит кодеков для воспроизведения видео. Чтобы установить кодеки:

  1. Выполните команду:

      ```bash
      sudo apt-get update && sudo apt-get install ubuntu-restricted-extras
      ```

  1. Введите root-пароль и нажмите **Y**.

      Дождитесь окончания установки и перезагрузите компьютер.

  1. (Опционально) Вы можете установить дополнительный пакет кодеков. Выполните команду:

      ```bash
      sudo apt-get install libavcodec-extra && sudo apt-get install chromium-codecs-ffmpeg-extra
      ```

      Затем перезагрузите компьютер.

{% endlist %}

## Плохое качество видео {#quality-issues}

По умолчанию видео воспроизводится в качестве, которое зависит от скорости интернета:

Минимальная скорость интернета | Качество видео
-- | --
7,5 Мбит/с | 1080p, FullHD
5 Мбит/с | 720p, HD
3,5 Мбит/с | 576p
2,5 Мбит/с | 480p
0,9 Мбит/с | 360p
0,37 Мбит/с | 144p

Если вы не можете изменить качество в настройках плеера, проверьте скорость интернета в [Интернетометре](https://yandex.ru/internet/).