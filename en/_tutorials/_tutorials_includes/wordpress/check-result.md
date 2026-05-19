Make sure WordPress is working correctly:

1. In your browser, open the main website subdomain, if specified during installation. Otherwise, open the DNS zone domain. You should see the WordPress home page.
1. Create a test post:

   1. In the admin dashboard, click **Posts** → **Add New**.
   1. Provide the post title and content.
   1. Upload an image to the post. It will be automatically saved to the {{ objstorage-name }} bucket.
   1. Publish the post.

1. Make sure that the post appears on the website home page.
1. Test email notifications:

   1. In the admin dashboard, go to the settings section.
   1. Try resetting the password using **Lost your password?**.
   1. Check the mailbox you specified for the password reset email.

   {% note info %}

   Integration with {{ postbox-name }} supports user sign-ups and password resets. {{ postbox-name }} does not support bulk mailing because the feature requires a special API.

   {% endnote %}

1. Check the installed plugins:

   1. In the admin dashboard, go to **Plugins**.
   1. Make sure the following plugins are installed:
      * **S3 Uploads**: For integration with **{{ objstorage-full-name }}** to store media files.
      * **WP Mail SMTP**: For integration with **{{ postbox-full-name }}** to send email notifications.

1. Open the database admin dashboard domain in your browser:

   1. Log in to the database admin dashboard.
   1. Use these credentials:
      * **Server**: `db`.
      * **Engine**: `MySQL`.
      * **Username**: `wordpress`.
      * **Password**: Database password you specified in `db-passwords-secret`.