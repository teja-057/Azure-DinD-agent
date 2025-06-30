# How Certificate Verification Issues Were Bypassed in Dockerfile

- The Docker GPG key was downloaded using `curl --insecure` to skip SSL certificate verification during the key import.

- The Docker repository was added with the `trusted=yes` flag, instructing `apt` to trust the repository without verifying its GPG signature.

- A custom `apt` configuration file was created to disable SSL certificate verification globally for HTTPS connections (`Acquire::https::Verify-Peer` and `Acquire::https::Verify-Host` set to `false`).

These steps bypass all SSL and GPG verification errors, allowing Docker packages to install successfully in a test environment.

> **Note:** These bypasses disable important security checks and should never be used in production.
