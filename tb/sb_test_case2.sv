task sb_test_case2();

nb = 36;
nv = 20;
cmax = 8;
vmax = 8;

cbin = '{
	//bin 1
	'{1, 0, 0, 1, 0, 2, 0, 0},
	'{0, 1, 1, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 2
	'{1, 1, 0, 2, 0, 0, 0, 0},
	'{0, 0, 2, 0, 1, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 3
	'{0, 0, 2, 2, 1, 0, 0, 0},
	'{0, 0, 2, 0, 0, 2, 1, 0},
	'{1, 1, 0, 1, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 4
	'{2, 0, 0, 2, 0, 0, 1, 0},
	'{0, 1, 2, 0, 0, 1, 0, 0},
	'{0, 0, 0, 2, 1, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 5
	'{0, 1, 0, 0, 2, 2, 0, 0},
	'{2, 0, 1, 1, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 6
	'{0, 1, 0, 0, 1, 2, 0, 0},
	'{0, 0, 1, 0, 0, 1, 2, 0},
	'{2, 0, 1, 1, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 7
	'{0, 0, 1, 2, 1, 0, 0, 0},
	'{1, 0, 0, 0, 0, 1, 1, 0},
	'{0, 1, 0, 0, 0, 1, 1, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 8
	'{0, 2, 0, 2, 0, 1, 0, 0},
	'{1, 0, 2, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 9
	'{0, 0, 1, 1, 0, 0, 2, 0},
	'{2, 0, 0, 0, 2, 2, 0, 0},
	'{0, 2, 2, 0, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 10
	'{0, 2, 0, 1, 1, 0, 0, 0},
	'{1, 0, 1, 0, 0, 2, 0, 0},
	'{0, 1, 0, 2, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 11
	'{0, 0, 0, 2, 0, 1, 1, 0},
	'{0, 2, 0, 0, 1, 0, 1, 0},
	'{2, 2, 1, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 12
	'{0, 0, 1, 1, 1, 0, 0, 0},
	'{2, 1, 0, 0, 0, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 13
	'{0, 2, 1, 0, 0, 2, 0, 0},
	'{2, 1, 0, 0, 0, 0, 1, 0},
	'{0, 2, 0, 0, 1, 2, 0, 0},
	'{0, 0, 1, 1, 0, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 14
	'{1, 2, 0, 1, 0, 0, 0, 0},
	'{1, 0, 2, 0, 1, 0, 0, 0},
	'{1, 2, 0, 0, 0, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 15
	'{2, 1, 0, 1, 0, 0, 0, 0},
	'{0, 1, 2, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 16
	'{0, 0, 2, 1, 1, 0, 0, 0},
	'{0, 1, 0, 0, 2, 0, 1, 0},
	'{1, 0, 0, 0, 0, 2, 1, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 17
	'{0, 0, 0, 1, 1, 0, 2, 0},
	'{1, 1, 1, 0, 0, 0, 0, 0},
	'{0, 2, 0, 0, 2, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 18
	'{2, 0, 0, 2, 1, 0, 0, 0},
	'{0, 2, 1, 1, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 19
	'{1, 0, 0, 2, 0, 2, 0, 0},
	'{0, 1, 1, 0, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 20
	'{0, 2, 0, 2, 0, 0, 2, 0},
	'{0, 0, 0, 2, 1, 2, 0, 0},
	'{2, 0, 2, 2, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 21
	'{0, 1, 2, 1, 0, 0, 0, 0},
	'{2, 0, 0, 0, 2, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 22
	'{2, 1, 0, 2, 0, 0, 0, 0},
	'{0, 2, 1, 0, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 23
	'{0, 2, 0, 2, 2, 0, 0, 0},
	'{1, 0, 1, 0, 0, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 24
	'{0, 2, 0, 2, 0, 2, 0, 0},
	'{1, 0, 1, 0, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 25
	'{0, 2, 2, 0, 2, 0, 0, 0},
	'{1, 0, 0, 1, 0, 2, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 26
	'{1, 0, 0, 2, 0, 2, 0, 0},
	'{0, 1, 2, 0, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 27
	'{1, 1, 1, 0, 0, 0, 0, 0},
	'{2, 0, 0, 2, 1, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 28
	'{0, 1, 1, 0, 0, 0, 2, 0},
	'{2, 0, 0, 2, 2, 0, 0, 0},
	'{0, 0, 1, 1, 0, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 29
	'{1, 0, 2, 1, 0, 0, 0, 0},
	'{2, 1, 0, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 30
	'{1, 0, 2, 2, 0, 0, 0, 0},
	'{0, 2, 0, 0, 2, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 31
	'{0, 0, 1, 2, 0, 2, 0, 0},
	'{2, 0, 0, 1, 0, 0, 1, 0},
	'{1, 2, 0, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 32
	'{2, 1, 0, 1, 0, 0, 0, 0},
	'{2, 0, 0, 0, 1, 2, 0, 0},
	'{0, 2, 1, 0, 0, 1, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 33
	'{2, 0, 1, 0, 1, 0, 0, 0},
	'{0, 0, 1, 0, 0, 1, 2, 0},
	'{0, 1, 1, 2, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 34
	'{2, 2, 0, 2, 0, 0, 0, 0},
	'{0, 2, 1, 0, 2, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 35
	'{0, 2, 0, 0, 0, 2, 2, 0},
	'{1, 0, 2, 2, 0, 0, 0, 0},
	'{0, 1, 0, 0, 2, 0, 1, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},

	//bin 36
	'{1, 0, 0, 1, 1, 0, 0, 0},
	'{1, 1, 2, 0, 0, 0, 0, 0},
	'{2, 0, 0, 0, 0, 2, 1, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0},
	'{0, 0, 0, 0, 0, 0, 0, 0}
};

