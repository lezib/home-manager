# Configuration file of tmux and its plugins
{ lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisableTelemetry = true;
        ExtensionSettings = with builtins;
          let extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
          in listToAttrs [
              (extension "ublock-origin" "uBlock0@raymondhill.net")
              (extension "clockify-time-tracker" "{1262fc44-5ec9-4088-a7a7-4cd42f3f548d}")
              (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
              (extension "proton-vpn-firefox-extension" "vpn@proton.ch") #
              (extension "youtube-addon" "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}") #
              (extension "betterttv" "firefox@betterttv.net") #
              (extension "youtube-anti-translate" "{458160b9-32eb-4f4c-87d1-89ad3bdeb9dc}") #
              (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org") #
            ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # for the unique id of the extentions, install it, type abouts:support in firefox then search for extension, there is a list of all extensions.
      };
    };
  };
}
