---
title: Создание L7-балансировщика с защитой от DDoS с помощью {{ TF }}
description: В этом руководстве вы развернете инфраструктуру для защиты от DDoS с помощью {{ TF }}. Для этого вы создадите облачную сеть, настроите группы безопасности {{ vpc-full-name }}, создадите группу ВМ {{ compute-full-name }}, свяжете с ней группу бэкендов, создадите HTTP-роутер и L7-балансировщик {{ alb-full-name }}.
---

{% include [alb-with-ddos-protection-terraform](../../../_tutorials/security/alb-with-ddos-protection-terraform.md) %}

#### См. также {#see-also}

* [{#T}](console.md)