vbin = '{
	//bin 1
	2, 5, 8, 18, 19, 20, 0, 0,
	//bin 2
	2, 7, 10, 12, 15, 19, 0, 0,
	//bin 3
	2, 8, 9, 13, 15, 17, 19, 0,
	//bin 4
	1, 3, 4, 10, 13, 15, 19, 0,
	//bin 5
	4, 6, 8, 9, 12, 14, 0, 0,
	//bin 6
	1, 4, 5, 9, 16, 18, 19, 0,
	//bin 7
	1, 5, 7, 12, 14, 17, 19, 0,
	//bin 8
	10, 11, 13, 17, 18, 19, 0, 0,
	//bin 9
	5, 9, 15, 16, 17, 19, 20, 0,
	//bin 10
	2, 5, 9, 12, 15, 19, 0, 0,
	//bin 11
	4, 7, 8, 11, 16, 18, 20, 0,
	//bin 12
	3, 11, 12, 13, 14, 16, 0, 0,
	//bin 13
	1, 7, 9, 12, 15, 17, 20, 0,
	//bin 14
	7, 10, 12, 13, 14, 16, 0, 0,
	//bin 15
	4, 5, 9, 16, 20, 0, 0, 0,
	//bin 16
	5, 7, 8, 10, 12, 13, 17, 0,
	//bin 17
	4, 9, 13, 14, 15, 16, 20, 0,
	//bin 18
	3, 8, 10, 11, 18, 0, 0, 0,
	//bin 19
	1, 5, 8, 14, 15, 20, 0, 0,
	//bin 20
	1, 4, 6, 9, 11, 14, 20, 0,
	//bin 21
	1, 2, 3, 13, 16, 17, 0, 0,
	//bin 22
	3, 5, 13, 18, 19, 0, 0, 0,
	//bin 23
	6, 7, 8, 10, 14, 17, 0, 0,
	//bin 24
	2, 4, 6, 12, 15, 20, 0, 0,
	//bin 25
	5, 6, 7, 8, 10, 12, 0, 0,
	//bin 26
	2, 10, 11, 12, 16, 17, 0, 0,
	//bin 27
	1, 5, 13, 14, 18, 0, 0, 0,
	//bin 28
	1, 2, 3, 6, 11, 15, 17, 0,
	//bin 29
	5, 6, 11, 14, 17, 0, 0, 0,
	//bin 30
	9, 12, 13, 15, 18, 19, 0, 0,
	//bin 31
	2, 3, 4, 10, 12, 13, 18, 0,
	//bin 32
	4, 10, 14, 15, 18, 19, 0, 0,
	//bin 33
	2, 7, 11, 12, 15, 17, 20, 0,
	//bin 34
	11, 14, 16, 19, 20, 0, 0, 0,
	//bin 35
	3, 4, 11, 12, 14, 15, 18, 0,
	//bin 36
	1, 5, 9, 15, 16, 19, 20, 0
};
run_sb_load();

endtask

