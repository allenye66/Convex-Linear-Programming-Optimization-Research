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


%% to run the algorithm 100 times:
%x1_avg = 0
%load input data
%for i = 1:100
%   [x1, y1] = fastLP(A, b, c, 1)    
%   x1_avg = x1_avg + c'*x1
%end
%load o(n) or o(1) offline - make sure to get the correct one
%offline = c'*x*100
%offline/x1_avg
%%