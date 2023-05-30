#write packets to a file
import numpy as np
import struct
import ctypes
import math
import socket
import matplotlib.pyplot as plt
from scipy.io import savemat
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

output_array = [[] for i in range(64)]
output_filename = "output10.txt"

packet_count = 0
while True:
	data, addr = sock.recvfrom(1028) # buffer size is 1024 bytes
	packet_count = packet_count+1
	# Iterate over the words and convert them back to the correct byte order
	index = struct.unpack('>I', data[:4])[0]
	print(index)
	data = data[4:]
	mag_array = []
	words = []
	for i in range(num_words):		#256
		# Extract the word from the binary data
		start_index = i * word_size_bytes
		end_index = start_index + word_size_bytes
		word_bytes = data[start_index:end_index]

		# Convert the byte order
		word = struct.unpack('<I', word_bytes)[0]  # '>' big-endian 
		words.append(word)
	im = [to_16bit_signed_integer(wd>>16) for wd in words]
	re = [to_16bit_signed_integer(wd & 0xffff) for wd in words]
	print("length of im is" + str(len(im)))
	for i in range(len(im)):
		output_array[index].append(math.sqrt((im[i])**2 + (re[i])**2))
	
	# = mag_array
	
	if (packet_count == 64):
		break
#print(output_array[0])
#print(output_array[63])	
output_array = np.array(output_array)


with open(output_filename, "w") as text_file:
	text_file.write("~~~~~~~~~PYTHON FORMAT~~~~~~~~~~\n")
	text_file.write(str(output_array))

matlab_dict = {'matlab_array':output_array}
file_path = 'output.mat'
savemat(file_path,matlab_dict)