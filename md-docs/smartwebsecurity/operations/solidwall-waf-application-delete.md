[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили SolidWall WAF > Удалить приложение SolidWall WAF

# Удалить приложение SolidWall WAF

Перед удалением приложения отключите от него все домены. Приложение с подключенными доменами удалить нельзя. При удалении приложения удаляются все данные о нем в профиле SolidWall WAF.

Чтобы удалить приложение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. Откройте профиль и нужное приложение.
  1. В строке каждого подключенного домена нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Отключить домен**.
  1. Подтвердите отключение домена. Повторите действие для всех доменов приложения.
  1. Вернитесь на страницу профиля. В строке с приложением нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В окне **Удаление приложения SolidWall WAF** подтвердите удаление приложения.

{% endlist %}

Отключение доменов от приложения сохраняет сами домены и их профили безопасности в Smart Web Security. После удаления всех приложений можно [удалить профиль](solidwall-waf-profile-delete.md).