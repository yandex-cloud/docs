# Unlink a bank card

If your billing account's payment method is by **Bank card**, you can unlink the bank card yourself in [Yandex ID]{% if lang == "ru" %}(https://passport.yandex.ru/profile){% endif %}{% if lang == "en" %}(https://passport.yandex.com/profile){% endif %}. Then it will automatically unlink from all Yandex services, including {{ yandex-cloud }}.

If no bank card is linked to a billing account when it is debited, {{ yandex-cloud }} locks the billing account by making it `SUSPENDED`. More about [billing account statuses](../concepts/billing-account-statuses.md). After your account is locked, you will receive an email at the email address specified in your Yandex or Yandex 360 account. It will contain detailed instructions for restoring access.
