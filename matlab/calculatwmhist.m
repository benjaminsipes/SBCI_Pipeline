clear all;
close all;
 
load('connectivity99pg.mat');

sc = full(sc);

n = size(time_series, 1);
[ii,jj] = ndgrid(1:n);

B = zeros(n); 
B(ii>=jj) = fc;
fc = B';

fc = fc + fc';
fc = fc - diag(diag(fc)); 
 
sc_nodiag = sc;
sc_nodiag = sc_nodiag>0;
sc_nodiag = sc_nodiag - diag(diag(sc_nodiag));
 
sc_noconn = ones(size(sc_nodiag))-sc_nodiag;
sc_noconn = sc_noconn - diag(diag(sc_noconn));
 
set1_conn = fc.*sc_nodiag;
set2_conn = fc.*sc_noconn;
 
set1_conn_vec = set1_conn(find(set1_conn));
set1_conn_vec = set1_conn_vec(~isnan(set1_conn_vec));
 
set2_conn_vec = set2_conn(find(set2_conn));
set2_conn_vec = set2_conn_vec(~isnan(set2_conn_vec));

figure
myBins = linspace(-1,1, 100);
histogram(set1_conn_vec,myBins,'FaceColor','r','FaceAlpha',0.6,'Normalization','probability')
hold on
histogram(set2_conn_vec,myBins,'FaceColor','b','FaceAlpha',0.6,'Normalization','probability')
box off
legend('With WM','W/O WM','location','northwest')
legend boxoff