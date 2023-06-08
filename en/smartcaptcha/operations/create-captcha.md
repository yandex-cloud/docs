# Creating a CAPTCHA

{{ captcha-name }} lets you create a CAPTCHA of multiple levels of complexity. You can:

* Connect a CAPTCHA to multiple websites.
* Set up the appearance of the **I'm not a robot** button and the task window.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ captcha-full-name }}**.
   1. Click **Create CAPTCHA** and specify:
      * **Name**: Name of a new CAPTCHA.
      * **Complexity**: Complexity of a task for the user:
         * `Easy`: Simple task.
         * `Medium`: Task of intermediate complexity.
         * `Hard`: Difficult task.

         You can see a sample task in the preview window.
      * **Site list**: As IP addresses or domain names. Do not use `http`, `htpps`, or `/` at the end. The correct format is `example.com`. Domain names also apply to subdomains with no wildcard character (`*`).
      * **Configuration type**: Appearance of the **I'm not a robot** button and the task window:
         * `Standard`: Default appearance.
         * `Personalized`: Customizable appearance. You can specify the parameters using the form or a text description of styles.

         All changes are displayed in the preview window.
   1. Click **Create**.

   The CAPTCHA appears on the service page under **Captcha list**.

{% endlist %}
