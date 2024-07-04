// beacon = false
user_pref("beacon.enabled", false);
// about config warning = false
user_pref("browser.aboutConfig.showWarning", false); 
// strictcontent blocking
user_pref("browser.contentblocking.category", "strict");
// download dont open panel in toolbar
user_pref("browser.download.alwaysOpenPanel", false);
// downloads button
user_pref("browser.engagement.downloads-button.has-used", true);

/* safebrowsing = false
DESCRIPTION: For each downloaded file, Firefox will send a request to Google's safe browsing database,
which can be a privacy concern. Setting appRepURL to an empty string will prevent the request to be sent.
WARNING: Disabling safe browsing is a potential security risk and should only be done if the privacy aspect
is more important than the security aspect.
*/
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.malware.enabled", false);

/* Browser Search Configuration
DESCRIPTION: 
*/
user_pref("browser.search.hiddenOneOffs", "Google,Yahoo,Bing,Amazon.com,Twitter");
// browser search suggest = false
user_pref("browser.search.suggest.enabled", false);
// search bar in toolbar
user_pref("browser.search.widget.inNavBar", true);
// browser send pings = false
user_pref("browser.send_pings", false);

/* Configure startup page/behavior
Impact of browser.startup.page: (SOURCE: http://kb.mozillazine.org/Browser.startup.page#3)
    "0" = blank page ("about:blank")
    "1" = page(s) defined as home pages (default)
    "2" = load last visited page 
    "3" = resume previous session
*/
user_pref("browser.startup.page", "0"); // blank page upon startup
user_pref("browser.startup.homepage", "about:blank"); // set homepage to blank for good measure

// tabs firefox view = false
user_pref("browser.tabs.firefox-view", false);
// tabmanager = false
user_pref("browser.tabs.tabmanager.enabled", false);
// newtab = false
user_pref("browser.newtabpage.enabled", false);
// activity stream
user_pref("browser.newtabpage.activity-stream.showSeach", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
// bookmarks toolbar visibility = never
user_pref("browser.toolbars.bookmarks.visibility", "never");
// browser ui density
user_pref("browser.uidensity", "1");

/* Configuration of URL bar
*/
// urlbar speculativeconnect = false
user_pref("browser.urlbar.speculativeConnect.enabled", false);
// urlbar bookmarks = false
user_pref("browser.urlbar.shortcuts.bookmarks", false);
// urlbar history = false
user_pref("browser.urlbar.shortcuts.history", false);
// urlbar("browser.urlbar.suggest.engines", false);
// urlbar suggest history = false
user_pref("browser.urlbar.suggest.history", false);
// urlbar suggest open page = false
user_pref("browser.urlbar.suggest.openpage", false);
// urlbar suggest searches = false
user_pref("browser.urlbar.suggest.searches", false);
// urlbar suggest topsites = false
user_pref("browser.urlbar.suggest.topsites", false);

// firefox healthreport upload = false
user_pref("datareporting.healthreport.uploadEnabled", false);
// dont let sites disable copy and paste
user_pref("dom.event.clipboardevents.enabled", false);
// https mode = true
user_pref("dom.security.https_only_mode", true);
// experiments = false
user_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.supported", false);
// remove unifiedextensions
user_pref("extensions.unifiedExtensions.enabled", false);
// pocket show on home screen = false
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.showHome", false);
user_pref("extensions.pocket.onSaveRecs", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
// creditcards autofill = false
user_pref("extensions.formautofill.creditCards.available", false);
// smoothscroll = false
user_pref("general.smoothScroll", false);
// geo = false
user_pref("geo.enabled", false);
// general
user_pref("gfx.webrender.all", true);
user_pref("layout.css.devPixelsPerPx", "1");
// media autoplay = 5
user_pref("media.autoplay.default", "5");
user_pref("media.navigator.enabled", false);
user_pref("media.video_stats.enabled", false);
// show punycode in the urlbar
user_pref("network.IDN_show_punycode", true);
// network
user_pref("network.allow-experiments", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.http.referer.XOriginPolicy", "2");
user_pref("network.http.referer.XOriginTrimmingPolicy", "2");
user_pref("network.http.referer.trimmingPolicy", "1");
user_pref("network.prefetch-next", false);
// magnet links
user_pref("network.protocol-handler.expose.magnet", false);
// default shortcuts
user_pref("permissions.default.shortcuts", "2");
// privacy dont track = true
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", "1");
user_pref("privacy.firstparty.isolate", true);
user_pref("signon.rememberSignons", false);
// css stylesheets = true
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

