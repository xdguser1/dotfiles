{
  ...
}:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "ca" "en-CA" "en-US" "fr" ];
    
    policies = {

      "DisableFirefoxStudies" = true;

      "Extensions" = {
        "Install"  = [
          "https://addons.mozilla.org/firefox/downloads/file/4591110/search_by_image-8.3.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4538560/languagetool-9.0.1.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4570378/privacy_badger17-2025.9.2.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4432106/clearurls-1.27.3.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4598854/ublock_origin-1.67.0.xpi"
          "https://addons.mozilla.org/firefox/downloads/file/4576912/duckduckgo_for_firefox-2025.8.25.xpi"
        ];
      };

      "ExtensionSettings" = {
        "*" = {
          "private_browsing" = true;
        };
      };

      "ExtensionUpdate" = true;

      "FirefoxHome" = {
        "Search"            = true;
        "TopSites"          = false;
        "SponsoredTopSites" = false;
        "Highlights"        = false;
        "Pocket"            = false;
        "Stories"           = false;
        "SponsoredPocket"   = false;
        "SponsoredStories"  = false;
        "Snippets"          = true;
      };

      "PrivateBrowsingModeAvailability" = 2;
      "PromptForDownloadLocation" = true;


      "RequestedLocales" = [ "en-CA" "CA" "en-US" "fr" ];

      "SanitizeOnShutdown" = true;
      "SearchBar"          = "separate";
      "SearchEngines"      = {
        "Default" = "DuckDuckGo";
      };

      "SearchSuggestEnabled" = false;
    };
  };
}
