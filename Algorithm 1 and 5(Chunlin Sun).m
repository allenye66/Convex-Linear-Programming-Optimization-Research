 
 %cvx_solver Gurobi_2
test = 0;
%n_choice = [20,100,1000,5000,10000,30000,50000,70000,85000,100000];
%n_choice = 1e5*ones(100,1);
n_choice = 1e5;
rep = 100;
average_regret_ini = zeros(9,rep);
constraint_violation_ini = zeros(9,rep);
average_regret_adp = zeros(length(n_choice),rep);
constraint_violation_adp = zeros(length(n_choice),rep);
average_regret_n = zeros(length(n_choice),rep);
constraint_violation_n = zeros(length(n_choice),rep);
average_regret_res = zeros(length(n_choice),rep);
opt_iter = zeros(length(n_choice),1);
m=1e3;
xx = [-1,1,3];

cpu_n = zeros(length(n_choice),rep);
cpu_res = zeros(length(n_choice),rep);
cpu_gu = zeros(length(n_choice),1);
time_n = zeros(length(n_choice),rep);
time_res = zeros(length(n_choice),rep);
time_gu = zeros(length(n_choice),1);

for mi = 1:length(n_choice)
    
    
    % worst case in zihuo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % z=3, n=1e3; z=7 n=1e4; z=10,n=1e5
    z = 10;
    m = 2^z;
    n = n_choice(mi);
    d = (1*rand(m,1)+1)/3;
    b = d*n;
    
    v = zeros(m,z);
    w = zeros(m,z);
    for it = 1:m
        numb = dec2bin(it-1);
        lengthn = length(numb);
        for zit = 1:z
            if(zit>lengthn)
                v(it,zit) = 0;
            else
                v(it,zit) = str2num(numb(lengthn-zit+1));
            end
        end
    end
    w = 1-v;
    
    syms B
    eqn = 3*B+sqrt(B*z/4);
    B = vpasolve(eqn==n,B);
    B = double(B);
    num_part1 = ceil(B/z);
    num_part2 = ceil(2*B/z);
    num_part3 = ceil(sqrt(B/4/z));
    fprintf('difference=%d\n',n - (num_part1*z+num_part2*z+num_part3*z ));
    n = num_part1*z+num_part2*z+num_part3*z;
    q_i = binornd(num_part2,0.5,z,1);
    it = 1;
    a0 = zeros(m,n);
    r0 = zeros(1,n);
    for zit = 1:z
        for p1it = 1:num_part1
            a0(:,it) = v(:,zit);
            r0(it) = 4;
            it = it+1;
        end
        for p2it = 1:num_part2
            a0(:,it) = w(:,zit);
            if(p2it>q_i(zit))
                r0(it) = 3;
            else
                r0(it) = 1;
            end
            it = it+1;
        end
        for p3it = 1:num_part3
            a0(:,it) = w(:,zit);
            r0(it) = 2;
            it = it+1;
        end
    end
    a0 = a0';
    % end worst case in zihuo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %n = n_choice(mi);
    
    
