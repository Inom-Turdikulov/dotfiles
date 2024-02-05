{ options, config, pkgs, ... }:

{

  # Allows git@... clone addresses rather than gitea@...
  users.users.photoprism = {
    group = "photoprism";
    isSystemUser = true;
    extraGroups = ["users"];
  };
  users.groups.photoprism = {};
  user.extraGroups = [ "photoprism" ];

  # Photoprism
  services.photoprism = {
    enable = true;
    port = 2342;
    originalsPath = "/var/lib/private/photoprism/originals";
    address = "127.0.0.1";
    passwordFile = config.age.secrets.photoprism.path;
    settings = {
      PHOTOPRISM_ADMIN_USER = "inom";
      PHOTOPRISM_DEFAULT_LOCALE = "en";
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_SITE_URL = "http://photo.home.arpa";
      PHOTOPRISM_SITE_TITLE = "My PhotoPrism";
    };
  };

  services.nginx.virtualHosts."photo.home.arpa" = {
    http2 = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:2342";
      proxyWebsockets = true;
      # extraConfig = ''
      #   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      #   proxy_set_header Host $host;
      #   proxy_buffering off;
      # '';
    };
  };
}