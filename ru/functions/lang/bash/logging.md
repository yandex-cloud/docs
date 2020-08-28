# Журналирование

Сервис {{ sf-name }} автоматически захватывает поток стандартного вывода ошибок `stderr` приложения и отправляет их в централизованную систему журналирования, доступную в {{ yandex-cloud }}. Кроме журналов выполнения приложения, формируются системные записи о событиях выполнения запроса.

{% include [multiline warning](../../../_includes/functions/multiline.md) %}

{% include [router-logging](../../../_includes/functions/router-logging.md) %} 
