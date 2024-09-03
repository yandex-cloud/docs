Роль `smart-web-security.user` позволяет просматривать информацию о профилях безопасности Smart Web Security и использовать их.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security и использовать их в других сервисах Yandex Cloud;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к профилям безопасности;
* просматривать список [виртуальных хостов](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика Yandex Application Load Balancer, к которым подключен профиль безопасности;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `smart-web-security.viewer`.

Назначить роль `smart-web-security.user` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.