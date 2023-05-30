import socket

UDP_IP = "192.168.1.100" # replace with your IP address
UDP_PORT = 5001 # replace with your desired port number

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(260) # buffer size is 1024 bytes
    print("Packet Start")
    try:
        print(data.decode('ascii')) # assumes received data is in UTF-8 format
    except UnicodeDecodeError:
        print(data.decode('latin-1')) # fallback to latin-1 encoding
    print("Packet End")