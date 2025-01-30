---
title: История изменений в {{ certificate-manager-full-name }}
description: В разделе представлена история изменений сервиса {{ certificate-manager-name }}.
---

# История изменений в {{ certificate-manager-full-name }}

## IV квартал 2024 {#q4-2024}

Для сертификатов Let's Encrypt® добавлена возможность [просмотра статуса](operations/managed/cert-create.md#view-statuses) выпуска сертификата.

## III квартал 2024 {#q3-2024}

* В консоли управления добавлена возможность [экспортировать](operations/managed/cert-get-content.md) сертификат, цепочку сертификатов и приватный ключ, полученные в Let's Encrypt. Сертификаты сохраняются в текстовом формате в кодировке Base64.
* Добавлено событие `GetCertificateContent`, чтобы в [{{ at-name }}](../audit-trails/concepts/events-data-plane.md#certificate-manager) собирать аудитные логи по событию «Получение содержимого SSL-сертификата».