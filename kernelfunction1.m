function result=kernelfunction1(x1,x2,theta)
    result=theta(1)*x1*x2'+theta(2)*exp(-(x1-x2)*(x1-x2)'/(2*theta(3)^2));
    clear x1 x2 theta;