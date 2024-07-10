Роль `gitlab.admin` позволяет управлять инстансами Managed Service for GitLab и переносить их в другую зону доступности.

Пользователи с этой ролью могут:
* просматривать информацию об [инстансах](../../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab, а также создавать, изменять и удалять инстансы;
* переносить инстансы в другую [зону доступности](../../overview/concepts/geo-scope.md);
* просматривать информацию о [квотах](../../managed-gitlab/concepts/limits.md#quotas) сервиса Managed Service for GitLab.

Включает разрешения, предоставляемые ролью `gitlab.editor`.

Для создания инстансов Managed Service for GitLab дополнительно необходима роль `vpc.user`.
