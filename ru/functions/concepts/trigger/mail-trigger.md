# Триггер для почты

Триггер для почты запускает [функцию](../function.md) {{ sf-name }}, когда на электронную почту приходит письмо. Адрес электронной почты генерируется сервисом автоматически во время создания триггера.

Триггеру для почты необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

## Роли, необходимые для корректной работы триггера для почты {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль `serverless.functions.invoker` на функцию, которую вызывает триггер.

## Формат сообщения от триггера для почты {#format}

После того как триггер сработает, он отправит в функцию следующее сообщение:

```
{
    "messages":
    [
        {
            "received_at": "2022-09-15 14:42:23.983842092 +0000 UTC m=+260285.403254765",
            "headers":
            [
                {
                    "name": "X-Yandex-Fwd",
                    "values":
                    [
                        "1"
                    ]
                },
                {
                    "name": "Authentication-Results",
                    "values":
                    [
                        "myt6-22bd3499f8ff.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru"
                    ]
                },
                {
                    "name": "Dkim-Signature",
                    "values":
                    [
                        "v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1663252943; bh=5mogyQPnK9aR1QY58xdFic7MyJaCt1srWO58Ujh3dA8=; h=Message-Id:Date:Subject:To:From; b=en6OA2ufXC06U3rYWymIMaETTbm2yR0ryNhNY7h0nzyiCCftzlvxOWaoA4ObXhiAE mTdrT8R1kVaHFTa3ljkD6m5fxsfklf4l0/83Es5mZw4s8Q3Rn78iJxIPN//L8y414e 1T6rDSHx2tO77/2JEq45AaiqlS4Pw6NCpD4DUn4E="
                    ]
                },
                {
                    "name": "From",
                    "values":
                    [
                        "John Doe <somebody@yandex.ru>"
                    ]
                },
                {
                    "name": "Content-Transfer-Encoding",
                    "values":
                    [
                        "7bit"
                    ]
                },
                {
                    "name": "Date",
                    "values":
                    [
                        "Thu, 15 Sep 2022 17:42:23 +0300"
                    ]
                },
                {
                    "name": "X-Mailer",
                    "values":
                    [
                        "Yamail [ http://yandex.ru ] 5.0"
                    ]
                },
                {
                    "name": "To",
                    "values":
                    [
                        "'a1serq2n5f**********-mtff****@serverless.yandexcloud.net' <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>"
                    ]
                },
                {
                    "name": "Subject",
                    "values":
                    [
                        "Example email topic for documentation"
                    ]
                },
                {
                    "name": "Message-Id",
                    "values":
                    [
                        "<55195**********@mail.yandex.ru>"
                    ]
                },
                {
                    "name": "Content-Type",
                    "values":
                    [
                        "text/html"
                    ]
                },
                {
                    "name": "Received",
                    "values":
                    [
                        "from forward501j.mail.yandex.net (forward501j.mail.yandex.net. [5.45.198.251]) by serverless.yandexcloud.net (YandexCloudFunctions) with SMTP for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 14:42:23 +0000 (UTC)",
                        "from myt6-22bd3499f8ff.qloud-c.yandex.net (myt6-22bd3499f8ff.qloud-c.yandex.net [IPv6:2a02:6b8:c12:239b:0:640:22bd:3499]) by forward501j.mail.yandex.net (Yandex) with ESMTP id C57E36231F9 for <a1serq2n5f**********-mtff****@serverless.yandexcloud.net>; Thu, 15 Sep 2022 17:42:23 +0300 (MSK)",
                        "from 2a02:6b8:c12:1584:0:640:71d5:0 (2a02:6b8:c12:1584:0:640:71d5:0 [2a02:6b8:c12:1584:0:640:71d5:0]) by myt6-22bd3499f8ff.qloud-c.yandex.net (mxback/Yandex) with HTTP id KgdCMT3fZCg1-gNfCaJm6; Thu, 15 Sep 2022 17:42:23 +0300",
                        "by 7f4cvd2xm7d2gxse.myt.yp-c.yandex.net with HTTP; Thu, 15 Sep 2022 17:42:23 +0300"
                    ]
                },
                {
                    "name": "Mime-Version",
                    "values":
                    [
                        "1.0"
                    ]
                }
            ],
            "message": "<div>This is example body for documentation</div>\r\n"
        }
    ]
}
```

## См. также {#see-also_}

* [Триггер для почты, который запускает контейнер {{ serverless-containers-name }}](../../../serverless-containers/concepts/trigger/mail-trigger.md).
