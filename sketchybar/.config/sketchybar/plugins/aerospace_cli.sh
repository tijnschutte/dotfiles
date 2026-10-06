# Sourced by the plugins that talk to AeroSpace. POSIX sh, since one caller runs under sh.
#
# The aerospace CLI has no timeout: it waits on its socket until the server answers, and
# a server busy with the very event that started this script may never answer. perl's
# alarm bounds the wait, since macOS ships no `timeout`: after 2 seconds the call dies
# with exit 142 and empty output, and the caller's empty-value branch takes over.
aero() {
  /usr/bin/perl -e 'alarm shift; exec @ARGV' 2 aerospace "$@"
}
