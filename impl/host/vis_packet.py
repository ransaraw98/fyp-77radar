import struct
import matplotlib.pyplot as plt
import numpy as np

# Open the binary file
with open("128fft_radix4.bin", "rb") as f:
    # Read the binary data
    data = f.read()
	
data = data [0:512]
# Calculate the number of samples
num_samples = 128

# Initialize arrays for magnitude and phase
magnitude = np.zeros(num_samples)
phase = np.zeros(num_samples)

# Loop through the data and extract the magnitude and phase
for i in range(num_samples):
    # Extract the 16-bit fixed-point magnitude and phase data
    fix16_14_mag, fix16_13_phase = struct.unpack("<HH", data[i*4:i*4+4])
    
    # Convert the fixed-point data to floating point
    magnitude[i] = fix16_14_mag / (2**14)
    phase[i] = fix16_13_phase / (2**13) * 2 * np.pi

# Plot the magnitude and phase
plt.subplot(2, 1, 1)
magnitude = np.fft.fftshift(magnitude)
plt.plot(magnitude)
plt.xlabel('Sample')
plt.ylabel('Magnitude')

plt.subplot(2, 1, 2)
phase = np.fft.fftshift(phase)
plt.plot(phase)
plt.xlabel('Sample')
plt.ylabel('Phase (radians)')

plt.show()