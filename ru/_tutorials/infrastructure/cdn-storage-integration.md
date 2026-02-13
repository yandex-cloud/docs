# Интеграция L7-балансировщика с {{ cdn-short-name }} и {{ objstorage-short-name }}


В этом руководстве в качестве [бэкенда](../../application-load-balancer/concepts/backend-group.md#types) L7-балансировщика {{ alb-full-name }} используется [бакет](../../storage/concepts/bucket.md) {{ objstorage-full-name }}. Запросы пользователей передаются [балансировщику](../../application-load-balancer/concepts/application-load-balancer.md) через [сеть распространения контента](../../cdn/concepts/points-of-presence.md) {{ cdn-full-name }}, чтобы сократить время доставки контента.

Вы можете создать инфраструктуру для интеграции L7-балансировщика с {{ cdn-name }} и {{ objstorage-name }} с помощью одного из инструментов:
