FROM nixos/nix:latest

# Set up the working directory
WORKDIR /app

# Copy the Go file and Nix expression
COPY kubecon.go .
COPY default.nix .

# Build the application with Nix, ensuring minimal layers
RUN nix-build -o kubecon-result && cp -L kubecon-result/bin/kubecon /app/kubecon

# Switch to a minimal scratch image
FROM scratch

# Copy the binary from the previous build
COPY --from=0 /app/kubecon /kubecon

# Set the entrypoint to the application
ENTRYPOINT ["/kubecon"]
