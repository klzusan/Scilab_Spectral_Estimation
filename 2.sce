clear;
cd /Users/klzu/Documents/code/Scilab/IoT2
g = 0;
[s, Fs, bits] = wavread('ex2024.wav');
fil_order = 400;

rand('normal');rand('seed', 0);
x = rand(1:1024-fil_order+1);
[hn, hm, fr] = wfir('bp', fil_order, [600/Fs 630/Fs], 'hm', );
h1 = [hn 0*ones(1:max(size(x)) -1)];
x1 = [x 0*ones(1:max(size(hn)) -1)];
hf = fft(h1, -1);
xf = fft(x1, -1);
yf = hf.*xf;
y = real(fft(yf, 1));

scf(g);
clf;
plot(hn);
xtitle('', 't/Δt', 'h(n)');

g = g + 1;
scf(g);
clf;
//plot2d(log(hf), rect=[0, -20, 750, 0]);
plot2d(log(hf));
xtitle('', 'f/fs', 'H(ω)');

g = g + 1;
scf(g);
clf;
plot(y);
xtitle('', '', 'y(n)');

g = g + 1;
scf(g);
clf;
//plot2d(log(yf), rect=[0, -20, 750, 0]);
plot2d(log(yf));
xtitle('', '', 'Y(ω)');

order=600;len=600;fft_len=660;
j=1;
for i=0:order
    r(j)=0;
    for n=1:len-i
        r(j)=r(j)+y(n)*y(n+i);
    end
    j=j+1;
end
[ar, sigma2, rc] = lev(r);
a(1)=1.0;
a(2:order+1) = ar(1:order);
a(order+1:fft_len)=zeros(fft_len-order,1);
af=abs(fft(a,-1));
s=1 ./(af .^2);

g = g + 1;
scf(g);
clf;
plot2d(s, rect = [0, 0, 300, 100000]);
xtitle('', 'f/fs', '$S(\omega)$')
