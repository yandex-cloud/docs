# Конвертация видео в GIF на Python



Вы создадите видеоконвертер с использованием утилиты [FFmpeg](https://ffmpeg.org/) и сервиса [{{ message-queue-full-name }}](../../../message-queue/index.md). Руководство предназначено для пользователей Linux и macOS.



<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv5akc3h42joyicfo5?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=uyIMvEtr3cI).




Вы можете создать инфраструктуру для видеоконвертера с FFmpeg и {{ message-queue-full-name }} с помощью следующих инструментов:

* [Консоль управления](console.md) — используйте консоль управления {{ yandex-cloud }}, чтобы создать инфраструктуру в пошаговом режиме.
* [{{ TF }}](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }} с репозитория GitHub, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).