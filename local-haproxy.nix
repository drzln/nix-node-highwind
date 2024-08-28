{ config, pkgs, ... }: {
  users.groups.haproxy = {
    gid = 900;
  };

  users.users.haproxy = {
    isSystemUser = true;
    uid = 900;
    group = "haproxy";
    description = "HAProxy User";
    home = "/nope";
    shell = "/dev/null";
  };

  systemd.services.haproxy = {
    description = "HAProxy Load Balancer";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.haproxy}/bin/haproxy -f /etc/haproxy/haproxy.cfg";
      ExecReload = "${pkgs.haproxy}/bin/haproxy -c -f /etc/haproxy/haproxy.cfg && ${pkgs.haproxy}/bin/haproxy -sf $MAINPID";
      Restart = "always";
      User = "root";
      Group = "root";
      PIDFile = "/run/haproxy.pid";
    };

    path = [ pkgs.haproxy ];
  };

  # environment.etc."haproxy/haproxy.cfg".text = ''
  #   global
  #       log /dev/log local0
  #       log /dev/log local1 notice
  #       user root
  #       group root
  #
  #   defaults
  #       log global
  #       timeout connect 5000ms
  #       timeout client  50000ms
  #       timeout server  50000ms
  #
  #   frontend http-in
  #       bind *:8089
  #       default_backend servers
  #
  #   backend servers
  #       server server1 127.0.0.1:8080 maxconn 32
  # '';
  environment.etc."haproxy/haproxy.cfg".text = ''
    global
        log /var/log/haproxy.log local0
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

    defaults
        log global
        option httplog
        option dontlognull
        timeout connect 5000ms
        timeout client  50000ms
        timeout server  50000ms
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

    frontend http-in
        bind *:8089
        acl host_pinger hdr(host) -i luis.apps.pinger.rocks
        use_backend pinger-backend if host_pinger

    backend pinger-backend
        server splunk pinger.splunkcloud.com:8089 check
  '';
}
