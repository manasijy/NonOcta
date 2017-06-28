function []=BH_structure(constraints)

%% This function calculates the Bishop Hill stress states

R = -1:0.1:1;
R_l = length(R);

c=0;
a=zeros(12,1);
%state=zeros(:,6);
% constraints=4;
fid= fopen('BHSS.txt','a+');
fprintf(fid,' No   A    B    C    F    G    H   SS1  SS2  SS3  SS4  SS5 SS6  SS7  SS8  SS9  SS10 SS11 SS12 \n');

                for i=1:1:R_l
                    A=R(i);

                    for j=1:1:R_l
                         B= R(j);

                         for k=1:1:R_l
                             C=R(k);

                             for l=1:1:R_l
                                 F=R(l);

                                 for m=1:1:R_l
                                     G=R(m);

                                     for n=1:1:R_l
                                         H=R(n);

% a(i) are decide the activity of SS. The commented notations are the
% notations of the SS in hosford's convention

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
                                                                               

%                       ok = (abs(a(1))<=1)&&(abs(a(2))<=1)&&(abs(a(3))<=1)&&(abs(a(4))<=1)&&...
%                            (abs(a(5))<=1)&&(abs(a(6))<=1)&&(abs(a(7))<=1)&&(abs(a(8))<=1)&&...
%                            (abs(a(9))<=1)&&(abs(a(10))<=1)&&(abs(a(11))<=1)&&(abs(a(12))<=1);
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
                                                                   
                        
                                               
                         ok = Cond1&&Cond2&&Cond3&&Cond4&&Cond5&&Cond6&&Cond7&&Cond8&&Cond9&&Cond10&&Cond11&&Cond12;
                           
                           
                                        sum=0;
                                            for t=1:1:12
                                                if abs(a(t))==1
                                                    sum=sum+1;
                                                end
                                            end
                                                
                                        
                              if ((ok==1)&&(sum>=constraints))&&(A+B+C==0) 
                                  c=c+1;
                                  state(c,:)=[c,A,B,C,F,G,H,a'];
                                  
                                  
                                  fprintf(fid,' %2d %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f %+3.1f \n',...
                                      state(c,1),state(c,2),state(c,3),state(c,4),state(c,5),...
                                      state(c,6),state(c,7),state(c,8),state(c,9),state(c,10),...
                                      state(c,11),state(c,12),state(c,13),state(c,14),...
                                      state(c,15),state(c,16),state(c,17),state(c,18),state(c,19));
%                                   state(c,:)=[c,a'];
                              end
                                     end
                                 end
                             end
                         end
                    end
                end
                save('state')
end
