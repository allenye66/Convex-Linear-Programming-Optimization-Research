function [] = compare(offline_output, online_output)

n = 1e5;
c = rand(n, 1);

offline = c'*offline_output;
online = c'*online_output;

disp(offline)
disp(online)
if online>offline;
    disp(offline/online)
end

if offline>online;
    disp(online/offline)
end
