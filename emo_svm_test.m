clc
cd SPEECHES
[J P]=uigetfile('.wav','Select The speech signal'); 
[J Fs]=audioread(strcat(P,J),[1e4 4e4]);
cd ..
 plot(J),hold off
sp={'anger','Disgust','Fear','Happiness','sad','Surprise'};

J=J(:,1);
W=fix(.04*Fs);                 %Window length is 40 ms
SP=.4;                         %Shift percentage is (10ms) %Overlap-Add method works good with this value(.4)
Seg=segment1(J,W,SP);
% figure,plot(Seg)
%-------------------------------------------------
for nn=1:size(Seg,2)
[F0,T,C]=PitchTrackCepstrum(Seg(:,nn),Fs);
LE=sum(Seg(:,nn).^2);
[F T]=spFormantsTrackLpc(Seg(:,nn),Fs);
F1=F(1);F2=F(2);F3=F(3);
[MFC ME] = mfcc(Seg(:,nn),Fs);
plot(MFC)
fv(:,nn)=[F0 LE F1 F2 F3 MFC' ME']';
end
FT=fv(:);
res=mysvmtest(FT',mdel,nuu);
msgbox(['The Given Emotion is ',sp{res}]);

