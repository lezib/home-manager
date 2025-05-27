.PHONY: update
update :
	home-manager switch --flake .#mau -I nixos-config=./configuration.nix

.PHONY: clean
clean:
	nix-collect-garbage -d

.PHONY: debug
debug :
	home-manager switch --flake .#mau -I nixos-config=./configuration.nix --show-trace
