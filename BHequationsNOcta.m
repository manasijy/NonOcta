





SlipSystem = struct('n',zeros(1,3),'b',zeros(1,3));

%% NonOctahedral Slip Systems: (001)[110]
SlipSystem(1).n=[1,0,0]; SlipSystem(1).b =[0,1,1];
SlipSystem(2).n=[1,0,0]; SlipSystem(2).b =[0,-1,1];
SlipSystem(3).n=[0,1,0]; SlipSystem(3).b =[1,0,1];
SlipSystem(4).n=[0,1,0]; SlipSystem(4).b =[-1,0,1];
SlipSystem(5).n=[0,0,1];SlipSystem(5).b =[1,1,0];
SlipSystem(6).n=[0,0,1];SlipSystem(6).b =[-1,1,0];

SlipSystem(7).n=[1,0,0]; SlipSystem(7).b =[0,-1,-1];
SlipSystem(8).n=[1,0,0]; SlipSystem(8).b =[0,1,-1];
SlipSystem(9).n=[0,1,0]; SlipSystem(9).b =[-1,0,-1];
SlipSystem(10).n=[0,1,0]; SlipSystem(10).b =[1,0,-1];
SlipSystem(11).n=[0,0,1];SlipSystem(11).b =[-1,-1,0];
SlipSystem(12).n=[0,0,1];SlipSystem(12).b =[1,-1,0];


fid= fopen('BHEQNOcta.txt','a+');
fprintf(fid,'\n s11 s22 s33 s23 s13 s12 \n');

for i=1:1:12
    x11 = (SlipSystem(i).n(1)*SlipSystem(i).b(1));
    x12 = (SlipSystem(i).n(1)*SlipSystem(i).b(2));
    x13 = (SlipSystem(i).n(1)*SlipSystem(i).b(3));
    x21 = (SlipSystem(i).n(2)*SlipSystem(i).b(1));
    x22 = (SlipSystem(i).n(2)*SlipSystem(i).b(2));
    x23 = (SlipSystem(i).n(2)*SlipSystem(i).b(3));
    x31 = (SlipSystem(i).n(3)*SlipSystem(i).b(1));
    x32 = (SlipSystem(i).n(3)*SlipSystem(i).b(2));
    x33 = (SlipSystem(i).n(3)*SlipSystem(i).b(3));
    
    x12_ = x12 + x21; x13_=x13+x31; x23_=x23+x32;
    

fprintf(fid,'  %d   %d   %d   %d   %d   %d \n',x11,x22,x33,x23_,x13_,x12_);

end
save('BHEQs')




