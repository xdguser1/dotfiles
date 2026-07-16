{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bmon
    dnsutils
    iftop
    librespeed-cli
    mtr
    nmap
    openvpn
    socat
    sshfs
    tcpdump
    unixtools.netstat
    wget
    wirelesstools
  ];
}
