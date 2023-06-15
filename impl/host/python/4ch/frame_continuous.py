#write packets to a file
import numpy as np
import struct
import ctypes
import math
import socket
import matplotlib.pyplot as plt
from scipy.io import savemat
import time
#import matlab.engine

#eng = matlab.engine.start_matlab()
fs = 1.0667e7
sweepTime = 6e-06
bw = 1.0667e7
c =3e8
fc = 77e9
wavelength = c/fc
d = wavelength/2				#space between antenna elements
sweepSlope = bw/sweepTime
indices = np.arange(-32,32,1)
freq_binSize = 1.0667e7/63
d_max = fs*c/(2*sweepSlope)
delta_d = d_max / 63
freq_axis_range = indices*freq_binSize
rangeAxis = freq_axis_range*c/(2*sweepSlope)
#rangeAxis = np.arange(-d_max/2,(d_max/2)+delta_d,delta_d)

PRF = 1/(2*sweepTime)
v_max = 2*PRF * wavelength/4
#v_max = 63.8889*2
print(v_max)
print(v_max)
delta_V = v_max /255
indices = np.arange(-128,128,1)
#speedAxis = np.arange(-v_max/2,(v_max/2)+delta_V,delta_V)
speedAxis = (indices * delta_V)

xticks = np.arange(0,256,16)
xtick_labels = ["{:.2f}".format(label) for label in speedAxis[::16]]