%     a0(1:n/4,:) = rand(n/4,m)*2;
%     a0(n/4+1:n/2,:) = randn(n/4,m)+1;
%     a0(n/2+1:3*n/4,:) = randn(n/4,m);
%     a0(3*n/4+1:n,:) = xx(randi(3,n/4,m));
            %a = a.*((a<bdd).*(a>-bdd)) + 6*(a>=bdd) - bdd*(a<=-bdd);
            %r0 = rand(n,1);
            r0 = sum(a0,2)-m*(rand(n,1)-0.5);
            d = (1*rand(m,1)+1)/3;
            b = d*n;    
    
            fprintf("start solving offline problem by cvx\n")
            t_gu = cputime;
            tt_gu = tic;
            cvx_begin
            variable x0(n)
            maximize (r0'*x0);
            dual variables p v u
            subject to 
               p:a0'*x0 <= b;
               v: x0 <= 1;
               u: x0 >= 0;
            cvx_end
            time_gu(mi) = toc(tt_gu);
            cpu_gu(mi) = cputime-t_gu;
            opt = (r0'*x0);
            
            opt_iter(mi)=opt;

                    p0_ini = zeros(m,1);
        p0_adp = zeros(m,rep);
        p0_n = zeros(m,rep);
        p0_res = zeros(m,rep);
        dual_gap = zeros(n,rep);
        reg_p0 = zeros(n,rep);

        x_online_ini = zeros(n,rep);
        x_online_adp = zeros(n,rep);
        x_online_n = zeros(n,rep);
        x_online_res = zeros(n,rep);
        resource_vio = zeros(m,n);
        sol_reg = zeros(rep,1);
        sol_reg_adp = zeros(rep,1);
        sol_reg_n = zeros(rep,1);
        sol_reg_res = zeros(rep,1);
        b_res_ini = b*ones(rep,1)';
        b_res_adp = b*ones(rep,1)';
        b_res_n = b*ones(rep,1)';
        b_res_res = b*ones(rep,1)';
        b_res_old = b;
        res_acc = zeros(m,1);
        t_res = 0;
        tt_res = 0;
        perm = zeros(rep,n);
        for iter_lp = 1:rep
            perm(iter_lp,:) = randperm(n);
        end
        t_res = zeros(rep,1);
        tt_res = zeros(rep,1);
        t_n = zeros(rep,1);
        tt_n = zeros(rep,1);
        
        
    parfor iter_lp  = 1:rep


        p_index_zero = find(p==0);
        fprintf("solving online, iter=%d\n",iter_lp);

        %p0 = p;

        for iter = 1:n
            %fprintf("iter=%d\n",iter);
            %p0 = (save_p(:,1:iter-1))*(1./sqrt(1:iter-1))'/sum(1./sqrt(1:iter-1));
            %p0 = (save_p(:,1:iter-1))*(1./one())'/sum(1./(1:iter-1));
            %pt=p0;
            if iter>0
                %res
                t_res(iter_lp) = cputime;
                tt_res(iter_lp) = tic;
                x_online_res(iter,iter_lp) = (r0(perm(iter_lp,iter))>a0((perm(iter_lp,iter)),:)*p0_res(:,iter_lp));
                p0_res(:,iter_lp) = p0_res(:,iter_lp) - 1/sqrt(iter)*(d-x_online_res(iter,iter_lp)*a0((perm(iter_lp,iter)),:)');
                p0_res(:,iter_lp) = p0_res(:,iter_lp).*(p0_res(:,iter_lp)>0);                
                if (sum(b_res_res(:,iter_lp)< x_online_res(iter,iter_lp)*a0((perm(iter_lp,iter)),:)') >0)
                        x_online_res(iter,iter_lp) = 0;
                end
                b_res_res(:,iter_lp) = b_res_res(:,iter_lp) - x_online_res(iter,iter_lp)*a0((perm(iter_lp,iter)),:)';                
                time_res(mi,iter_lp) = time_res(mi,iter_lp)+toc(uint64(tt_res(iter_lp)));
                cpu_res(mi,iter_lp) = cpu_res(mi,iter_lp)+cputime-t_res(iter_lp);
                
                if(sum(b_res_res(:,iter_lp)<0)>0)
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                end               
                
                
                
                %n
                t_n(iter_lp) = cputime;
                tt_n(iter_lp) = tic;
                x_online_n(iter,iter_lp) = (r0(perm(iter_lp,iter))>a0((perm(iter_lp,iter)),:)*p0_n(:,iter_lp));
                p0_n(:,iter_lp) = p0_n(:,iter_lp) - 1/sqrt(n)*(d-x_online_n(iter,iter_lp)*a0((perm(iter_lp,iter)),:)');
                p0_n(:,iter_lp) = p0_n(:,iter_lp).*(p0_n(:,iter_lp)>0);                
                if (sum(b_res_n(:,iter_lp)< x_online_n(iter,iter_lp)*a0((perm(iter_lp,iter)),:)') >0)
                        x_online_n(iter,iter_lp) = 0;
                end
                b_res_n(:,iter_lp) = b_res_n(:,iter_lp) - x_online_n(iter,iter_lp)*a0((perm(iter_lp,iter)),:)';                
                time_n(mi,iter_lp) = time_n(mi,iter_lp)+toc(uint64(tt_n(iter_lp)));
                cpu_n(mi,iter_lp) = cpu_n(mi,iter_lp)+cputime-t_n(iter_lp);
                
                if(sum(b_res_n(:,iter_lp)<0)>0)
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                    fprintf('fuck, %d\n',iter_lp);
                end
                                
                
                
                
                

            end    
            sol_reg_n(iter_lp) = sol_reg_n(iter_lp) + + r0(perm(iter_lp,iter))*x_online_n(iter,iter_lp);
            sol_reg_res(iter_lp) = sol_reg_res(iter_lp) + r0(perm(iter_lp,iter))*x_online_res(iter,iter_lp);

            % use one to update
            
            % use all to update
            % p0 = p0 - 1/sqrt(iter)*(d-(a'*(r>a*p0))/n);
            % use knonw part to update
            %p0 = p0 - 1/sqrt(iter)*(d-(a(1:iter,:)'*(r(1:iter)>a(1:iter,:)*p0))/iter);
            %average

            
            %fprintf("iter = %d,sum of binding terms in p0 =%d\n",iter, sum(p0(p_index_zero).^2));
            %resource_vio(:,iter) =  (res_acc/iter-d).*((res_acc)/iter>d);
            %resource_vio(:,iter) = sum(abs(a.*((r>a*p0)-(r>a*p))))/n;
            %resource_vio(:,iter) = (sum((a.*((r>a*p0))))/n-d').*((sum((a.*((r>a*p0))))/n>d'));
            %dual_gap(iter) = b'*p0 - sum(a*p0.*(r>a*p0));
            %dual_gap(iter) = opt/n*sqrt(iter)/log(iter) - sum(r(1:iter).*(r(1:iter)>a(1:iter,:)*p0))/sqrt(iter)/log(iter);
            %reg_p0(iter) = sum(r.*(r>a*p0))-opt;
            %save_p(:,iter) = p0;
            %dist_p(iter) = norm(p0-p);
            %sol_reg = sol_reg + r(iter)*(r(iter)>a(iter,:)*p0);%wrong!!!!

            %reg_dual(iter) = b'*p0 + ones(1,n)*((r-a*p0).*(r>a*p0)) - opt;
            if iter>1e1

                %resource_vio(:,iter) = (sum((a.*((r>a*p0))))/n-d').*((sum((a.*((r>a*p0))))/n>d'));

                %dual_gap
                %figure(1),plot([iter-1,iter],[dual_gap(iter-1)/sqrt(iter-1),dual_gap(iter)/sqrt(iter)]);
                %title("Dual gap for p / sqrt(iter)");
                %hold on;
                %regret for p0
                %figure(2),plot([iter-1,iter],[reg_p0(iter-1)/sqrt(iter-1),reg_p0(iter)/sqrt(iter)]);
                %title("p0 regret / sqrt(iter)");
                %hold on;
                %dual convergence
                %figure(3),plot([iter-1,iter],[sqrt(iter-1)*dist_p(iter-1),sqrt(iter)*dist_p(iter)]);
                %figure(3),plot([iter-1,iter],[dist_p(iter-1),dist_p(iter)]);
                %title("convergence of p: sqrt(iter) * norm(p-p*)")
                %hold on;
                % regret for dynamic ALG
                %figure(4),plot([iter-1,iter],[(sol_reg- r(iter)*x_online(iter)-opt/n*(iter-1))/sqrt(iter-1),(sol_reg-opt/n*iter)/sqrt(iter)]);
                %title("dynamic regret / sqrt(iter)")
                %hold on;
                %figure(5),plot([iter-1,iter],[reg_dual(iter-1)/sqrt(iter-1),reg_dual(iter)/sqrt(iter)]);
                %hold on;
                %figure(6),plot([iter-1,iter],[sum(resource_vio(:,iter-1))*sqrt(iter-1),sum(resource_vio(:,iter))*sqrt(iter)]);
                %hold on;
            end
        end

        average_regret_n(mi,iter_lp) = opt - sol_reg_n(iter_lp);
        average_regret_res(mi,iter_lp) = opt - sol_reg_res(iter_lp);
        constraint_violation_ini(mi,iter_lp) = -sum(b_res_res(:,iter_lp).*(b_res_res(:,iter_lp)<0));
        constraint_violation_n(mi,iter_lp) = -sum(b_res_n(:,iter_lp).*(b_res_n(:,iter_lp)<0));
    end
    clear a0;
end

figure(1),plot(n_choice,mean(average_regret_ini,2)./sqrt(n_choice)');
hold on;
figure(1),plot(n_choice,mean(average_regret_adp,2)./sqrt(n_choice)');
hold on;
figure(1),plot(n_choice,mean(average_regret_n,2)./sqrt(n_choice)');
hold on;
figure(1),plot(n_choice,mean(average_regret_res,2)./sqrt(n_choice)');
legend("Initial Algorithm with stepsize=1/sqrt(t)","Nonstationary Algorithm","Initial Algorithm with stepsize=1/n","Feasible Algorithm")
title("regret/sqrt(n) for four Algorithms")

%figure(2),semilogy(n_choice,mean(constraint_violation_ini,2)./sqrt(n_choice)');
% hold on;
% figure(2),semilogy(n_choice,mean(constraint_violation_adp,2)./sqrt(n_choice)');
% hold on;
% figure(2),semilogy(n_choice,mean(constraint_violation_n,2)./sqrt(n_choice)');
% legend("Initial Algorithm with stepsize=1/sqrt(t)","Initial Algorithm with stepsize=1/n", "Nonstationary Algorithm")
% title("constraint violation/sqrt(n) for three Algorithms")

figure(2),plot(n_choice,mean(constraint_violation_ini,2)./sqrt(n_choice)');
hold on;
figure(2),plot(n_choice,mean(constraint_violation_adp,2)./sqrt(n_choice)');
hold on;
figure(2),plot(n_choice,mean(constraint_violation_n,2)./sqrt(n_choice)');
legend("Initial Algorithm with stepsize=1/sqrt(t)","Initial Algorithm with stepsize=1/n", "Nonstationary Algorithm")
title("constraint violation/sqrt(n) for three Algorithms")


mean(sqrt(var(ones(100,1)*opt_iter'-average_regret_n'))/mean(opt_iter'-average_regret_n'))
mean(var(ones(100,1)*opt_iter'-average_regret_n'))
%(ones(100,1)*opt_iter'-average_regret_n'
% min((ones(100,1)*opt_iter'-average_regret_n')./opt_iter'
% mean(max((ones(100,1)*opt_iter'-average_regret_res'))./opt_iter')
% mean(mean((ones(100,1)*opt_iter'-average_regret_res'))./opt_iter')
% 

% cv:
mean(sqrt(var(ones(100,1)*opt_iter'-average_regret_res'))/mean(opt_iter'-average_regret_res'))



