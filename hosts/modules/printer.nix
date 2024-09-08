{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [
      pkgs.epson-escpr
    ];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_XP-302_303_305_306";
        location = "Stampante";
        deviceUri = "socket://10.10.40.16:9100";
        model = "Epson XP-302 303 305 306 Series, Epson Inkjet Printer Driver (ESC/P-R) for Linux";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Epson_XP-302_303_305_306";
  };
}
