function [ ] = f_plotCrack( crack_lips, factor,up_pl,down_pl, mid_pl )
% This MATLAB function was created by Martin Forbes (martin.forbes@postgrad.otago.ac.nz)
% The date of creation: Mon Nov 29 18:30:31 NZDT 2021


for kk = 1:size(crack_lips,4) %what's the crack?
  for ii = 1:size(crack_lips,1)
     p1 = crack_lips(ii,1:2,4,kk);
     p2 = crack_lips(ii,3:4,4,kk);
     p3 = crack_lips(ii,5:6,4,kk);
     dup1 = crack_lips(ii,1:2,2,kk);
     dup2 = crack_lips(ii,3:4,2,kk);
     dup3 = crack_lips(ii,5:6,2,kk);
     ddown1 = crack_lips(ii,1:2,3,kk);
     ddown2 = crack_lips(ii,3:4,3,kk);
     ddown3 = crack_lips(ii,5:6,3,kk);
     p = [p1;p2];
     dup = [dup1;dup2];
     ddown = [ddown1;ddown2];
     if any(p3)
       p = [p ; p3 ];
       dup = [dup;dup3];
       ddown = [ddown;ddown3];
     end
     p_up = p + factor*(dup);
     p_down = p + factor*(ddown);
     p_mid = p + factor*(ddown + (dup-ddown)/2);
     %p_mid = p ; 
     plot(p_up(:,1),p_up(:,2),up_pl)
     plot(p_down(:,1),p_down(:,2),down_pl)
     if nargin > 4
       plot(p_mid(:,1),p_mid(:,2),mid_pl)
     end
  end % end split or vertex elements
end

end
