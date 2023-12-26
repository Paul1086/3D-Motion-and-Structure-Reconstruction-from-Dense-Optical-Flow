function V_mat= velocity_matrix(X,Y,Z,Tz,p0,f,omegas)

Tx = p0(1)*Tz./f;
Ty = p0(2)*Tz./f;

V_mat = zeros(length(Tx),3);
test = 0;
for i=1:length(Tx)
    
   
    vx = - Tx(i) + omegas(3)*Y(i)-omegas(2)*Z(i);
    vy =  -Ty(i) + omegas(1)*Z(i)-omegas(3)*X(i);
    vz = -Tz(i) + omegas(2)*X(i)-omegas(1)*Y(i);
    
    if abs(vx)<10 && abs(vy)<100 && abs(vz)<100
    test = test + 1;
    V_mat(i,:) = [vx, vy, vz];
    
    end
    
end

end