---
title: '{{ cloud-desktop-full-name }} release notes'
description: This section contains {{ cloud-desktop-name }} release notes.
---

# {{ cloud-desktop-name }} release notes

## Q1 2025 {#q1-2025}

* Implemented adding a custom Linux image for desktop deployment. You can configure the image and install extra packages.

   For more information, see [{#T}](operations/images/create-from-compute-linux.md).

* Added ready-to-use desktop configurations for various tasks. Select a configuration to get your most optimal workspace without setting parameters for each group. If none of the configurations suits you, you can customize a single desktop to meet your needs.

   For more information, see [{#T}](operations/desktop-groups/create.md).

* Supported desktop access management with {{ iam-full-name }}. You can grant desktop group access to: 
  
   * User group in your {{ yandex-cloud }} organization.
   * Individual users of an organization.
   * Any user by sending an invitation to their email address. The user will be added to your organization and assigned a role for desktop access.
  
* Added an option to set a maximum desktop group size. Desktops in a group will be deployed as users get connected, but their number will not exceed the maximum you set.

* Added an option to set the number of _hot standby_ desktops. These desktops will be always loaded for quick user access.

* This service is now billable. For current pricing details, see [{#T}](pricing.md).