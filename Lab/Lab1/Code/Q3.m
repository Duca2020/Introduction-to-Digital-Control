Tsampling = 0.1;

param = {[0.4436, 10.018], [0.3329, 12.012], [0.5044, 7.9296], [0.4778, 13.9518]} % storing ç and wn values

for i=1:numel(param)
    mod_z(i) = exp(-param{i}(1)*param{i}(2)*Tsampling);
    ang = param{i}(2)*Tsampling*sqrt(1-param{i}(1)^2);
    ang_z{i} = [ang, -ang];
    
end

mod_z
ang_z{4}