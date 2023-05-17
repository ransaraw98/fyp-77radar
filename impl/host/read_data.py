import numpy as np
import matplotlib.pyplot as plt

# Read the raw data from the .bin file
with open('128fft.bin' ,'rb') as file:
    raw_data = file.read()

# Convert the raw data to a list of 32-bit words (LSB at leftmost index)
data_lsb = np.frombuffer(raw_data, dtype='<u4')

# Reverse the bit order to MSB at leftmost index
data_msb = np.zeros_like(data_lsb)
for i in range(32):
    data_msb |= ((data_lsb >> i) & 1) << (31 - i)

# Separate the real and imaginary parts
real_parts = np.uint16(data_msb >> 16)
imaginary_parts = np.uint16(data_msb & 0xFFFF)

# Compute the magnitudes of the complex numbers
magnitudes = np.sqrt(real_parts**2 + imaginary_parts**2)

# Plot the magnitudes
plt.plot(magnitudes)
plt.xlabel('Index')
plt.ylabel('Magnitude')
plt.title('Magnitude Plot')
plt.show()
