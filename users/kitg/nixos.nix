{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  # programs.ssh = {
  #   extraConfig = ''
  #     AllowAgentForwarding yes
  #   '';
  # };
  #
  users.users.kitg = {
    isNormalUser = true;
    home = "/home/kitg";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    # hashedPassword = "$6$p5nPhz3G6k$6yCK0m3Oglcj4ZkUXwbjrG403LBZkfNwlhgrQAqOospGJXJZ27dI84CbIYBNsTgsoH650C1EBsbCKesSVPSpB1";
    openssh.authorizedKeys.keys = [
     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNLmfBdOKLm82znwoep8mxESf3ZCNh6KvoBzm071gBK chris.gubbin@googlemail.com"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];
}
