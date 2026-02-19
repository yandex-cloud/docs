Роль `smart-web-security.admin` позволяет использовать ресурсы сервиса Smart Web Security и управлять ими.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security, создавать, изменять и удалять их, а также подключать профили безопасности к защищаемым ресурсам;
* просматривать список [ресурсов](../../smartwebsecurity/operations/host-connect.md), к которым подключен профиль безопасности;
* просматривать информацию о [профилях WAF](../../smartwebsecurity/concepts/waf.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [профилях ARL](../../smartwebsecurity/concepts/arl.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [прокси-серверах](../../smartwebsecurity/concepts/domain-protect.md#proxy), а также создавать, изменять и удалять их;
* просматривать информацию о [списках](../../smartwebsecurity/concepts/lists.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию о [шаблонах страниц ответов](../../smartwebsecurity/concepts/response-templates.md), а также создавать, изменять, использовать и удалять их;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.editor`.

Чтобы включать или отключать [логирование](../../smartwebsecurity/concepts/logging.md) в профиле безопасности, дополнительно необходима роль `logging.writer` или выше на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Назначить роль `smart-web-security.admin` может пользователь с ролью `admin` в облаке.