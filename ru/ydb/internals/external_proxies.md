---
sourcePath: overlay/internals/external_proxies.md
---
Доступ к KiKiMR осуществляется через внешние прокси. Внешние прокси -- это не машины, а компоненты системы. Обычно, каждая нода KiKiMR запускает все прокси, каждая из которых принимает запросы по соответствующему протоколу. На данный момент доступны следующие протоколы:
 
1. gRPC (Google RPC). Описание протокола доступно по [ссылке](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/grpc.proto). gRPC протокол доступен по порту 2135.
1. HTTP. HTTP протокол доступен по порту 8765 (subject to change).
1. Message Bus ([MsgBus](https://a.yandex-team.ru/arc/trunk/arcadia/library/cpp/messagebus)). Считается **legacy** протоколом, от него отказываются в пользу gRPC. MsgBus протокол доступен по порту 2134.