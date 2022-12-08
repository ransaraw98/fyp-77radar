$begin 'Profile'
	$begin 'ProfileGroup'
		MajorVer=2022
		MinorVer=2
		Name='Solution Process'
		$begin 'StartInfo'
			I(1, 'Start Time', '12/07/2022 14:48:46')
			I(1, 'Host', 'RANSARA-LAPTOP')
			I(1, 'Processor', '8')
			I(1, 'OS', 'NT 10.0')
			I(1, 'Product', 'HFSS Version 2022.2.0')
		$end 'StartInfo'
		$begin 'TotalInfo'
			I(1, 'Elapsed Time', '00:01:02')
			I(1, 'ComEngine Memory', '81 M')
		$end 'TotalInfo'
		GroupOptions=8
		TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Executing from C:\\\\Program Files\\\\AnsysEM\\\\Ansys Student\\\\v222\\\\Win64\\\\HFSSCOMENGINE.exe\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Allow off core\', \'True\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC settings\', \'Auto\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Machines:\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'ransara-laptop [15.9 GB]: RAM Limit: 90.000000%, 3 cores, Free Disk Space: 111 GB\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'Solution Basis Order\', \'1\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(1, 0, \'Elapsed time : 00:00:00 , HFSS ComEngine Memory : 75.2 M\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Perform full validations with standard port validations\')', false, true)
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Initial Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '12/07/2022 14:48:46')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:06')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Mesh TAU3', 1, 0, 2, 0, 82000, 'I(1, 2, \'Tetrahedra\', 40749, false)', true, true)
			ProfileItem('Mesh Post (TAU)', 2, 0, 2, 0, 82000, 'I(1, 2, \'Tetrahedra\', 13700, false)', true, true)
			ProfileItem('Mesh Refinement', 0, 0, 0, 0, 0, 'I(1, 0, \'Lambda Based\')', false, true)
			ProfileItem('Mesh (lambda based)', 0, 0, 0, 0, 41848, 'I(1, 2, \'Tetrahedra\', 14204, false)', true, true)
			ProfileItem('Simulation Setup', 0, 0, 0, 0, 56892, 'I(2, 1, \'Disk\', \'0 Bytes\', 0, \'\')', true, true)
			ProfileItem('Port Adaptation', 0, 0, 0, 0, 65672, 'I(2, 1, \'Disk\', \'1.71 KB\', 2, \'Tetrahedra\', 8094, false)', true, true)
			ProfileItem('Mesh (port based)', 0, 0, 0, 0, 39880, 'I(1, 2, \'Tetrahedra\', 14279, false)', true, true)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Adaptive Meshing'
			$begin 'StartInfo'
				I(1, 'Time', '12/07/2022 14:48:53')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:17')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 1'
				$begin 'StartInfo'
					I(0, 'Frequency:  900MHz')
					I(1, 'Time', '12/07/2022 14:48:53')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:04')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 58412, 'I(2, 1, \'Disk\', \'2.62 KB\', 2, \'Tetrahedra\', 8155, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 126244, 'I(3, 1, \'Disk\', \'32.4 KB\', 2, \'Tetrahedra\', 8155, false, 2, \'Lumped ports\', 1, false)', true, true)
				ProfileItem('Solver DCS3', 1, 0, 2, 0, 291064, 'I(3, 1, \'Disk\', \'1.54 KB\', 2, \'Matrix size\', 60747, false, 3, \'Matrix bandwidth\', 19.8475, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 291064, 'I(2, 1, \'Disk\', \'1.13 MB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 79684, 'I(1, 0, \'Adaptive Pass 1\')', true, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 2'
				$begin 'StartInfo'
					I(0, 'Frequency:  900MHz')
					I(1, 'Time', '12/07/2022 14:48:57')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:05')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 0, 0, 44048, 'I(1, 2, \'Tetrahedra\', 16730, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 62876, 'I(2, 1, \'Disk\', \'5.37 KB\', 2, \'Tetrahedra\', 10603, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 148184, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 10603, false, 2, \'Lumped ports\', 1, false)', true, true)
				ProfileItem('Solver DCS3', 2, 0, 4, 0, 413344, 'I(3, 1, \'Disk\', \'4 Bytes\', 2, \'Matrix size\', 76259, false, 3, \'Matrix bandwidth\', 20.3537, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 413344, 'I(2, 1, \'Disk\', \'591 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 80008, 'I(1, 0, \'Adaptive Pass 2\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0936672, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Adaptive Pass 3'
				$begin 'StartInfo'
					I(0, 'Frequency:  900MHz')
					I(1, 'Time', '12/07/2022 14:49:02')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:07')
				$end 'TotalInfo'
				GroupOptions=0
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('Mesh (volume, adaptive)', 0, 0, 1, 0, 46876, 'I(1, 2, \'Tetrahedra\', 19911, false)', true, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('Simulation Setup ', 0, 0, 0, 0, 67580, 'I(2, 1, \'Disk\', \'5.37 KB\', 2, \'Tetrahedra\', 13754, false)', true, true)
				ProfileItem('Matrix Assembly', 0, 0, 1, 0, 175944, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, true)
				ProfileItem('Solver DCS3', 2, 0, 7, 0, 606624, 'I(3, 1, \'Disk\', \'3 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\')', true, true)
				ProfileItem('Field Recovery', 0, 0, 0, 0, 606624, 'I(2, 1, \'Disk\', \'737 KB\', 2, \'Excitations\', 1, false)', true, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 80404, 'I(1, 0, \'Adaptive Pass 3\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 3, \'Max Mag. Delta S\', 0.0143361, \'%.5f\')', false, true)
			$end 'ProfileGroup'
			ProfileFootnote('I(1, 0, \'Adaptive Passes converged\')', 0)
		$end 'ProfileGroup'
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Frequency Sweep'
			$begin 'StartInfo'
				I(1, 'Time', '12/07/2022 14:49:10')
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(1, 'Elapsed Time', '00:00:39')
			$end 'TotalInfo'
			GroupOptions=4
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 1, \'HPC\', \'Enabled\')', false, true)
			$begin 'ProfileGroup'
				MajorVer=2022
				MinorVer=2
				Name='Solution - Sweep'
				$begin 'StartInfo'
					I(0, 'Interpolating HFSS Frequency Sweep, Solving Distributed - up to 3 frequencies in parallel')
					I(1, 'Time', '12/07/2022 14:49:10')
				$end 'StartInfo'
				$begin 'TotalInfo'
					I(1, 'Elapsed Time', '00:00:38')
				$end 'TotalInfo'
				GroupOptions=4
				TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'From 450MHz to 1.35GHz, 401 Frequencies\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Frequency: 900MHz has already been solved\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 1.35GHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73444, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120192, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 8, 0, 7, 0, 280624, 'I(4, 1, \'Disk\', \'2 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 280624, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 450MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73320, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120856, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 8, 0, 8, 0, 279876, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 279876, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 675MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #1\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73124, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120568, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 8, 0, 8, 0, 279664, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 279664, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 1, Frequency: 1.35GHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 2, Frequency: 450MHz; Additional basis points are needed before the interpolation error can be computed.\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 3, Frequency: 900MHz; S Matrix Error =  77.786%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 4, Frequency: 675MHz; S Matrix Error =  50.235%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 1.125GHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:09')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73432, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120512, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 279744, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 279744, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 787.5MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:09')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73636, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 121276, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 279864, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 279864, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 562.5MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:09')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #2\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73548, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 121164, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 278704, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 278704, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 5, Frequency: 1.125GHz; S Matrix Error =  21.304%\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 6, Frequency: 787.5MHz; S Matrix Error =   0.078%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 7, Frequency: 562.5MHz; S Matrix Error =   0.056%; Secondary solver criterion is not converged\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 82448, 'I(1, 0, \'Frequency Group #2; Interpolating frequency sweep\')', true, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Solving with MPI (Intel MPI)\')', false, true)
				ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 506.25MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73400, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120736, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 278648, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 278648, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 1.2375GHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem(' ', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73268, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 119764, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 280032, 'I(4, 1, \'Disk\', \'1 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 280032, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				$begin 'ProfileGroup'
					MajorVer=2022
					MinorVer=2
					Name='Frequency - 618.75MHz'
					$begin 'StartInfo'
						I(0, 'ransara-laptop')
					$end 'StartInfo'
					$begin 'TotalInfo'
						I(0, 'Elapsed time : 00:00:10')
					$end 'TotalInfo'
					GroupOptions=0
					TaskDataOptions('CPU Time'=8, 'Real Time'=8)
					ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Distributed Solve Group #3\')', false, true)
					ProfileItem('Simulation Setup ', 0, 0, 0, 0, 73176, 'I(2, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false)', true, false)
					ProfileItem('Matrix Assembly', 1, 0, 1, 0, 120564, 'I(3, 1, \'Disk\', \'0 Bytes\', 2, \'Tetrahedra\', 13754, false, 2, \'Lumped ports\', 1, false)', true, false)
					ProfileItem('Solver DCS1', 7, 0, 7, 0, 277748, 'I(4, 1, \'Disk\', \'0 Bytes\', 2, \'Matrix size\', 96375, false, 3, \'Matrix bandwidth\', 20.7397, \'%5.1f\', 0, \'s-matrix only solve\')', true, false)
					ProfileItem('Field Recovery', 0, 0, 0, 0, 277748, 'I(2, 1, \'Disk\', \'3 KB\', 2, \'Excitations\', 1, false)', true, false)
				$end 'ProfileGroup'
				ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'Basis Element # 8, Frequency: 506.25MHz; Scattering matrix quantities converged; Passive within tolerance\')', false, true)
				ProfileItem('Data Transfer', 0, 0, 0, 0, 82436, 'I(1, 0, \'Frequency Group #3; Interpolating frequency sweep\')', true, true)
				ProfileFootnote('I(1, 0, \'Interpolating sweep converged and is passive\')', 0)
				ProfileFootnote('I(1, 0, \'HFSS: Distributed Interpolating sweep\')', 0)
			$end 'ProfileGroup'
		$end 'ProfileGroup'
		ProfileItem('', 0, 0, 0, 0, 0, 'I(1, 0, \'\')', false, true)
		$begin 'ProfileGroup'
			MajorVer=2022
			MinorVer=2
			Name='Simulation Summary'
			$begin 'StartInfo'
			$end 'StartInfo'
			$begin 'TotalInfo'
				I(0, ' ')
			$end 'TotalInfo'
			GroupOptions=0
			TaskDataOptions('CPU Time'=8, Memory=8, 'Real Time'=8)
			ProfileItem('Design Validation', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:00\', 1, \'Total Memory\', \'75.2 MB\')', false, true)
			ProfileItem('Initial Meshing', 0, 0, 0, 0, 0, 'I(2, 1, \'Elapsed Time\', \'00:00:06\', 1, \'Total Memory\', \'80.1 MB\')', false, true)
			ProfileItem('Adaptive Meshing', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:17\', 1, \'Average memory/process\', \'592 MB\', 1, \'Max memory/process\', \'592 MB\', 2, \'Total number of processes\', 1, false, 2, \'Total number of cores\', 3, false)', false, true)
			ProfileItem('Frequency Sweep', 0, 0, 0, 0, 0, 'I(5, 1, \'Elapsed Time\', \'00:00:39\', 1, \'Average memory/process\', \'273 MB\', 1, \'Max memory/process\', \'274 MB\', 2, \'Total number of processes\', 3, false, 2, \'Total number of cores\', 3, false)', false, true)
			ProfileFootnote('I(3, 2, \'Max solved tets\', 13754, false, 2, \'Max matrix size\', 96375, false, 1, \'Matrix bandwidth\', \'20.7\')', 0)
		$end 'ProfileGroup'
		ProfileFootnote('I(2, 1, \'Stop Time\', \'12/07/2022 14:49:49\', 1, \'Status\', \'Normal Completion\')', 0)
	$end 'ProfileGroup'
$end 'Profile'
