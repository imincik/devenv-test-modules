{ config, pkgs, lib, ... }:

let
  cfg = config.test.gdal;
in
{
  options.test.gdal = {
    enable = lib.mkEnableOption "GDAL";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.gdal;
      defaultText = lib.literalExpression "pkgs.gdal";
      description = "The GDAL package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    env.GDAL_BIN_PATH= "${pkgs.gdal}/bin/";

    scripts.gdal-version.exec = "echo \"GDAL version is $(gdalinfo --version)\"";
    services.postgres.enable = true;
  };
}
