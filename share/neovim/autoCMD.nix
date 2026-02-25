{...}:
{
  programs.nixvim = {
    # Auto commands to run on specific events
    autoCmd = [
      {
        # autoformat on save for C files
        command = "silent ! clang-format -i %";
        event = [ "BufWritePost" ]; # On write
        pattern = [ "*.c" "*.h" "*.cc" "*.hh" "*.hxx" "*.hpp" "*.cpp"];  # for C and Cpp files
      }
      {
        # reset indentation for Lua and Nix files
        command = "set tabstop=2 | set shiftwidth=2";
        event = [ "BufEnter" ]; # On buffer enter
        pattern = [ "*.lua" "*.nix" ];
      }
      {
        # reset indentation for C and Python files
        command = "set tabstop=4 | set shiftwidth=4";
        event = [ "BufEnter" ];
        pattern = [ "*.[hc]" "*.cc" "*.hh" "*.hxx" "*.py" ];
      }
    ];
  };
}
