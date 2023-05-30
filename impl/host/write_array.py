#write packets to a file
import numpy as np
import struct
import ctypes
import math
import socket
import matplotlib.pyplot as plt

UDP_IP = "192.168.1.100" # replace with your IP address
UDP_PORT = 5001 # replace with your desired port number

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))


def to_16bit_signed_integer(number):
    # Create a 16-bit signed integer type
    int16 = ctypes.c_int16
    
    # Convert the number to a 16-bit signed integer
    signed_int = int16(number)
    
    # Return the converted value
    return signed_int.value
	

word_size_bytes = 4
packet_size = 1028	#in bytes
num_words = (packet_size//word_size_bytes) - 1
words = []
mag_array = []

t = []
fig,ax = plt.subplots()
line , = ax.plot(t,mag_array)

plt.ion()		#interactive mo

with open("Output9.txt", "w") as text_file:
	text_file.write("~~~~~~~~~~~~~~START~~~~~~~~~~~~~~~~\n")

packet_count = 0
while True:
	data, addr = sock.recvfrom(1028) # buffer size is 1024 bytes
	packet_count = packet_count+1
	# Iterate over the words and convert them back to the correct byte order
	index = struct.unpack('>I', data[:4])[0]
	data = data[4:]
	with open("Output9.txt", "a") as text_file:
		text_file.write("[")
		#text_file.write("\n")
	for i in range(num_words):
		# Extract the word from the binary data
		start_index = i * word_size_bytes
		end_index = start_index + word_size_bytes
		word_bytes = data[start_index:end_index]

		# Convert the byte order
		word = struct.unpack('<I', word_bytes)[0]  # '>' big-endian 
		words.append(word)
		# Print the word
		#print(hex(word))
		hex_string = hex(word) #[2:]
		#print(hex_string)
		if(i == 255):
			hex_string = hex_string + "],\n"
		else:
			hex_string = hex_string + ","
		with open("Output9.txt", "a") as text_file:
			text_file.write(hex_string)
		#print(hex_string.zfill(8))
	#words = words[1:]
	im = [to_16bit_signed_integer(wd>>16) for wd in words]
	re = [to_16bit_signed_integer(wd & 0xffff) for wd in words]
	
	for i in range(len(im)):
		mag_array.append(math.sqrt((im[i])**2 + (re[i])**2))
	#t.append(np.arange(0,64,1))
	#line.set_xdata(t)
	#line.set_ydata(mag_array)
	
	#plt.draw()
	#plt.pause(0.001)
	if (packet_count == 64):
		break


 