function [] = similarity(ans1, ans2)
[s1, s2] = size(ans1)
count = 0;
for k = 1:s1;
    if round(ans1(k)) == round(ans2(k))
        count = count + 1;
    end
    
end
disp(count)
disp(count/s1)