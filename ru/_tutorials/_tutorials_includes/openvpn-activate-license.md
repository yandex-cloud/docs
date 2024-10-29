{% note info %}

Если у вас до двух VPN-подключений, используйте продукт бесплатно (активация не требуется).

{% endnote %}

Чтобы активировать лицензию:

1. Создайте учетную запись на [сайте openvpn.net](https://myaccount.openvpn.com/signup).
1. Введите код подтверждения, полученный по электронной почте.
1. В окне **Where would you like to Go?** отметьте опцию **Remember my choice** и выберите продукт **Access server**.
1. В окне **Tell us more** выберите назначение: **Business use** или **Personal Use**.
1. На вкладке **Subscriptions** выберите максимальное количество подключений в поле **How many VPN connections do you need?** и нажмите кнопку **Create**.
1. На экране отобразится ваша подписка: **Subscription 1**.
1. Чтобы скопировать ключ активации, нажмите кнопку **Copy Key** в блоке **Subscription Key**.

Дождитесь перехода ВМ в статус `RUNNING` и введите ключ активации в административной панели по адресу `https://<публичный_IP-адрес_ВМ>/admin/`. 

Публичный IP-адрес ВМ можно узнать в [консоли управления]({{ link-console-main }}) в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ.