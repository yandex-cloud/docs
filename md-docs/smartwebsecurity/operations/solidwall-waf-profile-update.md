[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили SolidWall WAF > Изменить профиль

# Изменить профиль SolidWall WAF

В профиле можно изменить имя, описание, тариф и [полосу RPS](../concepts/solidwall-waf.md#tariffs).

До появления первого трафика тариф можно изменить сразу. После появления трафика изменение тарифа вступает в силу с первого числа следующего месяца.

Чтобы изменить профиль:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. В строке с нужным профилем нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените имя, описание, тариф или значение **Пиковая нагрузка на приложения**.
  1. Проверьте выбранные параметры и стоимость в калькуляторе.
  1. Нажмите **Сохранить**.

{% endlist %}