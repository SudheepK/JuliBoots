(* ::Package:: *)

(* ::Title::Closed:: *)
(*Recursion functions*)


(* ::Text:: *)
(*The result of the first section was the recursion relation for the coefficients:*)
(**)


ClearAll[cn,\[CapitalDelta],l,n,\[Epsilon],coeffs];



(* ::Text:: *)
(*Relating rho derivatives to z derivatives*)





SetNDer[nzder_,prec_,zv_]:=
(* this function computs coeff[i,j] with i,j<=nzder *)
Module[{\[Rho]0,\[Rho]der,F,coeff,coeffTab,zdermax,f,zz,z},(* \[Rho]der[n] is the n-th derivative of rho(z) at z=1/2 *)
$MaxExtraPrecision=100;
Clear[\[Rho]0,\[Rho]der];
\[Rho]0[0]=(2-z-2Sqrt[1-z])/z;
\[Rho]0[n_]:=\[Rho]0[n]=D[\[Rho]0[n-1],z];
\[Rho]der[n_]:=\[Rho]der[n]=((\[Rho]0[n]/.z->zv//Simplify))//Expand//Simplify;

ClearAll[F];
F[0]:=f[\[Rho][zz]];
F[n_/;n>0]:=F[n]=D[F[n-1],zz];
coeff[i_,j_]:=(((Coefficient[F[i],Derivative[j][f][\[Rho][zz]]])/.Derivative[a_][\[Rho]][zz]:>\[Rho]der[a]))//Expand;
coeffTab = Table[coeff[i,j],{i,nzder},{j,i}];
zdermax = nzder;
Return[SetPrecision[coeffTab,prec]];
];





(* ::Subsubsection:: *)
(*Recurse*)


Recurse[eps_,ll_,prec_,mmax_,nmax_,kmax_]:=Module[{\[Epsilon],l,fudge,expr,zdermax,t1,t2,t3,t4,coeffs,cn,cnRhoDer,CRec,cs,\[Rho]num,coeffTab,z,casCoeffs},(

ClearAll[cn,cnRhoDer,CRec];

\[Epsilon]=eps;l=ll;
fudge=10^-50;

coeffs[n_]:={((-3+n+\[CapitalDelta]) (-5-l+2 n+\[CapitalDelta]) (-2+n+\[Epsilon]) (-5+l+2 n+\[CapitalDelta]+2 \[Epsilon]))/(n (-1+l+2 n+\[CapitalDelta]) (-1-l+2 n+\[CapitalDelta]-2 \[Epsilon]) (-1+n+\[CapitalDelta]-\[Epsilon])),1/(4 n (-1+l+2 n+\[CapitalDelta]) (-1-l+2 n+\[CapitalDelta]-2 \[Epsilon]) (-1+n+\[CapitalDelta]-\[Epsilon])) (-3 l (-1+\[CapitalDelta]) (-1+\[CapitalDelta]-2 \[Epsilon]) (l+2 \[Epsilon])-(-4+2 n+\[CapitalDelta]) (-166+24 n^3+3 \[CapitalDelta]^3+4 n^2 (9 \[CapitalDelta]+4 (-8+\[Epsilon]))+4 \[CapitalDelta]^2 (-8+\[Epsilon])+78 \[Epsilon]+4 \[Epsilon]^2+\[CapitalDelta] (123-34 \[Epsilon]-4 \[Epsilon]^2)+2 n (123+9 \[CapitalDelta]^2+8 \[CapitalDelta] (-8+\[Epsilon])-34 \[Epsilon]-4 \[Epsilon]^2))+(3+12 (-2+n)^2-2 \[Epsilon]+4 (-2+n) (1+3 \[CapitalDelta]+\[Epsilon])+\[CapitalDelta] (2+3 \[CapitalDelta]+2 \[Epsilon])) (l^2+2 l \[Epsilon]+\[CapitalDelta] (\[CapitalDelta]-2 (1+\[Epsilon])))),((-2+2 n+\[CapitalDelta]) ((-2+2 n+\[CapitalDelta]) (31+12 n^2-16 \[CapitalDelta]+3 \[CapitalDelta]^2+4 n (-8+3 \[CapitalDelta]))-2 (9+8 n^2-7 \[CapitalDelta]+2 \[CapitalDelta]^2+2 n (-7+4 \[CapitalDelta])) \[Epsilon]-4 (-5+2 n+\[CapitalDelta]) \[Epsilon]^2)+3 (-2 (-2+2 n+\[CapitalDelta])+l (-1+\[CapitalDelta]) (-1+\[CapitalDelta]-2 \[Epsilon]) (l+2 \[Epsilon]))+(-19-12 n^2-3 \[CapitalDelta]^2-2 \[Epsilon]+2 \[CapitalDelta] (7+\[Epsilon])+4 n (7-3 \[CapitalDelta]+\[Epsilon])) (l^2+2 l \[Epsilon]+\[CapitalDelta] (\[CapitalDelta]-2 (1+\[Epsilon]))))/(4 n (-1+l+2 n+\[CapitalDelta]) (-1-l+2 n+\[CapitalDelta]-2 \[Epsilon]) (-1+n+\[CapitalDelta]-\[Epsilon]))};

zdermax=2nmax+mmax;


\[Rho]num=SetPrecision[3-2Sqrt[2],prec];

z=1/2; (*If we want to generate blocks at some other point this needs to be changed*)
coeffTab=SetNDer[zdermax,prec,z];

casCoeffs[m_,n_,\[Epsilon]_,l_]={-((m (2-3 m+m^2) )/(4 z^2 (-2+2 z))),-(((-1+m) m (-2+6 z) )/(4 z^2 (-2+2 z))),-(m (22+m^2+12 n^2+2 \[Epsilon]-2 n (17+2 \[Epsilon])+m (-13+12 n+2 \[Epsilon])))/(8 z^2 (-2+2 z) (-1+2 n+2 \[Epsilon])),(m (4-6 z) )/(2 z (-2+2 z)),1/(8 z^2 (-2+2 z) (-1+2 n+2 \[Epsilon])) (-2 z (3 m^2+2 (-1+n) (-5+6 n-2 \[Epsilon])+m (-27+24 n+2 (2+2 \[Epsilon])))+2 (m^2+m (-9+8 n)+2 (3+2 n^2-1/2 \[CapitalDelta] (-2+\[CapitalDelta]-2 \[Epsilon])+2 \[Epsilon]-n (5+2 \[Epsilon])-1/2 l (l+2 \[Epsilon])))),-(((-1+n) (-6+3 m+4 n-2 \[Epsilon]) )/(8 z^2 (-2+2 z) (-1+2 n+2 \[Epsilon]))),+((4 (-4+m+4 n)-2 z (-10+3 m+12 n+2 \[Epsilon])))/(4 z (-2+2 z) (-1+2 n+2 \[Epsilon])),-(((-1+n) (-2+6 z))/(8 z^2 (-2+2 z) (-1+2 n+2 \[Epsilon]))),+(1/(6-4 n-2 (2+2 \[Epsilon])))}//Simplify;

casInds[m_,n_]={{-3+m,n},{-2+m,n},{-1+m,-1+n},{-1+m,n}, {m,-1+n},{1+m,-2+n},{1+m,-1+n}, {2+m,-2+n},{2+m,-1+n}};

(*************************)





cn[n_]:=cn[n]=Chop[Apart[Expand[Sum[coeffs[n][[i]]cn[n-4+i],{i,3}]],\[CapitalDelta]]];
cn[0]=1;
cn[x_/;x<0]=0;

(* Recall, for identical scalar case, series in powers of rho^2n, hence the factor of 2 below*)
(* Power series are rho^\Delta Sum( cnrhoder[n,i] rho^(2n-i));  *)
(* fudge factor is required to prevent certain cancellations from occurring; otherwise different components will have different poles *)



cnRhoDer[n_,i_]:=cnRhoDer[n,i]=Expand[(\[CapitalDelta]+2n-(i-1)+fudge)cnRhoDer[n,i-1]]/.{\[CapitalDelta] r[1,a_]:>  1+ a r[1,a],\[CapitalDelta]^2 r[1,a_]:>  \[CapitalDelta]+a+ a^2 r[1,a]}/.{\[CapitalDelta] r[2,a_]:>  a r[2,a]+ r[1,a],\[CapitalDelta]^2 r[2,a_]:>  1+a^2 r[2,a]+2a r[1,a],\[CapitalDelta]^3 r[2,a_]->2a+\[CapitalDelta]+a^3 r[2,a]+3a^2 r[1,a]};
cnRhoDer[n_,0]:=cnRhoDer[n,0]=cn[n]/.{1/\[CapitalDelta]:>r[1,0],1/(a_+b_ \[CapitalDelta]):> 1/b r[1,-a/b],1/(a_+\[CapitalDelta]):> r[1,-a]}/.{Power[a_+b_ \[CapitalDelta],m_]:> 1/b^-m r[-m,-a/b],Power[a_+\[CapitalDelta],m_]:> r[-m,-a]};

t1=AbsoluteTiming[
Do[cn[k],{k,0,kmax}]];


(*Need to convert to z=zb derivatives (or more precisely the a derivatives *)
t2=AbsoluteTiming[
AllDer[ll,0,0]=(Sum[Expand[cn[k]\[Rho]num^(2k)],{k,0,kmax}]//Expand)/.{1/\[CapitalDelta]:>r[1,0],1/(a_+b_ \[CapitalDelta]):> 1/b r[1,-a/b],1/(a_+\[CapitalDelta]):> r[1,-a]}/.{Power[a_+b_ \[CapitalDelta],m_]:> 1/b^-m r[-m,-a/b],Power[a_+\[CapitalDelta],m_]:> r[-m,-a]}//Simplify;
];

t3=AbsoluteTiming[
Do[
AllDer[ll,m,0]=(1/2^m Sum[Expand[coeffTab[[m,i]]cnRhoDer[k,i]\[Rho]num^(2k-i)]/.{\[CapitalDelta] r[1,a_]:>  1+ a r[1,a],\[CapitalDelta]^2 r[1,a_]:>  \[CapitalDelta]+a+ a^2 r[1,a]}/.{\[CapitalDelta] r[2,a_]:>  a r[2,a]+ r[1,a],\[CapitalDelta]^2 r[2,a_]:>  1+a^2 r[2,a]+2a r[1,a],\[CapitalDelta]^3 r[2,a_]->2a+\[CapitalDelta]+a^3 r[2,a]+3a^2 r[1,a]},{k,0,kmax},{i,1,Length[coeffTab[[m]]]}]);
,{m,1,zdermax}];
];

(* Use Casimir rec *)
CRec[m_/;m<0,n_]:=0;
CRec[m_,n_/;n<0]:=0;
Do[CRec[m,0]=AllDer[ll,m,0],{m,0,zdermax}];

t4=AbsoluteTiming[
Do[
cs=casCoeffs[m,n,eps,ll]//Simplify;

AllDer[ll,m,n]=CRec[m,n]=Expand[Sum[cs[[i]]CRec@@casInds[m,n][[i]],{i,Length[cs]}]]/.{\[CapitalDelta] r[1,a_]:>  1+ a r[1,a],\[CapitalDelta]^2 r[1,a_]:>  \[CapitalDelta]+a+ a^2 r[1,a]}/.{\[CapitalDelta] r[2,a_]:>  a r[2,a]+ r[1,a],\[CapitalDelta]^2 r[2,a_]:>  1+a^2 r[2,a]+2a r[1,a],\[CapitalDelta]^3 r[2,a_]:>2a+\[CapitalDelta]+a^3 r[2,a]+3a^2 r[1,a]};
,{n,1,nmax},{m,0,2(nmax-n)+mmax}];
];
Clear[z];
Return[];
);
];




(* ::Subsubsection:: *)
(*GetData*)


GetDataN0[L_,\[Epsilon]_,nmax_,mmax_]:=Module[{tmp,Poles1,PoleCoeffs1,Poles2,PoleCoeffs2,cases1,cases2,Poly},(
Do[
tmp=2^(m+2n) AllDer[L,m,n]/.r[1,x_]->r1[x]/.r[2,x_]->r2[x]//Expand; (* The powers of 2 are to match Sheer and Slava's conventions. *)
(*Poly[m,n]=CoefficientList[tmp/.r1[x_]->0/.r2[x_]->0/.\[CapitalDelta]->\[CapitalDelta]+2\[Epsilon]+L,\[CapitalDelta]]/.a_/;MantissaExponent[a][[1]]==0.->0;*)

Poly[m,n]=CoefficientList[tmp/.r1[x_]->0/.r2[x_]->0,\[CapitalDelta]]/.a_/;MantissaExponent[a][[1]]==0.->0;


cases1=Cases[tmp,a_ r1[x_]];

Poles1[m,n]=cases1/.a_ r1[x_]->x;
PoleCoeffs1[m,n]=cases1/.a_ r1[x_]->a;

cases2=Cases[tmp,a_ r2[x_]];

Poles2[m,n]=cases2/.a_ r2[x_]->x;
PoleCoeffs2[m,n]=cases2/.a_ r2[x_]->a;



,{n,0,nmax},{m,0,2(nmax-n)+mmax}];

Return[{Poly,Poles1,PoleCoeffs1,Poles2,PoleCoeffs2}];

);
];


(* ::Title::Closed:: *)
(*Compute Functions*)


Options[ComputeTable]={kMax->60,Prec->64,AllSpins->False};
ComputeTable[Dim_,nmax_,mmax_,Lmax_,filename_,OptionsPattern[]]:=Module[{allspins,spinstep,eps,Lct,Res,t1,t2,t3,t4,t5,polylist,polelist1,polelist2,clist1,clist2,plen,LL,maxPolylength,L,\[CapitalDelta]0,Poly,Poles1,PoleCoeffs1,Poles2,PoleCoeffs2,file,prec,kmax},

prec=OptionValue[Prec];
kmax=OptionValue[kMax];
allspins=OptionValue[AllSpins];
spinstep=If[allspins,1,2];
eps=Rationalize[(Dim-2)/2];


Monitor[For[Lct=0,Lct<=Lmax,Lct+=spinstep,
Recurse[eps,Lct,prec,mmax,nmax,kmax];]
,Lct];

Res={};For[LL=0,LL<=Lmax,LL+=spinstep,
{Poly,Poles1,PoleCoeffs1,Poles2,PoleCoeffs2}=GetDataN0[LL,eps,nmax,mmax];
t1=Flatten[Table[Poly[m,n],{n,0,nmax},{m,0,2(nmax-n)+mmax}],1];
t2=DeleteDuplicates[Flatten[Table[Poles1[0,0],{n,0,nmax},{m,0,2(nmax-n)+mmax}]]];
t3=Flatten[Table[PoleCoeffs1[m,n],{n,0,nmax},{m,0,2(nmax-n)+mmax}],1];
t4=DeleteDuplicates[Flatten[Table[Poles2[0,0],{n,0,nmax},{m,0,2(nmax-n)+mmax}]]];
t5=Flatten[Table[PoleCoeffs2[m,n],{n,0,nmax},{m,0,2(nmax-n)+mmax}],1];


AppendTo[Res,{t1,t2,t3,t4,t5}];
];

plen=Length[Flatten[Table[0, {n,0,nmax},{m,0,mmax+2(nmax-n)}]]];
file=OpenWrite[filename];
Write[file,N[eps]];
Write[file, nmax];
Write[file, mmax];
Write[file,Lmax];
Write[file,0]; (* whether there are odd spins; 1 means yes, 0 means no *)
Write[file,Round[prec Log[2,10]]-1]; (*nr of binary digits of precision *)
Write[file,plen];

For[Lct=1,Lct<=Length[Res],Lct+=1,

polylist=Res[[Lct,1]];
polelist1=Res[[Lct,2]];
clist1=Res[[Lct,3]];
polelist2=Res[[Lct,4]];
clist2=Res[[Lct,5]];


plen=Length[Flatten[Table[0, {n,0,nmax},{m,0,mmax+2(nmax-n)}]]];
maxPolylength=Max[Table[Length[polylist[[i]]],{i,plen}]];
L=spinstep*(Lct-1);
\[CapitalDelta]0=2eps+L;

WriteString[file,ToString[CForm[N[\[CapitalDelta]0,prec]]]<>"\n"];
Write[file,maxPolylength];

Do[Map[WriteString[file,(ToString[CForm[#]]<>"\n")]&,PadRight[polylist[[i]],maxPolylength,0]];,{i,plen}];

Write[file,Length[polelist1]];
Map[WriteString[file,(ToString[CForm[#]]<>"\n")]&,N[polelist1,prec]];
Do[Map[WriteString[file,(ToString[CForm[#]]<>"\n")]&,clist1[[i]]];,{i,plen}];

Write[file,Length[polelist2]];
Map[WriteString[file,(ToString[CForm[#]]<>"\n")]&,N[polelist2,prec]];
Do[Map[WriteString[file,(ToString[CForm[#]]<>"\n")]&,clist2[[i]]];,{i,plen}];

];


Close[file];

];
