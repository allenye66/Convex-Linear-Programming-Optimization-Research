function [] = compare(offline_output, online_output, c_vector)
[s1, s2] = size(offline_output)
offline = 0
online = 0
for k = 1:s1;
    offline = offline + offline_output(k)*c_vector(k)
    online = online + online_output(k)*c_vector(k)
end
disp("---------------------------")
disp(offline)
disp(online)
if online>offline;
    disp(offline/online)
end

if offline>online;
    disp(online/offline)
end
