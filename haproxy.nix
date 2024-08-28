{ config, pkgs, ... }: {
  services.haproxy = {
    enable = true;
    # package = pkgs.haproxy;

    # config = ''
    #   global
    #       log /dev/log local0
    #       log /dev/log local1 notice
    #       chroot /var/lib/haproxy
    #       stats socket /run/haproxy/admin.sock mode 660 level admin
    #       stats timeout 30s
    #       user haproxy
    #       group haproxy
    #       daemon
    #
    #   defaults
    #       log global
    #       option httplog
    #       option dontlognull
    #       timeout connect 5000ms
    #       timeout client  50000ms
    #       timeout server  50000ms
    #       errorfile 400 /etc/haproxy/errors/400.http
    #       errorfile 403 /etc/haproxy/errors/403.http
    #       errorfile 408 /etc/haproxy/errors/408.http
    #       errorfile 500 /etc/haproxy/errors/500.http
    #       errorfile 502 /etc/haproxy/errors/502.http
    #       errorfile 503 /etc/haproxy/errors/503.http
    #       errorfile 504 /etc/haproxy/errors/504.http
    #
    #   frontend http-in
    #       bind *:8089
    #       acl host_pinger hdr(host) -i luis.apps.pinger.rocks
    #       use_backend pinger-backend if host_pinger
    #
    #   backend pinger-backend
    #       server splunk pinger.splunkcloud.com:8089 check
    # '';
  };

  # Ensure that HAProxy starts on boot
  systemd.services.haproxy.wantedBy = [ "multi-user.target" ];
}
