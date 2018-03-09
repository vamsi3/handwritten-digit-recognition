function image_list = imagesMNIST(file)
	image_file = fopen(file, 'rb');
	assert(image_file ~= -1, ['Cannot open ', file, '']);
	magic = fread(image_file, 1, 'int32', 0, 'ieee-be');
	assert(magic == 2051, ['Incorrect Magic number in ', file, '']);
	image_list_c = fread(image_file, 1, 'int32', 0, 'ieee-be');
	Rows_c = fread(image_file, 1, 'int32', 0, 'ieee-be');
	Cols_c = fread(image_file, 1, 'int32', 0, 'ieee-be');
	image_list = fread(image_file, inf, 'unsigned char');
	image_list = reshape(image_list, Cols_c, Rows_c, image_list_c);
	image_list = permute(image_list,[2 1 3]);
	fclose(image_file);
	image_list = reshape(image_list, size(image_list, 1) * size(image_list, 2), size(image_list, 3));
	image_list = double(image_list) / 255;
end