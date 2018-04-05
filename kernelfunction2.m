function result=kernelfunction2(x1,x2,theta,ker_vec1,ker_vec2,CoeffMatrix)
    result=kernelfunction1(x1,x2,theta)-ker_vec1'*CoeffMatrix*ker_vec2;