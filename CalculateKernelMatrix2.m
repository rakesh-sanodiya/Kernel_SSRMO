function result=CalculateKernelMatrix2(data1,data2,theta,ker_vec1,ker_vec2,CoeffMatrix)
    result=CalculateKernelMatrix1(data1,data2,theta)-ker_vec1'*CoeffMatrix*ker_vec2;
    clear data1 data2 theta ker_vec1 ker_vec2 CoeffMatrix;