function disMatrix=CalPairwiseDis(varargin)
    if nargin==1
        data=varargin{1};
        n=size(data,1);
        summation=sum(data.^2,2);
        disMatrix=repmat(summation,1,n)+repmat(summation',n,1)-2*(data*data');
        clear data summation;
    elseif nargin==2
        data1=varargin{1};
        data2=varargin{2};
        n1=size(data1,1);
        n2=size(data2,1);
        sum1=sum(data1.^2,2);
        sum2=sum(data2.^2,2);
        disMatrix=repmat(sum1,1,n2)+repmat(sum2',n1,1)-2*data1*data2';
        clear data1 data2 sum1 sum2 n1 n2;
    end
    clear varargin;