yticks = np.arange(0,65,4)*4
yticks = yticks[1:]
ytick_labels =np.flip(np.array(["{:.2f}".format(label) for label in rangeAxis[::4]]))

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
packet_size = 1040	#in bytes
num_words = (packet_size//word_size_bytes) - 4

aspect_ratio = 256/64
extent = (0, 256, 0, 64 * aspect_ratio)
frame = 0
fig ,ax = plt.subplots()
fig2 ,ax2 = plt.subplots()

prev_time = time.time()
#current_scene = 0
while(frame < 1000):
	frame = frame + 1
	#print(frame)
	#output_array = np.array([[] for i in range(128)]) #for a single channel earlier 64 rows and 64 arrays here, now its 128
	#output_array = np.empty((256,256))
	output_array = np.empty((256,256),dtype= complex)
	#output_array = np.empty((128,), dtype=object)
	#output_filename = "output10.txt"

	packet_indices = list(range(256))
	completed_indices = []

	packet_count = 0
	while True:
		data, addr = sock.recvfrom(packet_size) # buffer size is 1024 bytes
		packet_count = packet_count+1
		# Iterate over the words and convert them back to the correct byte order
		index = struct.unpack('>I', data[:4])[0]		#first byte contains the corresponding index in the sequence
		#scene = struct.unpack('>I', data[4:8])[0]
		
		#if(scene != current_scene):
		#	continue
		#print(scene)	
		data = data[16:]
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
		#words = np.frombuffer(data,dtype='<u4')
		im = np.array([to_16bit_signed_integer(wd>>16) for wd in words])
		re = np.array([to_16bit_signed_integer(wd & 0xffff) for wd in words])
		#print("length of im is" + str(len(im)))
		#for i in range(len(im)):
		#	output_array[index][i] = math.sqrt((im[i])**2 + (re[i])**2)
		#output_array[index, :]	=	np.sqrt(im**2 + re**2)
		output_array[index, :]	=	re +1j*im
		# = mag_array
		
		#if (packet_count == 128):
		#	break
		if index not in completed_indices:
			packet_indices.remove(index)
			completed_indices.append(index)
		else:
			continue
		if len(packet_indices) == 0:
			#if(current_scene == 0):
			#	current_scene = 1
			#else:
			#	current_scene = 0
			break
			
	#print(output_array[0])
	#print(output_array[63])
	ch0_frame = []
	ch1_frame = []
	ch2_frame = []
	ch3_frame = []




	for i in range(0,len(output_array),4):
		ch0_rowP1 	= 	np.array(output_array[i][::4])
		ch0_rowP2 	= 	np.array(output_array[i+1][::4])
		ch0_rowP3 	= 	np.array(output_array[i+2][::4])
		ch0_rowP4 	= 	np.array(output_array[i+3][::4])
		
		ch1_rowP1 	= 	np.array(output_array[i][1::4])
		ch1_rowP2 	= 	np.array(output_array[i+1][1::4])
		ch1_rowP3 	= 	np.array(output_array[i+2][1::4])
		ch1_rowP4 	= 	np.array(output_array[i+3][1::4])
		
		ch2_rowP1 	= 	np.array(output_array[i][2::4])
		ch2_rowP2 	= 	np.array(output_array[i+1][2::4])
		ch2_rowP3 	= 	np.array(output_array[i+2][2::4])
		ch2_rowP4 	= 	np.array(output_array[i+3][2::4])
		
		ch3_rowP1 	= 	np.array(output_array[i][3::4])
		ch3_rowP2 	= 	np.array(output_array[i+1][3::4])
		ch3_rowP3 	= 	np.array(output_array[i+2][3::4])
		ch3_rowP4 	= 	np.array(output_array[i+3][3::4])
		#ch0_row 	=	np.concatenate((ch0_rowFh, ch0_rowSh))
		#ch1_row 	=	np.concatenate((ch1_rowFh, ch1_rowSh))
		
		ch0_frame.append(np.concatenate((ch0_rowP1, ch0_rowP2,ch0_rowP3,ch0_rowP4)))
		ch1_frame.append(np.concatenate((ch1_rowP1, ch1_rowP2,ch1_rowP3,ch1_rowP4)))
		ch2_frame.append(np.concatenate((ch2_rowP1, ch2_rowP2,ch2_rowP3,ch2_rowP4)))
		ch3_frame.append(np.concatenate((ch3_rowP1, ch3_rowP2,ch3_rowP3,ch3_rowP4)))
		
	#ch0_frame = output_array[::2]
	#ch1_frame = output_array[1::2]
		
		
	############### ANGLE ESTIMATION STARTS	##########################
	
	#output_array = np.array(output_array)
	cube = np.stack((ch0_frame,ch1_frame,ch2_frame,ch3_frame))
	cubeShifted = np.fft.fftshift(np.flip(cube,axis=2))
	savemat('output.mat',{'radarCube':cube})
	mag_cube = (np.abs(cubeShifted)).astype(int)
	#cosum_image = np.sum(mag_cube,0)
	cosum_image = np.sum(mag_cube,0)
	max_sum = np.amax(np.abs(cosum_image))
	#cosum_image = np.fft.fftshift(np.flip(cosum_image,axis=1))		#fftshift the data
	#cosum_log = np.log1p(cosum_image)
	thresholded_image = np.where(cosum_image > (max_sum * 0.07),1,0)
	#print(np.shape(thresholded_image))
	objR,objC 	=	np.where(thresholded_image == 1)
	#print(np.size(objC))
	subarray = np.empty((np.shape(cubeShifted)[0],np.size(objC)),dtype=complex)
	for k in range(np.size(objC)):
		subarray[:,k]   = cubeShifted[:,objR[k],objC[k]]
	#print("subarray")
	#print(subarray[:,0])
	#print("cube")
	#print(cube[:,objR[0],objC[0]])
	fftObjs = np.fft.fftshift(np.fft.fft(subarray,n= 64,axis=0))
	angleAxis = np.rad2deg(np.arcsin(np.linspace(-0.5*wavelength/d,+0.5*wavelength/d,64)))
	max_locs = np.argmax(np.abs(fftObjs),axis=0)
	AoAs = angleAxis[max_locs]
	
	
	#print(AoAs)
	#print("fft")
	#print(fftObjs[:,0])
	#print("subarray")
	#print(np.shape(subarray))
	
	ax2.clear()
	ax2.set_title("Resolved angles in degrees", fontweight='bold', fontsize=16)
	ax2.set_xlabel("Speed $ms^{-1}$",fontweight = 'bold' , fontsize=16)
	ax2.set_ylabel("Range $m$",fontweight = 'bold' , fontsize=16)
	ax2.set_xticks(xticks)
	ax2.set_xticklabels(xtick_labels)
	ax2.set_yticks(yticks)
	ax2.set_yticklabels(ytick_labels)
	ax2.imshow(thresholded_image,cmap ='viridis',aspect = 'auto',extent=extent)
	ax2.scatter(objC,((63-objR)*aspect_ratio), c= AoAs,edgecolor='white')
	for i in range(len(AoAs)):
		ax2.text(objC[i], ((63-objR)*aspect_ratio)[i], f"{AoAs[i]:.2f}", color='white', ha='center', va='center')


	#.colorbar()
	#plt.gca().invert_yaxis()
	plt.pause(0.0001)
	
	



	ch0_frame_flipped = np.fft.fftshift(np.flip(ch0_frame,axis=1))
	log_data = np.log1p(np.abs(ch0_frame_flipped))
	ax.clear()
	ax.set_title("Range-Doppler response, hardware generated", fontweight='bold', fontsize=16)
	ax.set_xlabel("Speed $ms^{-1}$",fontweight = 'bold' , fontsize=16)
	ax.set_ylabel("Range $m$",fontweight = 'bold' , fontsize=16)
	ax.set_xticks(xticks)
	ax.set_xticklabels(xtick_labels)
	ax.set_yticks(yticks)
	ax.set_yticklabels(ytick_labels)
	ax.imshow(log_data,cmap ='viridis',aspect = 'auto',extent=extent)
	#ax.gca().invert_yaxis()
	plt.pause(0.0001)
	current_time = time.time()
	time_elapsed = current_time - prev_time
	print("fps = {} ".format(1/time_elapsed))
	prev_time = current_time

plt.close()
