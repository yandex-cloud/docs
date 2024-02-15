---
title: "List of resources that you can assign roles for in {{ iam-full-name }}"
description: "In this tutorial, you will learn for which {{ yandex-cloud }} resources you can assign roles."
---

# List of resources that you can assign roles for

Resources for which you can [assign](../../operations/roles/grant.md), [review](../../operations/roles/get-assigned-roles.md), and [revoke](../../operations/roles/revoke.md) roles:

**{{ resmgr-name }}**
* [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud)
* [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder)

**{{ iam-name }}**
* [Service account](../users/service-accounts.md)

**{{ certificate-manager-name }}**
* [Certificate](../../../certificate-manager/concepts/index.md)

**{{ container-registry-name }}**
* [Registry](../../../container-registry/concepts/registry.md)
* [Repository](../../../container-registry/concepts/repository.md)

**{{ compute-name }}**
* [VM instance](../../../compute/concepts/vm.md)


**{{ sf-name }}**
* [Function](../../../functions/concepts/function.md)


If you need to grant access to a resource that is not on the list, e.g., a [{{ mpg-full-name }} cluster](../../../managed-postgresql/concepts/index.md), assign the role to the parent resource it [inherits](index.md#inheritance) permissions from. {{ mpg-name }} clusters inherit access permissions from their folder.
