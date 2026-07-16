{
  colors,
  ...
}:

{
  services.clipse = {
    enable = true;
    theme  = with colors; rec {
      useCustomTheme = true;

      TitleFore = base0D;
      TitleBack = "#24283b" ;
      TitleInfo = base03;

      NormalTitle   = base13;
      SelectedTitle = base15;
      DimmedTitle   = TitleInfo;

      NormalDesc   = base05;
      SelectedDesc = base06;
      DimmedDesc   = base04;

      StatusMsg         = "#BB9AF7";
      PinIndicatorColor = "#FF9E64";

      SelectedBorder     = "#7AA2F7";
      SelectedDescBorder = "#7DCFFF";

      FilteredMatch = "#9ECE6A";
      FilterPrompt  = "#E0AF68";
      FilterInfo    = "#C0CAF5";
      FilterText    = "#C0CAF5";
      FilterCursor  = "#F7768E";

      HelpKey  = "#7AA2F7";
      HelpDesc = "#C0CAF5";

      PageActiveDot   = "#9ECE6A";
      PageInactiveDot = "#3B4261";

      DividerDot = "#F7768E";

      PreviewedText = "#C0CAF5";
      PreviewBorder = "#BB9AF7";
    };

    settings.imageDisplay.type = "kitty";
  };
}
