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

    # preStart = ''
    #   mkdir -p /run/haproxy
    #   chown haproxy:haproxy /run/haproxy
    # '';
  };

  environment.etc."haproxy/haproxy.cfg".text = ''
    global
        log /dev/log local0
        log /dev/log local1 notice
        user root
        group root
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
