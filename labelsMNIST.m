function label_list = labelsMNIST(file)
	label_file=fopen(file, 'rb');
	assert(label_file ~= -1, ['Cannot open ', file, '']);
	magic=fread(label_file, 1, 'int32', 0, 'b');
	assert(magic==2049, ['Incorrect Magic number in ',file,'']);
	label_c=fread(label_file, 1, 'int32', 0, 'b');
	label_list=fread(label_file, inf, 'uchar');
	assert(size(label_list, 1) == label_c, 'Mismatch in Label Count');
	fclose(label_file);
end
