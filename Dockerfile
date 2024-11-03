# Start with a Nix image with flakes enabled
FROM nixos/nix:latest

# Set up the working directory
WORKDIR /app

# Copy the Go file and flake expression
COPY kubecon.go .
COPY flake.nix .

# Build the application using the flake, ensuring minimal layers
RUN nix --extra-experimental-features "nix-command flakes" build .#kubecon -o kubecon-result && cp -L kubecon-result/bin/kubecon /app/kubecon

# Switch to a minimal scratch image
FROM scratch

# Expose port 8080 for HTTP requests
EXPOSE 8080

# Copy the binary from the previous build
COPY --from=0 /app/kubecon /kubecon

# Set the entrypoint to the application
ENTRYPOINT ["/kubecon"]
