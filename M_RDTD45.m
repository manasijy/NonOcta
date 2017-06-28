%% Main Taylor Factor Program  
% This program can calculate taylor foctors in RD,TD and 45 degree to RD direction tests
% This can be done for an ideal texture component as well as for an euler angle file



clear;      
close;


%% Declaration of variables


global Co;
global BH;
ro =0;
e_ext= zeros(3,3);

M_RD =0;
M_TD =0;
M_45RD = 0;
Co = sqrt(6);


%% Creating the strain tensor
% This block selects the strain tensor from two preset strain tensors
% It also provides the option to enter user defined strain tensor



fprintf('Please enter strain condition \n For plane strain input 1 \n For axisymmetric strain inpur 2 \n For any other strain condition enter 3 \n')
 

y = input('');
         
 switch y
     case 1 
           ro = 0;
        
     case 2 
           ro = 0.5;  
           
     case 3
           fprintf('Please enter rho (-dw/dl) \n');
           ro = input('');
           %(input,'%d');
                   
     otherwise
             warning('Unexpected choice entered. Taylor factor can not be calculated.');
             break;
 end
 
 e_ext= [1,0,0;0,-ro,0;0,0,ro-1];




%% Creating Bishop Hill stress state matrix from the text file named: BHfile.txt

B = fopen('BHfileNO.txt'); %BHfile%NO.txt
BH = textscan(B, ' %f %f %f %f %f %f');
fclose(B);





%% Selecting the taylor factor calculation function 


fprintf('For a single orientation enter 1 \n For a polycrystal enter 2\n ')
selection = input('');  %prompt = 'If you want taylor factor for a single orientation enter 1 for a polycrystal enter 2:\n ';

 if  selection ==1 

         [M_RD,M_TD,M_45RD]= single_crystal_function(e_ext);   
         
 elseif selection == 2 
        [M_RD,M_TD,M_45RD] = poly_crystal_function(e_ext); 
        
       
     
 else
     fprintf('Please enter either 1 or 2 \n ')
     break;
 end
 
        fprintf('M_RD = "%f" \n', M_RD)
        fprintf('M_TD "%f" \n', M_TD)
        fprintf('M_45RD "%f" \n', M_45RD)

       




