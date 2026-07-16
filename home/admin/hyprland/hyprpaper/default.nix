{
  ...
}:

{
  services.hyprpaper = {
    enable   = true;
    settings = {
      preload = [
	"/share/images/bg-desktop.jpg"
      ];
      wallpaper = [
        {
	  monitor = "";
          path = "/share/images/bg-desktop.jpg";
      	}
      ];
    };
  };
}
