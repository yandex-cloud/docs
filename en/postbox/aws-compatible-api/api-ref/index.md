---
title: Amazon API methods for {{ postbox-full-name }}
description: In this tutorial, you will learn about the Amazon API methods you can use to manage {{ postbox-name }}.
---

# Amazon API methods for {{ postbox-name }}

## Sending emails {#send-email}

#|
|| **Method** | **Description** ||
|| [SendEmail](send-email.md) | Sends an email. ||
|#

## Addresses {#domains}

#|
|| **Method** | **Description** ||
|| [ListDomainIdentities](list-domain-identities.md) | Returns a list of [addresses](../../concepts/glossary.md#adress). ||
|| [GetDomainIdentity](get-domain-identity.md) | Returns information on the address. ||
|| [CreateDomainIdentity](create-domain-identity.md) | Creates an address. ||
|| [PutDomainIdentityDkimAttributes](put-domain-identity-dkim-attributes.md) | Enables/disables [DKIM signing](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail). This allows the recipient to make sure the email was indeed sent from the claimed domain. ||
|| [DeleteDomainIdentity](delete-domain-identity.md) | Deletes an address. ||
|#

## Configurations {#configuration-sets}

#|
|| **Method** | **Description** ||
|| [ListConfigurationSets](list-configuration-sets.md) | Returns a list of [configurations](../../concepts/glossary.md#configuration). ||
|| [GetConfigurationSet](get-configuration-sets.md) | Returns configuration info. ||
|| [CreateConfigurationSet](create-configuration-set.md) | Creates a configuration. ||
|| [PutDomainIdentityConfigurationSetAttributes](put-domain-identity-configuration-set-attributes.md) | Links an address and configuration. ||
|| [DeleteConfigurationSet](delete-configuration-set.md) | Deletes a configuration. ||
|| [PutConfigurationSetDeliveryOptions](put-configuration-set-delivery-options.md) | Manages delivery settings. ||
|#

## Subscriptions {#event-destinations}

#|
|| **Method** | **Description** ||
|| [GetConfigurationSetEventDestinations](get-configuration-set-event-destinations.md) | Returns information about [subscriptions](../../concepts/glossary.md#subscription) for a configuration. ||
|| [CreateConfigurationSetEventDestination](create-configuration-set-event-destinations.md) | Creates a subscription. ||
|| [UpdateConfigurationSetEventDestination](update-configuration-set-event-destination.md) | Updates a subscription. ||
|| [DeleteConfigurationSetEventDestination](delete-configuration-set-event-destination.md) | Deletes a subscription. ||
|#
