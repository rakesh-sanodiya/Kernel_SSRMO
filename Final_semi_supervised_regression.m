
%% Load Iris data set and divide into training and testing dataset
 load('Dataset\iris\iris_y')
 load('Dataset\iris\iris_X')
 X=iris_X
 y=iris_y
 t_label={y(1:20,1)}
 t_data={X(1:20,1:4)}
 u_label={y(21:150,1)}
 u_data={X(21:150,1:4)}
 %%Call Kernel_semi_supervised algorithm for regression
 [error]=Kernel_semi_super(t_data,t_label,u_data,u_label,ts_data,ts_label)