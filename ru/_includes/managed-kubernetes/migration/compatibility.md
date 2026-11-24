### Оцените совместимость {#compatibility-assessment}

Чтобы компоненты кластера корректно работали после миграции, предварительно оцените их совместимость с целевым кластером. Составьте список изменений, которые нужно внести в манифесты, а также план замены несовместимых компонентов исходного кластера на аналогичные в {{ yandex-cloud }}.

Объем изменений зависит от разницы версий {{ k8s }} в исходном и целевом кластерах. Чем больше разница, тем больше изменений потребуется — могут отличаться как вендор-специфичные CRD, так и стандартные API-группы {{ k8s }}. Поддерживаемые версии смотрите в разделе [Поддержка версий {{ k8s }}](../../../managed-kubernetes/concepts/k8s-supported-versions.md).

{% note tip %}

API-ресурсы можно сравнить командой `kubectl api-resources` на исходном и целевом кластерах, а также использовать утилиту для проверки совместимости манифестов [kube-no-trouble (kubent)](https://github.com/doitintl/kube-no-trouble).

{% endnote %}

При оценке особенно обратите внимание на следующие моменты:

* Проверьте наличие вендор-специфичных CRD исходного кластера, которые могут быть недоступны в {{ yandex-cloud }}. Замените компоненты [сервисами {{ yandex-cloud }}]({{ link-cloud-services }}) или [решениями из {{ marketplace-full-name }}](../../../managed-kubernetes/operations/applications/marketplace.md).
* Если вы используете PodSecurityPolicy в исходном кластере, [мигрируйте на PodSecurity Admission](https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp). PodSecurityPolicy удалены в {{ k8s }} версий 1.25 и выше.
* В манифестах замените классы хранилищ (`storageClassName`) на те, [которые поддерживаются в {{ managed-k8s-name }}](../../../managed-kubernetes/operations/volumes/manage-storage-class.md).
* Для L7-балансировки используйте [контроллер Gwin](../../../managed-kubernetes/alb-ref/gwin-index.md).
