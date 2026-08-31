---
title: Possible common errors when using {{ org-full-name }}
description: In this article, you will learn about possible common errors when using federations and organizations.
---

# Common errors

## Federation not found {#federation-not-found}

Federation with the requested ID not found. Check the specified ID or contact your federation administrator.

To get the federation ID:

{% include [get-federation-id](../_includes/organization/get-federation-id.md) %}

If you have any issues, please contact [support]({{ link-console-support }}).

## Internal application error {#internal-server-error}

Unexpected application error. Contact [support]({{ link-console-support }}).

## Organization contains clouds {#organization-contains-clouds}

Full error message:

`Organization '**********' contains clouds, please delete them all. Example **********`

This error occurs when attempting to delete an organization that contains clouds.

Delete the [clouds](../resource-manager/operations/cloud/delete.md) first, then [delete the organization](operations/delete-org.md).

## User has no permissions to use an application {#no-assignments}

Full error message:

`User has no assignments to use the application. Please contact your administrator to assign access to this application.`

This error occurs when a user attempts to use an application they have no access to. Contact your organization administrator to request access to the application.

## See also {#see-also}

* [Diagnosing errors in SAML 2.0 federations](saml-diagnostics.md)
