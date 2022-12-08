function speeds = doppler2speed(lambda, sweeptime, frequencies)
% lambda    |   sweeptime   |   frequencies
speeds = (lambda*frequencies)/(2*sweeptime);