function []=BH_structureNOcta(constraints)

%% This function calculates the Bishop Hill stress states

% R = [-1,-0.5,0,0.5,1];
R = -1:0.1:1;
R_l = length(R);
c=0;
a=zeros(18,1);
%state=zeros(:,6);
% constraints=4;
fid= fopen('BHSS.txt','a+');
fprintf(fid,' No   A    B    C    F    G    H   SS1  SS2  SS3  SS4  SS5 SS6  SS7  SS8  SS9  SS10 SS11 SS12 SS13  SS14  SS15  SS16  SS17 SS18\n');

                for i=1:1:R_l %5
                    A=R(i);

                    for j=1:1:R_l %5
                         B= R(j);

                         for k=1:1:R_l %5
                             C=R(k);

                             for l=1:1:R_l %5
                                 F=R(l);

                                 for m=1:1:R_l %5
                                     G=R(m);

                                     for n=1:1:R_l %5
                                         H=R(n);

% a(i) decide the activity of SS

                                         a(1)=(-(A-G+H));%-a1 
                                         a(2)=(B+F-H);%a2
                                         a(3)=(-(C-F+G));%-a3
                                         a(4)=(C-F-G);%-c3
                                         a(5)=(B+F+H);%c2
                                         a(6)=(-(A+G-H));%-c1
                                         a(7)=(C+F+G);%d3
                                         a(8)=(B-F+H);%d2 
                                         a(9)=(-(A-G-H));%-d1
                                         a(10)=(-(C+F-G));%-b3
                                         a(11)=(-(B-F-H));%-b2
                                         a(12)=(A+G+H);%b1
                                         
                                         CF = 0.8; % tau_Nocta/tau_octa
                                         Tau_c = CF/(sqrt(3));% tau_Nocta/tau_octa
                                         
                                         a(13)=G+H;
                                         a(14)=G-H;
                                         a(15)=F+H;
                                         a(16)=F-H;
                                         a(17)=F+G;
                                         a(18)=F-G;
                                         

                        Cond1 = (abs(a(1))==1)||(abs(a(1))==0);
                        Cond2 = (abs(a(2))==1)||(abs(a(2))==0);
                        Cond3 = (abs(a(3))==1)||(abs(a(3))==0);
                        Cond4 = (abs(a(4))==1)||(abs(a(4))==0);
                        Cond5 = (abs(a(5))==1)||(abs(a(5))==0);
                        Cond6 = (abs(a(6))==1)||(abs(a(6))==0);
                        Cond7 = (abs(a(7))==1)||(abs(a(7))==0);
                        Cond8 = (abs(a(8))==1)||(abs(a(8))==0);
                        Cond9 = (abs(a(9))==1)||(abs(a(9))==0);
                        Cond10 = (abs(a(10))==1)||(abs(a(10))==0);
                        Cond11 = (abs(a(11))==1)||(abs(a(11))==0);
                        Cond12 = (abs(a(12))==1)||(abs(a(12))==0);
                        Cond13 = (abs(a(13))==Tau_c)||(abs(a(13))==0);
                        Cond14 = (abs(a(14))==Tau_c)||(abs(a(14))==0);
                        Cond15 = (abs(a(15))==Tau_c)||(abs(a(15))==0);
                        Cond16 = (abs(a(16))==Tau_c)||(abs(a(16))==0);
                        Cond17 = (abs(a(17))==Tau_c)||(abs(a(17))==0);
                        Cond18 = (abs(a(18))==Tau_c)||(abs(a(18))==0);
                        
%                         Cond13 = (abs(a(13))==1)||(abs(a(13))==0);
%                         Cond14 = (abs(a(14))==1)||(abs(a(14))==0);
%                         Cond15 = (abs(a(15))==1)||(abs(a(15))==0);
%                         Cond16 = (abs(a(16))==1)||(abs(a(16))==0);
%                         Cond17 = (abs(a(17))==1)||(abs(a(17))==0);
%                         Cond18 = (abs(a(18))==1)||(abs(a(18))==0);
                                         
                        
                                               
ok = Cond1&&Cond2&&Cond3&&Cond4&&Cond5&&Cond6&&Cond7&&Cond8&&Cond9&&Cond10&&Cond11&&Cond12&&Cond13&&Cond14&&Cond15&&Cond16&&Cond17&&Cond18;
                                         
                                         
                                         
                                         
                                         
%                       ok = (abs(a(1))<=1)&&(abs(a(2))<=1)&&(abs(a(3))<=1)&&(abs(a(4))<=1)&&...
%                            (abs(a(5))<=1)&&(abs(a(6))<=1)&&(abs(a(7))<=1)&&(abs(a(8))<=1)&&...
%                            (abs(a(9))<=1)&&(abs(a(10))<=1)&&(abs(a(11))<=1)&&(abs(a(12))<=1)&&...
%                            (abs(a(13))<=Tau_c)&&(abs(a(14))<=Tau_c)&&(abs(a(15))<=Tau_c)&&(abs(a(16))<=Tau_c)&&...
%                            (abs(a(17))<=Tau_c)&&(abs(a(18))<=Tau_c);
                           sum=0;
                                            for t=1:1:18
                                                if abs(a(t))>=1
                                                    sum=sum+1;
                                                end
                                            end
                                                
                                        
                              if ((ok==1)&&(sum>=constraints))&&(A+B+C==0) 
                                  c=c+1;
                                  state(c,:)=[c,A,B,C,F,G,H,a'];
                                  

% fprintf(fid,'\n s11 s22 s33 s23 s13 s12 \n');
                                  
                                  
fprintf(fid,' %2d %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f \n',...
                                      state(c,1),state(c,2),state(c,3),state(c,4),state(c,5),...
                                      state(c,6),state(c,7),state(c,8),state(c,9),state(c,10),...
                                      state(c,11),state(c,12),state(c,13),state(c,14),...
                                      state(c,15),state(c,16),state(c,17),state(c,18),state(c,19),...
                                      state(c,20),state(c,21),state(c,22),state(c,23),state(c,24),state(c,25));

                              end
                                     end
                                 end
                             end
                         end
                    end
                end
                save('state2.mat','state')
end
