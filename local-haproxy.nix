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
      User = "haproxy";
      Group = "haproxy";
      PIDFile = "/run/haproxy.pid";
    };

    path = [ pkgs.haproxy ];
    preStart = ''
      mkdir -p /run/haproxy
      chown haproxy:haproxy /run/haproxy
    '';
  };

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

    frontend http-in
        bind *:8089
        acl host_pinger hdr(host) -i luis.apps.pinger.rocks
        use_backend pinger-backend if host_pinger

    backend pinger-backend
        server splunk pinger.splunkcloud.com:8089 check
  '';
}
