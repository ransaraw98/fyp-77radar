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
packet_size = 1032	#in bytes
num_words = (packet_size//word_size_bytes) - 2

#output_array = np.array([[] for i in range(128)]) #for a single channel earlier 64 rows and 64 arrays here, now its 128
output_array = np.empty((128,256))
#output_array = np.empty((128,), dtype=object)
output_filename = "output10.txt"

packet_indices = list(range(128))
completed_indices = []

packet_count = 0
while True:
	data, addr = sock.recvfrom(packet_size) # buffer size is 1024 bytes
	packet_count = packet_count+1
	# Iterate over the words and convert them back to the correct byte order
	index = struct.unpack('>I', data[:4])[0]		#first byte contains the corresponding index in the sequence
	#print(index)
	data = data[8:]
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
	#print("length of im is" + str(len(im)))
	for i in range(len(im)):
		output_array[index][i] = math.sqrt((im[i])**2 + (re[i])**2)
	
	# = mag_array
	
	#if (packet_count == 128):
	#	break
	if index not in completed_indices:
		packet_indices.remove(index)
		completed_indices.append(index)
	else:
		continue
	if len(packet_indices) == 0:
		break
		
#print(output_array[0])
#print(output_array[63])
ch0_frame = []
ch1_frame = []
np.savetxt("output_array.txt",output_array,delimiter=',')


np.savetxt("ch0_rowFh.txt",np.array(output_array[0][::2]),delimiter=',')
np.savetxt("ch0_rowSh.txt",np.array(output_array[0+1][::2]),delimiter=',')
np.savetxt("ch1_rowFh.txt",np.array(output_array[0][1::2]),delimiter=',')
np.savetxt("ch1_rowSh.txt",np.array(output_array[0+1][1::2]),delimiter=',')




for i in range(0,len(output_array),2):
	ch0_rowFh 	= 	np.array(output_array[i][::2])
	ch0_rowSh 	= 	np.array(output_array[i+1][::2])
	ch1_rowFh 	= 	np.array(output_array[i][1::2])
	ch1_rowSh 	= 	np.array(output_array[i+1][1::2])
	#ch0_row 	=	np.concatenate((ch0_rowFh, ch0_rowSh))
	#ch1_row 	=	np.concatenate((ch1_rowFh, ch1_rowSh))
	ch0_frame.append(np.concatenate((ch0_rowFh, ch0_rowSh)))
	ch1_frame.append(np.concatenate((ch1_rowFh, ch1_rowSh)))
#ch0_frame = output_array[::2]
#ch1_frame = output_array[1::2]
	
#output_array = np.array(output_array)


with open(output_filename, "w") as text_file:
	text_file.write("~~~~~~~~~PYTHON FORMAT~~~~~~~~~~\n")
	text_file.write(str(ch0_frame))

with open(output_filename, "a") as text_file:
	text_file.write("~~~~~~~~~PYTHON FORMAT~~~~~~~~~~\n")
	text_file.write(str(ch1_frame))

matlab_dict1 = {'ch0_frame':ch0_frame}
file_path = 'ch0_frame.mat'
savemat(file_path,matlab_dict1)

matlab_dict2 = {'ch1_frame':ch1_frame}
file_path = 'ch1_frame.mat'
savemat(file_path,matlab_dict2)