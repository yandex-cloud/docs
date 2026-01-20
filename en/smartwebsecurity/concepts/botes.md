# Managing bot traffic

Web resources process a significant portion of bot traffic. Some of these bots are legitimate and essential for the operation of various web services. Among such bots, there are [web crawlers](https://en.wikipedia.org/wiki/Web_crawler) tasked with content indexing to ensure search engines return relevant results, web page archiving bots, SEO optimization bots, etc. However, there is also a large number of malicious bots, e.g., DDoS botnets, vulnerability scanners, or bots used for fraud and data theft. To protect a web service, one has to carefully set up traffic filtering so as not to get in the way of helpful bots while minimizing the activity of malicious ones.

{{ sws-name }} offers flexible protection and bot traffic filtering tools:

* List of verified bot categories by intended use or type of activity (AcademicResearchBot, AISearchBot).
* Up-to-date lists of legitimate bots used by various services and companies (e.g., Yandex, Googlebot, or Bing).
* Specific attribute to distinguish a verified bot.
* Configurable bot score thresholds from 0 to 100 for rule customization.

You can use the above traffic conditions in [security profile](profiles.md) (basic, Smart Protection, or WAF) and [ARL profile](arl.md) rules.

To further fine-tune your security rules, check logs for traffic filtering results and bot scores.

## Verified bot categories {#bot-categories}

* `AcademicResearchBot`: Collect web data used in academic research; these bots help automate gathering information for analysis and scientific study.
* `AccessibilityBot`: Improve web content accessibility for users with special needs, e.g., bots that help read out text on websites.
* `AdvertisingAndMarketingBot`: Support advertising and marketing campaigns.
* `AggregatorBot`: Gather and distribute information, e.g., bots for aggregating articles from news websites.
* `AIAssistantBot`: AI-based assistants involved in a wide range of tasks.
* `AICrawlerBot`: Help train and improve AI models, e.g., bots that collect data for training machine learning algorithms.
* `AISearchBot`: AI-driven bots optimized for interactive search and delivering information in response to user queries.
* `ArchiverBot`: Capture and archive snapshots of web pages and other web resources.
* `FeedFetcherBot`: Fetch data from various regularly updated sources, e.g., news feeds and blogs, helping users receive up-to-date information.
* `MonitoringAndAnalyticsBot`: Collect website analytics. These bots monitor website metrics, e.g., traffic, load speed, or error rates, to provide analytical data to improve site performance.
* `PagePreviewBot`: Generate page previews for links shared by users in messenger apps or social media.
* `SearchEngineCrawlerBot`: Scan the internet and index pages for search engines. They help systems, such as Yandex, update their databases and deliver up-to-date search results.
* `SearchOptimizationBot`: Help optimize websites and improve their visibility in search engines by analyzing pages for errors and suggesting changes to page content and structure.
* `SecurityBot`: Check websites for vulnerabilities and various security threats.
* `SocialMediaMarketingBot`: Help manage brand presence on social platforms by automating posting, moderation, and replies to users as well as collecting analytics for SMM campaigns and assessing their performance.
* `WebhooksBot`: Automate processes using real-time technologies that enable web applications to interact with each other.
* `OthersBot`: Other categories of verified bots.

## List of legitimate bots {#legitimate-bots}

Below is a list of bots used by various businesses for content indexing, delivering information in response to user queries, SEO, and AI model training. The list is updated regularly. You can use this list to configure traffic conditions tailored to your particular service or application.

{% cut "Legitimate bots from trusted services and companies" %}

1. `YandexBot`: Yandex's primary indexing bot.
1. `YandexAccessibilityBot`: Checks website accessibility and performance.
1. `YandexAdNetBot`: Advertising bot.
1. `YandexBlogs`: Indexes blog posts for Yandex Search.
1. `YandexMirrorDetectorBot`: Detects website mirrors.
1. `YandexCalendar`: Downloads calendar files in response to user queries. These files are often located in directories excluded from indexing.
1. `YandexDirect`: Fetches content info from partner websites in the Yandex Advertising Network to define website categories and select relevant ads.
1. `YandexFavicons`: Downloads website icons (`favicon.ico`) to display them in search results.
1. `YaDirectFetcher`: Yandex bot that fetches ad pages to check their availability and update a category.
1. `YandexForDomain`: Verifies domain ownership.
1. `YandexImages`: Indexes images for Yandex Search.
1. `YandexImageResizer`: Gathers and processes website images for display across devices and formats.
1. `YandexMobileBot`: Identifies pages optimized for mobile devices.
1. `YandexMarket`: Yandex Market bot for retrieving up-to-date product information from online stores.
1. `YandexMedia`: Indexes multimedia data for Yandex Search.
1. `YandexMetrika`: Loads website pages, including Yandex Direct ads, to check their availability.
1. `YandexMobileScreenShotBot`: Captures screenshots of web pages for mobile devices.
1. `YandexNews`: Aggregates news.
1. `YandexOntoDB`: Generates response cards in Yandex Search.
1. `YandexPagechecker`: Accesses a page when microdata validation is initiated via the structured data testing tool.
1. `YandexPartner`: Retrieves content info from Yandex partner sites.
1. `YandexRCA`: Gathers data for generating page previews.
1. `YandexRenderResourcesBot`: Loads resources for JavaScript page rendering.
1. `YandexSearchShop`: Downloads product catalog YML files in response to user queries. These files are often located in directories restricted for indexing.
1. `YandexSitelinks`: Verifies availability of pages used as sitelinks.
1. `YandexSpravBot`: Yandex Business bot.
1. `YandexTracker`: Yandex Tracker bot.
1. `YandexUserproxy`: Manages user-initiated actions across Yandex services, e.g., sends requests in response to button clicks or loads pages for online translation.
1. `YandexVertis`: Search bot for Yandex Verticals.
1. `YandexVerticals`: Bot for classifieds platforms: Auto.ru, Yandex Realty, Yandex Jobs, and Yandex Reviews.
1. `YandexVideo`: Indexes videos for display in search results.
1. `YandexWebmaster`: Yandex Webmaster SEO bot.
1. `YandexScreenshotBot`: Bot for fast and easy webpage screenshots.
1. `YandexAdditionalBot`: Generates quick responses with YandexGPT.
1. `YandexComBot`: Indexes content for Yandex search in languages other than Russian.
1. `ZenBot`: Yandex Zen bot for aggregating news from customer portals.
1. `MailruBot`: Mail.ru bot.
1. `Googlebot`: Google bot for website indexing.
1. `StorebotGoogle`: Google bot for indexing online stores.
1. `GoogleInspectionTool`: Google bot used in website testing tools.
1. `GoogleOther`: Google general-purpose bot used by various product teams for fetching publicly accessible content from sites.
1. `GoogleCloudVertexBot`: Google bot used by website owners to build Vertex AI agents.
1. `GoogleExtended`: Google bot for AI-powered search.
1. `APIsGoogle`: Sends push notifications via Google APIs.
1. `AdsBotGoogle`: Google bot that checks web page ad quality.
1. `MediapartnersGoogle`: Google bot that scans AdSense participating websites to provide them with relevant ads.
1. `GoogleSafety`: Google bot that handles abuse-specific crawling, such as malware discovery for publicly posted links in Google products.
1. `FeedFetcherGoogle`: Scans RSS or Atom feeds for Google News and PubSubHubbub.
1. `GoogleProducer`: Fetches and processes feeds explicitly provided by publishers for Google News landing pages.
1. `GoogleReadAloud`: Retrieves and reads web pages using text-to-speech upon user request.
1. `GoogleSiteVerification`: Retrieves Search Console verification tokens to confirm site ownership in Google.
1. `Bingbot`: Indexes web content for Microsoft.
1. `AdIdxBot`: Bing Ads search bot that crawls ads and follows the websites from those ads for quality control.
1. `BingPreview`: Generates page previews in Bing.
1. `MicrosoftPreview`: Generates page previews for Microsoft services.
1. `Amazonbot`: Amazon search bot used to improve service quality, e.g., helping Alexa to provide more accurate answers to customer questions.
1. `Applebot`: Collects data for tools integrated into user experiences in Appleʼs ecosystem (Spotlight, Siri, Safari), e.g., the search technology.
1. `FacebookExternalHit`: Collects, caches, and displays website or app metadata, including its title, description, and icon (thumbnail image).
1. `MetaExternalAgent`: Crawls web content to train AI models and improve products through direct indexing.
1. `Meta‑ExternalFetcher`: Enables Meta AI to provide users with up-to-date information beyond its training data.
1. `Pinterestbot`: Crawls publicly accessible websites to index content and drive traffic, checks that pin data, e.g., its price and title, is up-to-date, and removes broken links.
1. `Qwantbot`: Indexes web content for Qwant.
1. `CCBot`: Archives web pages for `commoncrawl.org`.
1. `YahooSlurpBot`: Yahoo's primary indexing bot.
1. `YahooLinkPreviewBot`: Generates page previews for Yahoo.
1. `YahooMailProxyBot`: Generates link previews in Yahoo Mail messages.
1. `YahooAdMonitoring`: Fetches content from URLs specified in Yahoo ad services; uses target page content to improve ad relevance and user experience.
1. `Pingdom`: Performs automated website testing and monitoring.
1. `SEMrushBot`: SEO crawler by SEMrush.
1. `OdklBot`: Bot by the Odnoklassniki social media platform.
1. `vkShareBot`: Implements the _Share_ widget on web pages: clicking the widget automatically creates a post in the VK social media platform with a link to the site.
1. `Twitterbot`: Generates page previews in X.
1. `TelegramBot`: Generates page previews in Telegram.
1. `SeznamBot`: Indexes web content for Seznam.
1. `WebArchiveBot`: Archives web pages for `archive.org`.
1. `DuckDuckBot`: Indexes web content for DuckDuckGo.
1. `PetalBot`: Indexes web content for Huawei's Petal Search.
1. `AhrefsBot`: Indexes web content for the Yep search engine.
1. `AhrefsSiteAudit`: SEO bot for the Ahrefs Site Audit tool.
1. `DataForSEOBot`: SEO bot for DataForSEO.
1. `SeekportBot`: Indexes web content for the Seekport search engine.
1. `Serpstatbot`: SEO bot for Serpstat.
1. `GPTBot`: Bot for training ChatGPT models.
1. `ChatGPTUser`: Visits web pages specified by a ChatGPT user.
1. `OAISearchBot`: Powers smart search in ChatGPT.
1. `Synthetics`: Performs automated website testing and monitoring.
1. `UptimeRobot`: Performs automated testing and monitoring.
1. `BLEXBot`: SEO bot for SE Ranking.
1. `BaiduSpider`: Indexes web content for the Chinese Baidu search engine.
1. `Stripe`: Automates interactions with the Stripe payment platform.
1. `ClaudeBot`: Bot for training Claude models.
1. `Claude‑User`: Enables Claude AI to access websites via the Claude-User agent when processing user queries.
1. `Claude‑SearchBot`: Analyzes online content to improve the relevance and accuracy of user queries.
1. `PerplexityBot`: Bot for training Perplexity models.
1. `Perplexity‑User`: Visits web pages specified by a Perplexity user.
1. `QcBot`: Bot for QUIC.cloud web services which require data to be fetched from and returned to your website. For example, the bot retrieves images from your site for optimization and notifies your site when the updated images are ready to be pulled.
1. `AudistoBot`: SEO and website monitoring bot.
1. `CoccocBot`: Primary indexing for the CốC CốC search engine.
1. `IASCrawlerBot`: Digital ad analysis and verification bot.
1. `IbouBot`: Ibou's primary indexing bot.
1. `JobswithgptcomBot`: Aggregates job postings for `jobswithgpt.com`.
1. `MonsidoBot`: Monitors your website's status using Monsido.
1. `PaqleBot`: Paqle's primary indexing bot.
1. `QuantcastBot`: Analyzes ads displayed on websites.
1. `SvnBot`: Monitors site availability.
1. `TestomatoBot`: Monitors site availability.
1. `PingAdminBot`: Monitors site availability.
1. `Meta‑WebIndexerBot`: Crawls web resources to improve the quality of Meta AI search results for users.
1. `Meta‑ExternalAdsBot`: Crawls web content for use cases such as improving advertising and other business-related products and services.


{% endcut %}

## Bot score {#configuration}

To configure custom rules for your traffic, you can define filtering rules based on bot score.

{{ sws-name }} assigns traffic a score from `0` (lowest probability, i.e., human) to `100` (highest probability, i.e., bot).

The following threshold ranges are used in decision-making: 

* `up to 20`: Human
* `20–40`: Likely human
* `40–60`: Undetermined
* `60–80`: Likely bot
* `over 80`: Bot

In request filtering conditions, specify threshold values using the `>=`, `<=`, `=`, or `!=` operators and the `AND` logical operator.

For example, `=10`, `>=20 AND <=40`.

For final tuning, apply the rule in `only logging` mode and analyze logs to determine the optimal threshold.
