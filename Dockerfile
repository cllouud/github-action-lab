# Stage 1: Build stage (builder)
FROM golang:1.20-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 go build main.go

# Stage 2: Runtime stage
FROM alpine:latest

# Install the necessary libraries to run the binary (if any)
RUN apk --no-cache add ca-certificates

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/main .

# Expose port 8080
EXPOSE 8080

# Run the Go application
CMD ["./main"]