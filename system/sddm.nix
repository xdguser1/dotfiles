{
  pkgs,
  ...
}:

let
  theme = (
      pkgs.sddm-astronaut.override {
        themeConfig = {
          ### General ###
          ScreenWidth   = "1920";
          ScreenHeight  = "1080";
          ScreenPadding = "";

          Font     = "Roboto";
          FontSize = "";

          KeyboardSize = "0.4";

          RoundCorners = "20";

          Locale     = "";
          HourFormat = "HH:mm";
          DateFormat = "dddd d MMMM";

          HeaderText = "";

          ### Background ###
          BackgroundPlaceholder = "";
          Background            = "/share/images/bg-sddm.jpg";

          BackgroundSpeed = "";
          PauseBackground = "";

          DimBackground = "0.0";

          CropBackground = "";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment   = "center";

          ### Colors ###
          HeaderTextColor = "#ffffff";
          DateTextColor   = "#ffffff";
          TimeTextColor   = "#ffffff";

          FormBackgroundColor = "#21222C";
          BackgroundColor     = "#21222C";
          DimBackgroundColor  = "#21222C";

          LoginFieldBackgroundColor    = "#222222";
          PasswordFieldBackgroundColor = "#222222";
          LoginFieldTextColor          = "#ffffff";
          PasswordFieldTextColor       = "#ffffff";
          UserIconColor                = "#ffffff";
          PasswordIconColor            = "#ffffff";

          PlaceholderTextColor = "#bbbbbb";
          WarningColor         = "#343746";

          LoginButtonTextColor           = "#ffffff";
          LoginButtonBackgroundColor     = "#343746";
          SystemButtonsIconsColor        = "#F8F8F2";
          SessionButtonTextColor         = "#F8F8F2";
          VirtualKeyboardButtonTextColor = "#F8F8F2";

          DropdownTextColor               = "#ffffff";
          DropdownSelectedBackgroundColor = "#343746";
          DropdownBackgroundColor = "#21222C";

          HighlightTextColor       = "#bbbbbb";
          HighlightBackgroundColor = "#343746";
          HighlightBorderColor     = "#343746";

          HoverUserIconColor                  = "#b7cef1";
          HoverPasswordIconColor              = "#b7cef1";
          HoverSystemButtonsIconsColor        = "#b7cef1";
          HoverSessionButtonTextColor         = "#b7cef1";
          HoverVirtualKeyboardButtonTextColor = "#b7cef1";

          ### Form ###
          PartialBlur = "true";
          FullBlur    = "false";
          BlurMax     = "";
          Blur        = "";

          HaveFormBackground = "false";
          FormPosition       = "left";

          ### Virtual Keyboard ###
          VirtualKeyboardPosition = "center";

          ### Interface Behavior ###
          HideVirtualKeyboard = "false";
          HideSystemButtons   = "false";

          ForceLastUser = "true";

          PasswordFocus        = "true";
          HideCompletePassword = "true";
          AllowEmptyPassword   = "true";

          AllowUppercaseLettersInUsername = "false";
          BypassSystemButtonsChecks       = "false";
          RightToLeftLayout               = "false";

          ### Translations ###
          TranslatePlaceholderUsername      = "";
          TranslatePlaceholderPassword      = "";
          TranslateLogin                    = "";
          TranslateLoginFailedWarning       = "";
          TranslateCapslockWarning          = "";
          TranslateSuspend                  = "";
          TranslateHibernate                = "";
          TranslateReboot                   = "";
          TranslateShutdown                 = "";
          TranslateSessionSelection         = "";
          TranslateVirtualKeyboardButtonOn  = "";
          TranslateVirtualKeyboardButtonOff = "";
        };
      }
    );
in
{
  environment.systemPackages = [
    theme
  ];

  services.displayManager.sddm = {
    extraPackages = [
      pkgs.kdePackages.qtmultimedia
    ];

    autoNumlock    = true;
    theme          = "sddm-astronaut-theme";
    wayland.enable = true;
  };
}
