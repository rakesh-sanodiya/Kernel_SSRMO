load('iris.txt')
rp = randperm(150);
iris=iris(rp,:)
X=iris(1:10,1:4)
Y=iris(1:10,5)
U=iris(11:150,1:4)
UL=iris(11:150,5)
traindata={X}
trainlabel={Y}
uldata={U}
ullabel={UL}