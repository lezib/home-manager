.PHONY: update
update :
	home-manager switch --flake .#mau -I nixos-config=.

.PHONY: clean
clean:
	nix-collect-garbage -d
