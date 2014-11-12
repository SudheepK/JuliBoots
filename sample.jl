module sample
using various
using main

sigma=BigFloat(0.518)
prob=setupLP(sigma,"./Tables/eps0.5n3m1_allspins_prec80.txt")
prob2=main.mcopy(prob)
prob2=dropOdd!(prob2)

result=bissect(prob2,3,1,1e-15,"L=0",method="mrc")


end
