Роль `smart-web-security.user` позволяет просматривать информацию о ресурсах сервиса Smart Web Security, а также подключать профили безопасности к защищаемым ресурсам.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security и подключать их к защищаемым ресурсам;
* просматривать список [ресурсов](../../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../../smartwebsecurity/concepts/waf.md);
* просматривать информацию о [профилях ARL](../../smartwebsecurity/concepts/arl.md);
* просматривать информацию о [прокси-серверах](../../smartwebsecurity/concepts/domain-protect.md#proxy);
* просматривать информацию о [списках](../../smartwebsecurity/concepts/lists.md);
* просматривать информацию о [шаблонах страниц ответов](../../smartwebsecurity/concepts/response-templates.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.viewer`.

Назначить роль `smart-web-security.user` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.