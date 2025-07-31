
# conda initialization removed - using uv for python management

# Standard PATH setup
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH

# Cargo (Rust) if available
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
