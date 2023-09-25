---
title: "Регулярное асинхронное распознавание аудиофайлов в бакете {{ objstorage-name }}"
description: "В API асинхронного распознавания {{ speechkit-short-name }} реализована интеграция с сервисом {{ objstorage-full-name }}. С ее помощью можно настроить автоматическое распознавание аудиофайлов поддерживаемых форматов, регулярно загружаемых в бакет {{ objstorage-name }}. Облачная функция в сервисе {{ sf-full-name }} периодически проверяет наличие аудиофайлов в бакете и отправляет их в API {{ speechkit-short-name }} для распознавания. Результат и статус распознавания сохраняются в тот же бакет {{ objstorage-name }}."
---

# Регулярное асинхронное распознавание аудиофайлов в бакете {{ objstorage-name }}

{% include notitle [storage-batch-transcribation](../../_tutorials/speechkit/batch-recognition-stt.md) %}