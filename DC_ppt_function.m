
function [shape,DC_ppt,n_varient]= DC_ppt_function()

CS = crystalSymmetry('-43m'); % Cubic system
%SS = specimenSymmetry('mmm');     % orthorhombic sample symmetry

fprintf('Plese enter 1 if the ppt shape is needle \n and 2 if ppt shape is plate\n');
shape = input('');

fprintf('Please enter ppt direction.\n In case of needle enter "u v w" and incase of plate enter "h k l" \n');
direction = input('');
d = sscanf(direction,'%d');

direction_miller =  Miller(d(1),d(2),d(3),CS,'hkl'); % direction_miller is a variable of class miller and it stores the ppt direction
                                               % in a vector3d class miller
                                               % form
varients = symmetrise(direction_miller);       % It stores all varients of the ppt in variable 'varients' 

%% Checking for any repetition of the varient directions or inversions
varient = varient_reduction_function(varients);


%% Now finding out the axis angle pair for the rotation of crystal frame to the ppt frame

n_varient = length(varient);

for i=1:1:n_varient
    rot_axis = cross(Miller(0,0,1,CS),varient(i));
    rot_angle = angle(Miller(0,0,1,CS),varient(i))/degree;
    o{i} = orientation('axis',rot_axis,'angle',rot_angle*degree); 
     DC_ppt{i} = matrix(o{i}); % this is the direction cosine matrix to rotate the strain tensor to the ppt ref frame
end     


