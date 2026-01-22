# Instructions for Agents

## Project Status
This project is considered feature-complete and is primarily in maintenance mode.

## Environment Setup
**Crucial:** This project requires Elixir ~> 1.15. The standard system packages in some environments might install older versions (e.g., 1.14).

To set up your environment correctly, **you must run the provided setup script**:

```bash
bin/setup
```

If the script installs a local version of Elixir (because the system version is too old), it will print instructions to update your `PATH`. **You must follow these instructions** for the rest of your session to ensure you are using the correct Elixir version.

Example:
```bash
export PATH="$PWD/.local/elixir/bin:$PATH"
```

## Verification
Before submitting any changes, run the CI script to ensure all tests and checks pass:

```bash
bin/ci
```

This script runs:
- `mix test`
- `mix credo`
- `mix dialyzer`

## Dependencies
- The `gen_fst` dependency is pinned to `~> 0.4.1` as newer versions might not be available on Hex.pm. Do not update it unless you are certain.

## Troubleshooting
- **Dialyzer Errors**: If you encounter an error like `The application "dialyzer" could not be found`, it means your system Erlang installation is missing the dialyzer package. You may need to install `erlang-dialyzer` (e.g., `sudo apt-get install erlang-dialyzer`) or skip the dialyzer check if you cannot install packages.
