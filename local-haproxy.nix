{ config, pkgs, ... }: {
  # systemd.services.haproxy = {
  #   description = "HAProxy Load Balancer";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #
  #   serviceConfig = {
  #     ExecStart = "${pkgs.haproxy}/bin/haproxy -f /etc/haproxy/haproxy.cfg";
  #     ExecReload = "${pkgs.haproxy}/bin/haproxy -c -f /etc/haproxy/haproxy.cfg && ${pkgs.haproxy}/bin/haproxy -sf $MAINPID";
  #     Restart = "always";
  #     User = "haproxy";
  #     Group = "haproxy";
  #     PIDFile = "/run/haproxy.pid";
  #   };
  #
  #   path = [ pkgs.haproxy ];
  #
  #   # Optionally, create the /run/haproxy directory
  #   preStart = ''
  #     mkdir -p /run/haproxy
  #     chown haproxy:haproxy /run/haproxy
  #   '';
  # };

  environment.etc."haproxy/haproxy.cfg".text = ''
    global
        log /dev/log local0
        log /dev/log local1 notice
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
}
