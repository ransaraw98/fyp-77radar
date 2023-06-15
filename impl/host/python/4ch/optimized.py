import numpy as np
import struct
import ctypes
import math
import socket
import matplotlib.pyplot as plt
from scipy.io import savemat
from concurrent.futures import ThreadPoolExecutor

UDP_IP = "192.168.1.100"  # replace with your IP address
UDP_PORT = 5001  # replace with your desired port number

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  # Internet, UDP
sock.bind((UDP_IP, UDP_PORT))


def to_16bit_signed_integer(number):
    # Create a 16-bit signed integer type
    int16 = ctypes.c_int16

    # Convert the number to a 16-bit signed integer
    signed_int = int16(number)

    # Return the converted value
    return signed_int.value


word_size_bytes = 4
packet_size = 1040  # in bytes
num_words = (packet_size // word_size_bytes) - 4

aspect_ratio = 256 / 64
extent = (0, 256, 0, 64 * aspect_ratio)
frame = 0
fig, ax = plt.subplots()


def process_packet(data):
    packet_indices = list(range(256))
    completed_indices = []

    output_array = np.empty((256, 256))

    packet_count = 0
    while True:
        packet_count += 1
        # Iterate over the words and convert them back to the correct byte order
        index = struct.unpack('>I', data[:4])[0]  # first byte contains the corresponding index in the sequence
        data = data[16:]
        words = np.frombuffer(data, dtype='<u4')  # Convert the byte order

        im = np.array([to_16bit_signed_integer(wd >> 16) for wd in words])
        re = np.array([to_16bit_signed_integer(wd & 0xffff) for wd in words])

        output_array[index, :] = np.sqrt(im ** 2 + re ** 2)

        if index not in completed_indices:
            packet_indices.remove(index)
            completed_indices.append(index)
        else:
            continue
        if len(packet_indices) == 0:
            break

    return output_array


def process_frame(frame):
    print(frame)
    output_array = np.empty((256, 256))

    with ThreadPoolExecutor() as executor:
        futures = []
        for _ in range(256):
            data, _ = sock.recvfrom(packet_size)
            futures.append(executor.submit(process_packet, data))
        for future in futures:
            output_array += future.result()

    ch0_frame = np.empty((256, 256))
    ch1_frame = np.empty((256, 256))
    ch2_frame = np.empty((256, 256))
    ch3_frame = np.empty((256, 256))

    for i in range(0, 256, 4):
        ch0_frame[i:i + 4, :] = output_array[i:i + 4, ::4]
        ch1_frame[i:i + 4, :] = output_array[i:i + 4, 1::4]
        ch2_frame[i:i + 4, :] = output_array[i:i + 4, 2::4]
        ch3_frame[i:i + 4, :] = output_array[i:i + 4, 3::4]

    ch0_frame_flipped = np.fft.fftshift(np.flip(ch0_frame, axis=1))
    log_data = np.log1p(ch0_frame_flipped)

    ax.clear()
    ax.imshow(log_data, cmap='viridis', aspect='auto', extent=extent)
    plt.gca().invert_yaxis()
    plt.pause(0.001)


while frame < 50:
    frame += 1
    process_frame(frame)

plt.close()
