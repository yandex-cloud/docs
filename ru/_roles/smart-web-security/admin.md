Роль `smart-web-security.admin` позволяет использовать профили безопасности Smart Web Security, управлять ими и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [привязках](../../iam/concepts/access-control/index.md#access-bindings) прав доступа к профилям безопасности и изменять такие привязки;
* просматривать информацию о [профилях безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security, создавать, изменять и удалять их, а также использовать профили безопасности в других сервисах Yandex Cloud;
* просматривать список [виртуальных хостов](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика Yandex Application Load Balancer, к которым подключен профиль безопасности;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.editor`.

Назначить роль `smart-web-security.admin` может пользователь с ролью `admin` в облаке.