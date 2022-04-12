#contagem de numero de extraçoes ate obter todos os n elementos
f <- function(n){
    soma <- 0
    contagem <- 0
    simlist <- numeric(n)
while (soma < n) {
    trial <- sample(1:n, 1, replace = T)
    contagem <- contagem+1
    if(simlist[trial] != trial){
        simlist[trial] <- trial
        soma <- soma+1
    }
}
return(contagem)
}