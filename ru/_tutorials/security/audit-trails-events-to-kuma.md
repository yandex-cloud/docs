# Загрузка аудитных логов {{ at-full-name }} в SIEM KUMA

В данном руководстве вы создадите [трейл](../../audit-trails/concepts/trail.md) {{ at-short-name }}, который будет передавать аудитные логи в коллектор [KUMA](https://www.kaspersky.ru/enterprise-security/unified-monitoring-and-analysis-platform).

[Решение](https://support.kaspersky.com/help/KUMA/3.2/ru-RU/290821.htm), которое описано в руководстве, работает по следующей схеме:

1. Трейл загружает логи в [бакет](../../storage/concepts/bucket.md) {{ objstorage-full-name }} с включенным [шифрованием](../../storage/concepts/encryption.md).
1. Бакет монтируется как часть [файловой системы](https://{{ lang }}.wikipedia.org/wiki/Filesystem_in_Userspace) на сервере с установленным коллектором KUMA.
1. Коллектор KUMA получает и передает на обработку данные событий из смонтированного бакета.

Вы можете создать инфраструктуру для загрузки аудитных логов с помощью следующих инструментов: