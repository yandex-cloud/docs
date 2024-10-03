---
title: Терминирование TLS-соединений с помощью {{ alb-full-name }} с помощью {{ TF }}
description: В этом руководстве вы настроите балансировщик {{ alb-full-name }}, чтобы он терминировал TLS-соединения с помощью сертификата из {{ certificate-manager-full-name }} и перенаправлял HTTP-запросы на HTTPS с помощью {{ TF }}.
---

# Терминирование TLS-соединений с помощью {{ TF }}

Чтобы создать инфраструктуру для [терминирования TLS-соединений](index.md) c помощью {{ TF }}:

{% include [tls-termination-terraform](../../../_tutorials/security/tls-termination-terraform.md) %}

#### См. также {#see-also}

* [{#T}](console.md)