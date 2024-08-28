{ config, pkgs, ... }: {
  services.haproxy = {
    enable = true;
    package = pkgs.haproxy;

    config = ''
      global
          log /dev/log local0
          chroot /var/lib/haproxy
          user haproxy
          group haproxy
          daemon

      defaults
          log global
          timeout connect 5000ms
          timeout client  50000ms
          timeout server  50000ms

      frontend http-in
          bind *:8089
          default_backend servers

      backend servers
          server server1 127.0.0.1:8080 maxconn 32
    '';
  };

  # Ensure that HAProxy starts on boot
  systemd.services.haproxy.wantedBy = [ "multi-user.target" ];
}
