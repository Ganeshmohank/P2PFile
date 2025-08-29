# P2PFile  

**P2PFile** is a distributed, peer-to-peer Content Addressable Storage (CAS) framework developed in Go. It is designed to provide a dependable, scalable, and secure approach to sharing and storing files across multiple nodes without relying on a central server.  

## Table of Contents  

- [Features](#features)  
- [System Design](#system-design)  
- [Quick Start](#quick-start)  
  - [Requirements](#requirements)  
  - [Setup](#setup)  
  - [How to Use](#how-to-use) 

---

## Features  

- **Content Addressable Storage (CAS):** Files are stored and retrieved by their content hash, guaranteeing integrity and removing duplicates.  
- **Peer-to-Peer Network:** Data is distributed and fetched directly between peers with no single point of failure.  
- **Horizontal Scaling:** Add more nodes to expand capacity and increase fault tolerance.  
- **Built-in Encryption:** Secures files in transit and at rest using AES.  
- **Transport Flexibility:** Currently uses TCP but can be extended to other protocols.  
- **Efficient Encoding:** Utilizes GOB encoding for fast, compact data serialization.  

---

## System Design  

P2PFile is composed of three main building blocks:  

1. **FileServer** – Orchestrates file operations and manages communication between peers.  
2. **Store** – Responsible for local file storage, with customizable directory and naming logic.  
3. **TCPTransport** – Handles peer-to-peer connections and message exchange.  

---

## Quick Start  

### Requirements  

- Go version **1.15+**  

### Setup  

1. Clone the repository:  
   ```bash
   git clone https://github.com/Ganeshmohank/P2PFile
   cd P2PFile
   ```  

2. Install dependencies and build:  
   ```bash
   go mod tidy
   make build
   ```  

---

## How to Use  

P2PFile includes a Makefile for compiling, running, and testing.  

### Build & Run  

```bash
make run
```  

This compiles the project and starts the application.  

### Run Tests  

```bash
make test
```  

Executes all package tests.  

---

### Default Demo Setup  

By default, `main.go` launches three servers:  

- **Server 1** → `:3000`  
- **Server 2** → `:7000`  
- **Server 3** → `:5000` (bootstraps connections to Server 1 and Server 2)  

The demo flow:  
1. Store 20 files (`picture_0.png` … `picture_19.png`) on Server 3.  
2. Immediately delete them from Server 3’s local store.  
3. Retrieve the same files from the network.  
4. Print their contents to confirm recovery from peers.  

This shows that once a file is placed in the network, it can be accessed even if removed from the originating node.  

---

### Creating Your Own Network  

To spin up custom nodes, edit `main.go` and call:  

```go
server := makeServer(listenAddr, bootstrapNodes...)
```  

- `listenAddr` → the port/address the server listens on (e.g., `":4000"`)  
- `bootstrapNodes` → addresses of peers to connect to (optional for the first node)  

Start a node with:  
```go
go server.Start()
```  

---

### File Operations  

- **Store a file:**  
  ```go
  data := bytes.NewReader([]byte("file contents"))
  server.Store("myFile.txt", data)
  ```  

- **Retrieve a file:**  
  ```go
  r, err := server.Get("myFile.txt")
  if err != nil {
    log.Fatal(err)
  }
  contents, _ := io.ReadAll(r)
  fmt.Println(string(contents))
  ```  

---
