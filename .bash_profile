: <<'COMMENT'
/etc/profile
  The systemwide initialization file, executed for login shells
~/.bash_profile
  This file loads whenever Mac OS Terminal or its tab is open.
  The personal initialization file, executed for login shells
  e.g., when you login from another host, or login at the text
  console of a local unix machine. Similar to ~/.profile.
  Classically, ~/.profile is used by Bourne Shell.
~/.bashrc
  The individual per-interactive-shell startup file.
  The ~/.bashrc script is read every time a shell is started.
  ~/.bashrc should be as lightweight (minimal) as possible
  to reduce the overhead when starting a non-login shell.
~/.bash_logout
  The individual login shell cleanup file,
  executed when a login shell exits.
COMMENT

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
