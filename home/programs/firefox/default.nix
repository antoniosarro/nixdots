{inputs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        adaptive-tab-bar-colour
        auto-tab-discard
        clearurls
        darkreader
        multi-account-containers
        privacy-badger
        refined-github
        sidebery
        temporary-containers
        ublock-origin
      ];
      settings = {
        # General
        "intl.accept_languages" = "en-US,en";
        "browser.startup.page" = 3;
        "browser.aboutConfig.showWarning" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.download.useDownloadDir" = false;
        "browser.translations.neverTranslateLanguages" = "it";
        "devtools.chrome.enabled" = true;
        "browser.tabs.crashReporting.sendReport" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "ui.key.menuAccessKeyFocuses" = false;
        "accessibility.typeaheadfind.enablesound" = false;
        "general.autoScroll" = true;

        # Hardware acceleration
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "media.av1.enabled" = false;
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.sanitize.sanitizeOnShutdown" = false;

        "browser.send_pings" = false;

        # This allows firefox devs changing options for a small amount of users to test out stuff.
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "beacon.enabled" = false;
        "device.sensors.enabled" = false;
        "geo.enabled" = false;

        # ESNI is deprecated ECH is recommended
        "network.dns.echconfig.enabled" = true;

        # Disable telemetry for privacy reasons
        "toolkit.telemetry.archive.enabled" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.unified" = false;
        "extensions.webcompat-reporter.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.urlbar.eventTelemetry.enabled" = false;

        # Disable some useless stuff
        "extensions.pocket.enabled" = false;
        "extensions.abuseReport.enabled" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;
        "browser.contentblocking.report.lockwise.enabled" = false;
        "browser.uitour.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # disable EME encrypted media extension (Providers can get DRM
        # through this if they include a decryption black-box program)
        # "browser.eme.ui.enabled" = false;
        # "media.eme.enabled" = false;

        # don't predict network requests
        "network.predictor.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;

        # disable annoying web features
        "dom.push.enabled" = false; # no notifications, really...
        "dom.push.connection.enabled" = false;
        "dom.battery.enabled" = false; # you don't need to see my battery...
        "dom.private-attribution.submission.enabled" = false; # No PPA for me pls
      };
      search = {
        force = true;
        default = "DuckDuckGo";
        order = ["DuckDuckGo" "NixOS Options" "Nix Packages" "GitHub" "HackerNews"];

        engines = {
          "Bing".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Google".metaData.hidden = true;

          "Nix Packages" = {
            icon = "https://nixos.wiki/favicon.png";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "NixOS Options" = {
            icon = "https://nixos.wiki/favicon.png";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "GitHub" = {
            iconUpdateURL = "https://github.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];

            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Home Manager" = {
            icon = "https://nixos.wiki/favicon.png";
            definedAliases = ["@hm"];

            url = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "HackerNews" = {
            iconUpdateURL = "https://hn.algolia.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@hn"];

            url = [
              {
                template = "https://hn.algolia.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
      userChrome = ''
        #sidebar-header {
          display: none;
        }

        #main-window #titlebar {
          overflow: hidden;
          transition: height 0.3s 0.3s !important;
        }
        /* Default state: Set initial height to enable animation */
        #main-window #titlebar { height: 3em !important; }
        #main-window[uidensity="touch"] #titlebar { height: 3.35em !important; }
        #main-window[uidensity="compact"] #titlebar { height: 2.7em !important; }
        /* Hidden state: Hide native tabs strip */
        #main-window[titlepreface*="XXX"] #titlebar { height: 0 !important; }
        /* Hidden state: Fix z-index of active pinned tabs */
        #main-window[titlepreface*="XXX"] #tabbrowser-tabs { z-index: 0 !important; }
      '';
    };
  };

  #   home.file.".mozilla/firefox/default/chrome" = {
  #   source = minimal-firefox;
  #   recursive = true;
  #   force = true;
  # };
}
